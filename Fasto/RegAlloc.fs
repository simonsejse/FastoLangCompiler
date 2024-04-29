(* A register allocator for RISC-V (adapted from MIPS). *)

module RegAlloc

(* registerAlloc takes a list of RISC-V instructions, a set of
   registers that are live at the end of the code, three register
   numbers:
     1) The lowest allocatable register.
     2) The highest caller-saves register.
     3) The highest allocatable register).
   and the number of already spilled variables.  This should be 0 in the initial
   call unless some variables are forced to spill before register allocation.
   Registers up to (and including) the highest caller-saves
   register are assumed to be caller-saves. Those above are assumed to
   be callee-saves.

   registerAlloc returns:
   a modified instruction list where null moves have been removed,
   a set of the variables that are live at entry,
   plus a number indicating the highest used register number.

   The latter can be used for deciding which callee-saves registers
   need to be saved.

   Limitations:

    - Works for a single procedure body only.

    - Assumes all JALs eventually return to the next instruction and
      preserve callee-saves registers when doing so.

    - Does caller-saves preservation only by allocating variables that
      are live across procedure calls to callee-saves registers and
      variables not live across call preferably to caller-saves.

    - Can only remove null moves if they are implemented by the
      pseudo-instruction MV(rx,ry).

*)

open RiscV

exception MyError of string

exception Not_colourable of string

let spilledVars : Set<string> ref = ref (Set.empty)

let rec destRegs (lst : Instruction list) : Set<reg> =
  match lst with
    | [] -> Set.empty
    | (i::ilist) -> Set.union (destReg i) (destRegs ilist)


(* variables and registers that can be overwritten *)
and destReg (i : Instruction) : Set<reg> =
  match i with
  | LA (rd,_)
  | LI (rd,_)
  | MV (rd,_)
  | ADD (rd,_,_)
  | ADDI (rd,_,_)
  | SUB (rd,_,_)
  | MUL (rd,_,_)
  | DIV (rd,_,_)
  | AND (rd,_,_)
  | ANDI (rd,_,_)
  | OR (rd,_,_)
  | ORI (rd,_,_)
  | XOR (rd,_,_)
  | XORI (rd,_,_)
  | SLLI (rd,_,_)
  | SRAI (rd,_,_)
  | SLT (rd,_,_)
  | SLTI (rd,_,_) -> Set.singleton rd
  | JAL (lab,argRegs) -> Set.ofList [Rra; Rrv]
  | LW (rd,_,_)
  | LB (rd,_,_)
  | LBU (rd,_,_)   -> Set.singleton rd
  | ECALL        -> Set.singleton Rrv
  | _ -> Set.empty

(* variables and register that can be read by i *)
let usedRegs (i : Instruction) : Set<reg> =
  match i with
  | MV(_, rs) -> Set.singleton rs
  | ADD (_,rs,rt) -> Set.ofList [rs;rt]
  | ADDI (_,rs,v) -> Set.singleton rs
  | SUB (_,rs,rt) -> Set.ofList [rs;rt]
  | MUL (_,rs,rt) -> Set.ofList [rs;rt]
  | DIV (_,rs,rt) -> Set.ofList [rs;rt]
  | AND (_,rs,rt) -> Set.ofList [rs;rt]
  | ANDI (_,rs,v) -> Set.singleton rs
  | OR (_,rs,rt) -> Set.ofList [rs;rt]
  | ORI (_,rs,v) -> Set.singleton rs
  | XOR (_,rs,rt) -> Set.ofList [rs;rt]
  | XORI (_,rs,v) -> Set.singleton rs
  | SLLI (_,rt,v) -> Set.singleton rt
  | SRAI (_,rt,v) -> Set.singleton rt
  | SLT (_,rs,rt) -> Set.ofList [rs;rt]
  | SLTI (_,rs,v) -> Set.singleton rs
  | BEQ (rs,rt,lab) -> Set.ofList [rs;rt]
  | BNE (rs,rt,lab) -> Set.ofList [rs;rt]
  | BLT (rs,rt,lab) -> Set.ofList [rs;rt]
  | BGE (rs,rt,lab) -> Set.ofList [rs;rt]
  | J lab -> Set.empty
  | JAL (lab,argRegs) -> Set.ofList argRegs
                (* argRegs are argument registers *)
  | JR (r,resRegs) -> Set.ofList (r::resRegs)
                (* r is jump register,
                   resRegs are registers required to be live *)
  | LW (_,rs,v) -> Set.singleton rs
  | LB (_,rs,v) -> Set.singleton rs
  | LBU (_,rs,v) -> Set.singleton rs
  | SW (rd,rs,v) -> Set.ofList [rs;rd]
  | SB (rd,rs,v) -> Set.ofList [rs;rd]
  | ECALL -> Set.ofList [Rsn; Ra0] // all the syscalls we use take only one param
  | _ -> Set.empty


