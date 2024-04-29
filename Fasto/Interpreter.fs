(* An interpreter for Fasto. *)

module Interpreter

(*

An interpreter executes a (Fasto) program by inspecting the abstract syntax
tree of the program, and doing what needs to be done in another programming
language (F#).

As mentioned in AbSyn.fs, some Fasto expressions are implicitly typed. The
interpreter infers the missing types, and checks the types of the operands
before performing any Fasto operation. Some type errors might still occur though.

Any valid Fasto program must contain a "main" function, which is the entry
point of the program. The return value of this function is the result of the
Fasto program.

The main function of interest in this module is:

  val evalProg : AbSyn.UntypedProg -> AbSyn.Value

*)

open System
open AbSyn

(* An exception for reporting run-time errors. *)
exception MyError of string * Position

type FunTable = SymTab.SymTab<UntypedFunDec>
type VarTable = SymTab.SymTab<Value>

(* Build a function table, which associates a function names with function
   declarations. *)
let rec buildFtab (fdecs : UntypedFunDec list) : FunTable =
  match fdecs with
  | [] -> let p  = (0, 0)
          let ch = 'a'
          let fdec_chr = FunDec ("chr", Char, [Param ("n", Int) ], Constant (CharVal ch, p), p)
          let fdec_ord = FunDec ("ord", Int,  [Param ("c", Char)], Constant (IntVal   1, p), p)
          SymTab.fromList [("chr", fdec_chr); ("ord", fdec_ord)]
  | ( fdcl::fs ) ->
    (* Bind the user-defined functions, in reverse order. *)
    let fid   = getFunName fdcl
    let pos   = getFunPos fdcl
    let ftab  = buildFtab fs
    match SymTab.lookup fid ftab with
      | None        -> SymTab.bind fid fdcl ftab
      | Some ofdecl ->
          (* Report the first occurrence of the name. *)
          raise (MyError ("Already defined function: "+fid, getFunPos ofdecl))

(* Check whether a value matches a type. *)
let rec typeMatch (tpval : Type * Value) : bool =
    match tpval with
      | ( Int,  IntVal _ ) -> true
      | ( Bool, BoolVal _) -> true
      | ( Char, CharVal _) -> true
      | ( Array t, ArrayVal (vals, tp) ) ->
        (t = tp) && (List.map (fun value -> typeMatch (t, value)) vals |> List.fold (&&) true)
      | (_, _) -> false

let reportBadType (str : string)
                  (want : string)
                  (v    : Value)
                  (pos  : Position) =
    let msg = "Bad type for " + str + ": expected " + want + ", but got " +
              ppType (valueType v) + " (" + (ppVal 0 v) + ")"
    raise (MyError(msg, pos))

let reportWrongType str tp v pos = reportBadType str (ppType tp) v pos

let reportNonArray str v pos = reportBadType str "an array" v pos

(* Bind the formal parameters of a function declaration to actual parameters in
   a new vtab. *)

let rec bindParams (fargs : Param list)
                   (aargs : Value list)
                   (fid   : String)
                   (pdec  : Position)
                   (pcall : Position) : VarTable =
  match (fargs, aargs) with
  | ([], []) -> SymTab.empty ()
  | (Param (faid, fatp) :: fargs, v :: aargs) ->
      let vtab = bindParams fargs aargs fid pdec pcall
      if typeMatch(fatp, v)
        then match SymTab.lookup faid vtab with
               None   -> SymTab.bind faid v vtab
             | Some m -> raise (MyError( "Formal argument is already in symbol table!"+
                                         " In function: "+fid+" formal argument: "+faid
                                       , pdec ))
        else reportWrongType ("argument " + faid + " of function " + fid)
                            fatp v pcall
  | (_, _) -> raise (MyError("Number of formal and actual params do not match in call to "+fid,
                             pcall))


(* Interpreter for Fasto expressions:
    1. vtab holds bindings between variable names and
       their interpreted value (Fasto.Value).
    2. ftab holds bindings between function names and
       function declarations (Fasto.FunDec).
    3. Returns the interpreted value. *)
let rec evalExp (e : UntypedExp, vtab : VarTable, ftab : FunTable) : Value =
  match e with
  | Constant (v,_) -> v
  | ArrayLit (l, t, pos) ->
        let els = (List.map (fun x -> evalExp(x, vtab, ftab)) l)
        let elt = match els with
                    | []   -> Int (* Arbitrary *)
                    | v::_ -> valueType v
        ArrayVal (els, elt)
  | StringLit(s, pos) ->
        let cvs = List.map (fun c -> CharVal c) (Seq.toList s)
        ArrayVal (cvs, Char)
  | Var(id, pos) ->
        let res = SymTab.lookup id vtab
        match res with
          | None   -> raise (MyError("Unknown variable "+id, pos))
          | Some m -> m
  | Plus(e1, e2, pos) ->
        let res1   = evalExp(e1, vtab, ftab)
        let res2   = evalExp(e2, vtab, ftab)
        match (res1, res2) with
          | (IntVal n1, IntVal n2) -> IntVal (n1+n2)
          | (IntVal _, _) -> reportWrongType "right operand of +" Int res2 (expPos e2)
          | (_, _) -> reportWrongType "left operand of +" Int res1 (expPos e1)
  | Minus(e1, e2, pos) ->
        let res1   = evalExp(e1, vtab, ftab)
        let res2   = evalExp(e2, vtab, ftab)
        match (res1, res2) with
          | (IntVal n1, IntVal n2) -> IntVal (n1-n2)
          | (IntVal _, _) -> reportWrongType "right operand of -" Int res2 (expPos e2)
          | (_, _) -> reportWrongType "left operand of -" Int res1 (expPos e1)
  (* TODO: project task 1:
     Look in `AbSyn.fs` for the arguments of the `Times`
     (`Divide`,...) expression constructors.
        Implementation similar to the cases of Plus/Minus.
        Try to pattern match the code above.
        For `Divide`, remember to check for attempts to divide by zero.
        For `And`/`Or`: make sure to implement the short-circuit semantics,
        e.g., `And (e1, e2, pos)` should not evaluate `e2` if `e1` already
              evaluates to false.
  *)
  | Times(_, _, _) ->
        failwith "Unimplemented interpretation of multiplication"
  | Divide(_, _, _) ->
        failwith "Unimplemented interpretation of division"
  | And (_, _, _) ->
        failwith "Unimplemented interpretation of &&"
  | Or (_, _, _) ->
        failwith "Unimplemented interpretation of ||"
  | Not(_, _) ->
        failwith "Unimplemented interpretation of not"
  | Negate(_, _) ->
        failwith "Unimplemented interpretation of negate"
  | Equal(e1, e2, pos) ->
        let r1 = evalExp(e1, vtab, ftab)
        let r2 = evalExp(e2, vtab, ftab)
        match (r1, r2) with
          | (IntVal  n1, IntVal  n2) -> BoolVal (n1 = n2)
          | (BoolVal b1, BoolVal b2) -> BoolVal (b1 = b2)
          | (CharVal c1, CharVal c2) -> BoolVal (c1 = c2)
          | (ArrayVal _, _) -> reportBadType "left operand of =" "a base type" r1 pos
          | (_, _) -> reportWrongType "right operand of =" (valueType r1) r2 pos
  | Less(e1, e2, pos) ->
        let r1 = evalExp(e1, vtab, ftab)
        let r2 = evalExp(e2, vtab, ftab)
        match (r1, r2) with
          | (IntVal  n1,    IntVal  n2  ) -> BoolVal (n1 < n2)
          | (BoolVal false, BoolVal true) -> BoolVal true
          | (BoolVal _,     BoolVal _   ) -> BoolVal false
          | (CharVal c1,    CharVal c2  ) -> BoolVal ( (int c1) < (int c2) )
          | (ArrayVal _, _) -> reportBadType "left operand of <" "a base type" r1 pos
          | (_, _) -> reportWrongType "right operand of <" (valueType r1) r2 pos
  | If(e1, e2, e3, pos) ->
        let cond = evalExp(e1, vtab, ftab)
        match cond with
          | BoolVal true  -> evalExp(e2, vtab, ftab)
          | BoolVal false -> evalExp(e3, vtab, ftab)
          | other         -> reportWrongType "if condition" Bool cond (expPos e1)
  | Apply(fid, args, pos) ->
        let evargs = List.map (fun e -> evalExp(e, vtab, ftab)) args
        match (SymTab.lookup fid ftab) with
          | Some f -> callFunWithVtable(f, evargs, SymTab.empty(), ftab, pos)
          | None   -> raise (MyError("Call to unknown function "+fid, pos))
  | Let(Dec(id,e,p), exp, pos) ->
        let res   = evalExp(e, vtab, ftab)
        let nvtab = SymTab.bind id res vtab
        evalExp(exp, nvtab, ftab)
  | Index(id, e, tp, pos) ->
        let indv = evalExp(e, vtab, ftab)
        let arr = SymTab.lookup id vtab
        match (arr, indv) with
          | (None, _) -> raise (MyError("Unknown array variable "+id, pos))
          | (Some (ArrayVal(lst, tp)), IntVal ind) ->
               let len = List.length lst
               if 0 <= ind && ind < len
               then lst.Item ind
               else let msg = sprintf "Array index out of bounds! Array length: %i, index: %i" len ind
                    raise (MyError( msg, pos ))
          | (Some m, IntVal _) -> reportNonArray ("indexing into " + id) m pos
          | (_, _) -> reportWrongType "indexing expression" Int indv pos
  | Iota (e, pos) ->
        let sz = evalExp(e, vtab, ftab)
        match sz with
          | IntVal size ->
              if size >= 0
              then ArrayVal( List.map (fun x -> IntVal x) [0..size-1], Int )
              else let msg = sprintf "Argument of \"iota\" is negative: %i" size
                   raise (MyError(msg, pos))
          | _ -> reportWrongType "argument of \"iota\"" Int sz pos
  | Length (e, _, pos) ->
        let arr = evalExp(e, vtab, ftab)
        match arr with
          | ArrayVal (lst, _) -> IntVal (List.length lst)
          | _ -> reportNonArray "argument of \"length\"" arr pos
  | Map (farg, arrexp, _, _, pos) ->
        let arr  = evalExp(arrexp, vtab, ftab)
        let farg_ret_type = rtpFunArg farg ftab pos
        match arr with
          | ArrayVal (lst,tp1) ->
               let mlst = List.map (fun x -> evalFunArg (farg, vtab, ftab, pos, [x])) lst
               ArrayVal (mlst, farg_ret_type)
          | otherwise -> reportNonArray "2nd argument of \"map\"" arr pos
  | Reduce (farg, ne, arrexp, tp, pos) ->
        let farg_ret_type = rtpFunArg farg ftab pos
        let arr  = evalExp(arrexp, vtab, ftab)
        let nel  = evalExp(ne, vtab, ftab)
        match arr with
          | ArrayVal (lst,tp1) ->
               List.fold (fun acc x -> evalFunArg (farg, vtab, ftab, pos, [acc;x])) nel lst
          | otherwise -> reportNonArray "3rd argument of \"reduce\"" arr pos
  (* TODO project task 2: `replicate(n, a)`
     Look in `AbSyn.fs` for the arguments of the `Replicate`
     (`Map`,`Scan`) expression constructors.
       - evaluate `n` then evaluate `a`,
       - check that `n` evaluates to an integer value >= 0
       - If so then create an array containing `n` replicas of
         the value of `a`; otherwise raise an error (containing
         a meaningful message).
  *)
  | Replicate (_, _, _, _) ->
        failwith "Unimplemented interpretation of replicate"

  (* TODO project task 2: `filter(p, arr)`
       pattern match the implementation of map:
       - evaluate `arr` and check that the (value) result corresponds to an array;
       - use F# `List.filter` to keep only the elements `a` of `arr` which succeed
         under predicate `p`, i.e., `p(a) = true` (but remember to check
         that the return value is a boolean at all);
       - create an `ArrayVal` from the (list) result of the previous step.
  *)
  | Filter (_, _, _, _) ->
        failwith "Unimplemented interpretation of filter"

  (* TODO project task 2: `scan(f, ne, arr)`
     Implementation similar to reduce, except that it produces an array
     of the same type and length to the input array `arr`.
  *)
  | Scan (_, _, _, _, _) ->
        failwith "Unimplemented interpretation of scan"

  | Read (t,p) ->
        let str = Console.ReadLine()
        match t with
          | Int -> let v : int = int str
                   IntVal v
          | Char -> let v : char = char str
                    CharVal v
          | otherwise -> raise (MyError("Read operation is valid only on int and char types ", p))

  | Write(exp,t,p) ->
        let v  = evalExp(exp, vtab, ftab)
        match v with
          | IntVal  n -> printfn "%i " n
          | BoolVal b -> let res = if(b) then "true " else "false "
                         printfn "%s" res
          | CharVal c -> printfn "%c " c
          | ArrayVal (a, Char) ->
             let mapfun = function
                   | CharVal c -> c
                   | otherwise -> raise (MyError("Write argument " +
                                                   ppVal 0 v +
                                                   " should have been evaluated to string", p))
             printfn "%s" ( System.String.Concat (List.map mapfun a) )
          | otherwise -> raise (MyError("Write can be called only on basic and array(char) types ", p))
        v



(* finds the return type of a function argument *)
and rtpFunArg  (funarg  : UntypedFunArg)
               (ftab    : FunTable)
               (callpos : Position)
             : Type =
  match funarg with
    | FunName fid ->
        match SymTab.lookup fid ftab with
          | None   -> raise (MyError("Unknown argument function "+fid, callpos))
          | Some (FunDec (_, rettype, _, _, _)) -> rettype
    | Lambda (rettype, _, _, _) -> rettype

(* evalFunArg takes as argument a FunArg, a vtable, an ftable, the
position where the call is performed, and the list of actual arguments.
It returns the result of calling the (lambda) function.
 *)
and evalFunArg  ( funarg  : UntypedFunArg
                , vtab    : VarTable
                , ftab    : FunTable
                , callpos : Position
                , aargs   : Value list
                ) : Value =
  match funarg with
  | (FunName fid) ->
    let fexp = SymTab.lookup fid ftab
    match fexp with
      | None   -> raise (MyError("Call to unknown argument function "+fid, callpos))
      | Some f -> callFunWithVtable(f, aargs, SymTab.empty(), ftab, callpos)
  | Lambda (rettype, parms, body, fpos) ->
    callFunWithVtable ( FunDec ("<anonymous>", rettype, parms, body, fpos)
                      , aargs, vtab, ftab, callpos )

(* Interpreter for Fasto function calls:
    1. f is the function declaration.
    2. args is a list of (already interpreted) arguments.
    3. vtab is the variable symbol table
    4. ftab is the function symbol table (containing f itself).
    5. pcall is the position of the function call. *)
and callFunWithVtable (fundec : UntypedFunDec
                      , aargs : Value list
                      , vtab  : VarTable
                      , ftab  : FunTable
                      , pcall : Position
                      ) : Value =
    let (FunDec (fid, rtp, fargs, body, pdcl)) = fundec
    match fid with
      (* treat the special functions *)
      | "ord" -> match aargs with
                   | [CharVal c] -> IntVal (int c)
                   | [v] -> reportWrongType "argument of \"ord\"" Char v pcall
                   | _ -> raise (MyError ("Wrong argument count for \"ord\"", pcall))
      | "chr" -> match aargs with
                    | [IntVal n] -> CharVal (char n)
                    | [v] -> reportWrongType "argument of \"chr\"" Int v pcall
                    | _ -> raise (MyError ("Wrong argument count for \"chr\"", pcall))
      | _ ->
        let vtab' = SymTab.combine (bindParams fargs aargs fid pdcl pcall) vtab
        let res  = evalExp (body, vtab', ftab)
        if typeMatch (rtp, res)
        then res
        else reportWrongType ("result of function \"" + fid + "\"") rtp res pcall

(* Interpreter for Fasto programs:
    1. builds the function symbol table,
    2. interprets the body of "main", and
    3. returns its result. *)
and evalProg (prog : UntypedProg) : Value =
    let ftab  = buildFtab prog
    let mainf = SymTab.lookup "main" ftab
    match mainf with
      | None   -> raise (MyError("Could not find the main function", (0,0)))
      | Some m ->
          match getFunArgs m with
            | [] -> callFunWithVtable(m, [], SymTab.empty(), ftab, (0,0))
            | _  -> raise (MyError("The main function is not allowed to have parameters", getFunPos m))