let live_step ilist llist liveAtEnd =
  let rec scan (is : Instruction list) =
    match is with
      | [] -> []
      | (i::is) ->
          let ls1 = scan is
          if   List.isEmpty ls1
          then [instruct i liveAtEnd]
          else (instruct i (List.head ls1)) :: ls1

   (* live variables and registers *)
   // live is set of liveVars of next instruction
  and instruct (i : Instruction) (live : Set<reg>) : Set<reg> =
    let liveSuccs =
          match i with
            | BEQ (_,_,lab)
            | BNE (_,_,lab)
            | BLT (_,_,lab)
            | BGE (_,_,lab) -> Set.union live (live_at lab)
            | J lab -> live_at lab
            | JR (_,_) -> Set.empty
            | _ -> live
    Set.union (usedRegs i) (Set.difference liveSuccs (destReg i))

  and live_at lab : Set<reg> = search ilist llist lab

  and search a1 a2 a3 : Set<reg> =
    match (a1, a2, a3) with
      | ([], [], lab) -> Set.empty
      | (LABEL k :: is, l::ls, lab) ->
          if k = lab then l else search is ls lab
      | (_::is, _::ls, lab) -> search is ls lab
      | (a, b, l) -> raise (MyError "should not happen in RegAlloc.live_step.search!")

  let res = scan ilist
  res

let rec iterate_live ilist llist liveAtEnd =
  let  llist1 = live_step ilist llist liveAtEnd
  if   llist1 = llist
  then llist
  else iterate_live ilist llist1 liveAtEnd

(* live_regs finds for each instruction those symbolic register names *)
(* that are live at entry to this instruction *)

let live_regs ilist liveAtEnd =
      iterate_live ilist (List.map (fun i -> Set.empty) ilist) liveAtEnd

let numerical r =
  match r with
    | RN _ -> true
    | RS _ -> false

let filterSymbolic rs = Set.filter (fun a -> not (numerical a)) rs

let rec findRegs llist = filterSymbolic (Set.unionMany llist)

(* conflicts ilist llist callerSaves r *)
(* finds those variables that interferere with r *)
(* in instructions ilist with live-out specified by llist *)
(* callerSaves are the caller-saves registers *)

let rec conflicts = function
  | ([], [], callerSaves, RN r) -> Set.remove (RN r) callerSaves
                (* all numerical interfere with all other caller-saves *)
  | ([], [], callerSaves, RS _) -> Set.empty
  | (MV (rd,rs) :: ilist, l :: llist, callerSaves, r) ->
      if r=rd  (* if destination *)
      then Set.union (Set.remove rs (Set.remove r l)) (* interfere with live except rs *)
                     (conflicts (ilist, llist, callerSaves, r))
      else if r=rs  (* if source, no interference *)
      then conflicts (ilist, llist, callerSaves, r)
      else if Set.contains r l (* otherwise, live interfere with rd *)
      then Set.add rd (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | (JAL (f,argRegs) :: ilist, l :: llist, callerSaves, r) ->
      if (Set.contains r l)  (* live vars interfere with caller-saves regs *)
      then Set.union (Set.remove r callerSaves)
                     (conflicts (ilist, llist, callerSaves, r))
      else if Set.contains r callerSaves
      then Set.union (Set.remove r l)
                     (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | (i :: ilist, l :: llist, callerSaves, r) ->
      if (Set.contains r (destReg i)) (* destination register *)
      then Set.union (Set.remove r l)   (* conflicts with other live vars *)
                     (conflicts (ilist, llist, callerSaves, r))
      else if Set.contains r l        (* all live vars *)
      then Set.union (destReg i)    (* conflict with destination *)
                     (conflicts (ilist, llist, callerSaves, r))
      else conflicts (ilist, llist, callerSaves, r)
  | _ -> raise (MyError "conflicts used at undefined instance")



(* Interference graph is represented as a list of registers *)
(* each paired with a list of the registers with which it conflicts *)

let graph ilist llist callerSaves =
  let rs = Set.union callerSaves (findRegs llist) |> Set.toList
  List.zip rs (List.map (fun r -> conflicts (ilist, ((List.tail llist)@[Set.empty]), callerSaves, r)) rs)

(* finds move-related registers *)
let rec findMoves ilist llist =
  let rs = findRegs llist |> Set.toList
  List.zip rs (List.map (fun r -> findMoves1 r ilist) rs)

and findMoves1 r = function
  | [] -> Set.empty
  | (MV (rd,rs) :: ilist) ->
      Set.union  ( if   rd=r then Set.singleton rs
                   elif rs=r then Set.singleton rd
                   else Set.empty)
                 (findMoves1 r ilist)
  | (i::ilist) -> findMoves1 r ilist


(* sorts by number of conflicts, but with numeric registers last *)

let be4 (a, ac) (b, bc) =
    match (a, b) with
      | (RN i, RN j) -> i <= j
      | (RN _, RS _) -> false
      | (RS _, RN _) -> true
      | (RS sa, RS sb) ->
         match (Set.contains sa (!spilledVars), Set.contains sb (!spilledVars)) with
           | (false, false) -> Set.count ac <= Set.count bc
           | (true , false) -> false
           | (false, true ) -> true
           | (true , true ) -> Set.count ac <= Set.count bc

let rec sortByOrder = function
  | [] -> []
  | (g : (reg * Set<'b>) list) ->
     let rec split = function
       | [] -> ([],[])
       | (a::g) ->
         let (l, g1) = ascending a g []
         let (g2,g3) = split g1
         (rev2 l g3, g2)
     and ascending a g l =
       match g with
         | [] -> (a::l,[])
         | (b::g1) ->
               if be4 a b
               then ascending b g1 (a::l)
               else (a::l,g)
     and rev2 g l2 =
       match g with
         | [] -> l2
         | (a::l1) -> rev2 l1 (a::l2)

     let rec merge = function
        | ([], l2) -> l2
        | (l1, []) -> l1
        | (a::r1, b::r2) ->
               if be4 a b
               then a :: merge (r1, b::r2)
               else b :: merge (a::r1, r2)

     let (g1,g2) = split g
     if   List.isEmpty g1 then g2
     elif List.isEmpty g2 then g1
     else merge (sortByOrder g1, sortByOrder g2)



(* n-colour graph using Briggs' algorithm *)

let rec colourGraph g rmin rmax moveRelated =
  select (simplify (sortByOrder g) [])
         (mList rmin rmax) moveRelated []

and simplify h l =
    match h with
      | [] -> l
      | (r,c) :: g ->
        simplify (sortByOrder (removeNode r g)) ((r,c)::l)

and removeNode r = function
    | [] -> []
    | ((r1,c)::g) ->
      (r1,Set.remove r c) :: removeNode r g

and select rcl regs moveRelated sl =
    match rcl with
      | [] -> sl
      | ((r,c)::l) ->
        let rnum =
            if numerical r then r
            else let possible = NotIn c sl regs
                 let related  = lookUp2 r moveRelated
                 let related2 = Set.map (fun r -> lookUp r sl) related
                 let mPossible= Set.intersect possible related2
                 if Set.isEmpty possible then raise (Not_colourable (ppReg r))
                 elif Set.isEmpty mPossible then Set.minElement possible //hd possible
                 else Set.minElement mPossible //hd mPossible
        select l regs moveRelated ((r,rnum)::sl)

and NotIn rcs sl regs : Set<reg> =
    Set.fold (fun acc r -> Set.remove (lookUp r sl) acc) regs rcs

and lookUp r = function
    | [] -> RN 0
    | ((r1,n)::sl) ->
      if numerical r then r
      else if r=r1 then n else lookUp r sl

and lookUp2 r = function
    | [] -> Set.empty
    | ((r1,ms)::sl) -> if r=r1 then ms else lookUp2 r sl

and mList m n : Set<reg> =
  if m > n then Set.empty
  else Set.add (RN m) (mList (m+1) n)


let rec filterNullMoves ilist allocs =
    match ilist with
      | [] -> []

      | (MV (rd,rs) :: ilist_tl) ->
        let rd1 = lookUp rd allocs
        let rs1 = lookUp rs allocs
        if rd1 = rs1 || rd1 = RN 0
        then COMMENT ("\tmv\t"+ ppReg rd+","+ ppReg rs)
             :: filterNullMoves ilist_tl allocs
        else MV (rd,rs) :: filterNullMoves ilist_tl allocs

      | (i :: ilist_tl) ->
        i :: filterNullMoves ilist_tl allocs

let rec printGraph = function
  | []            -> []
  | ((r,rs) :: g) ->
     [COMMENT ("interferes: " + r + " with " + String.concat " " rs)]
     @ printGraph g

let renameReg allocs inst =
    let renTo inst1 = [inst1; COMMENT ("was:" + ppInst inst)]
    let look r = lookUp r allocs
    match inst with
    | LA (rt,l) ->      renTo (LA (look rt, l))
    | LI (rt,v) ->      renTo (LI (look rt, v))
    | MV (rd,rs) ->     renTo (MV (look rd, look rs))
    | ADD (rd,rs,rt) -> renTo (ADD (look rd, look rs, look rt))
    | ADDI (rd,rs,v) -> renTo (ADDI (look rd, look rs, v))
    | SUB (rd,rs,rt) -> renTo (SUB (look rd, look rs, look rt))
    | MUL (rd,rs,rt) -> renTo (MUL (look rd, look rs, look rt))
    | DIV (rd,rs,rt) -> renTo (DIV (look rd, look rs, look rt))
    | AND (rd,rs,rt) -> renTo (AND (look rd, look rs, look rt))
    | ANDI (rd,rs,v) -> renTo (ANDI (look rd, look rs, v))
    | OR (rd,rs,rt) ->  renTo (OR (look rd, look rs, look rt))
    | ORI (rd,rs,v) ->  renTo (ORI (look rd, look rs, v))
    | XOR (rd,rs,rt) -> renTo (XOR (look rd, look rs, look rt))
    | XORI (rd,rs,v) -> renTo (XORI (look rd, look rs, v))
    | SLLI (rd,rt,v) -> renTo (SLLI (look rd, look rt, v))
    | SRAI (rd,rt,v) -> renTo (SRAI (look rd, look rt, v))
    | SLT (rd,rs,rt) -> renTo (SLT (look rd, look rs, look rt))
    | SLTI (rd,rs,v) -> renTo (SLTI (look rd, look rs, v))
    | BEQ (rs,rt,l) ->  renTo (BEQ (look rs, look rt, l))
    | BNE (rs,rt,l) ->  renTo (BNE (look rs, look rt, l))
    | BLT (rs,rt,l) ->  renTo (BLT (look rs, look rt, l))
    | BGE (rs,rt,l) ->  renTo (BGE (look rs, look rt, l))
    | JAL (lab,argRegs) ->
        [JAL (lab, List.map look argRegs);
         COMMENT ("was:" + ppInst inst +
                    ", " + String.concat " " (List.map ppReg argRegs))]
    | JR (r, resRegs) ->
        [JR (look r, List.map look resRegs);
         COMMENT ("was:" + ppInst inst +
                    ", " + String.concat " " (List.map ppReg resRegs))]
    | LW (rd,rs,v) -> renTo (LW (look rd, look rs, v))
    | SW (rd,rs,v) -> renTo (SW (look rd, look rs, v))
    | LB (rd,rs,v) -> renTo (LB (look rd, look rs, v))
    | LBU (rd,rs,v) -> renTo (LBU (look rd, look rs, v))
    | SB (rd,rs,v) -> renTo (SB (look rd, look rs, v))
    | _ -> [inst]

let spill1 i r offset =
  let d = destReg i
  let u = usedRegs i
  let hdlst = if   Set.contains r u
              then [LW (r, Rsp, offset)]
              else []
  let tllst = if   Set.contains r d
              then [SW (r, Rsp, offset)]
              else []
  hdlst @ [i] @ tllst

let rec spill ilist r offset =
    match ilist with
      | []      -> []
      | (i::is) -> spill1 i r offset @ spill is r offset

let rec maxreg lst m =
    match lst with
      | [] -> m
      | ((r,RN n)::rs) -> maxreg rs (if m < n then n else m)
      | ((_,RS _)::rs) -> raise (MyError "maxreg of non-numeric register")

(* arguments:
   ilist is list of instructions
   liveAtEnd is a set of variables that are live at the end of ilist
   rmin is first allocable register (caller-saves)
   callerMax is highest caller-saves register
   rmax is highest allocable register
   spilled is number of registers spilled so far -- should be 0 initially
*)
let rec registerAlloc (ilist : Instruction list)
                      (liveAtEnd : Set<reg>)
                      (rmin : int)
                      (callerMax : int)
                      (rmax : int)
                      (spilled : int)
                    : (Instruction list * Set<reg> * int * int) =
  try
//    printfn "calling regalloc, #spilled = %d spilled\n" spilled
    let llist = live_regs ilist liveAtEnd
    let callerSaves = mList rmin callerMax
    let iGraph = graph ilist llist callerSaves
    let moveRelated = findMoves ilist llist
    let allocs = colourGraph iGraph rmin rmax moveRelated
    let deadRegs = Set.difference (filterSymbolic (destRegs ilist))
                                  ( (List.map (fun (x,_) -> x) allocs) |> Set.ofList )
    let allocs1 = allocs @ (List.map (fun r -> (r, RN 0)) (Set.toList deadRegs))
    let ilist1 = filterNullMoves ilist allocs1
    let ilist2 = List.concat (List.map (renameReg allocs1) ilist1)
    (ilist2, List.head llist, maxreg allocs 0, spilled)
  with
    | (Not_colourable sr) ->
//      printfn "%s spilled to %d\n" sr (4*spilled)
        spilledVars := Set.add sr (!spilledVars)
        let offset = (4*spilled)
        let ilist' = spill ilist (RS sr) offset
        let ilist'' = [SW (RS sr, Rsp, offset)] //FIX: may be uninit'd
                        @ ilist' @
                        (if Set.contains (RS sr) liveAtEnd
                         then [LW (RS sr, Rsp, offset)]
                         else [])
        registerAlloc ilist' liveAtEnd rmin callerMax rmax (spilled + 1)
