(* A type-checker for Fasto. *)

module TypeChecker

(*

A type-checker checks that all operations in a (Fasto) program are performed on
operands of an appropriate type. Furthermore, a type-checker infers any types
missing in the original program text, necessary for well-defined machine code
generation.

The main function of interest in this module is:

  val checkProg : Fasto.UnknownTypes.Prog -> Fasto.KnownTypes.Prog

*)

open AbSyn

(* An exception for reporting type errors. *)
exception MyError of string * Position

type FunTable = SymTab.SymTab<(Type * Type list * Position)>
type VarTable = SymTab.SymTab<Type>


(* Table of predefined conversion functions *)
let initFunctionTable : FunTable =
    SymTab.fromList
        [( "chr", (Char, [Int], (0,0)));
         ( "ord", (Int, [Char], (0,0)))
        ]

(* Pretty-printer for function types, for error messages *)
let showFunType (args : Type list, res : Type) : string =
  match args with
    | []   -> " () -> " + ppType res
    | args -> (String.concat " * " (List.map ppType args))
                             + " -> " + ppType res

let reportError msg pos = raise (MyError (msg, pos))

let reportTypeWrong place tExp tFound pos =
  reportError ("Type mismatch in " + place + ": expected " +
               ppType tExp + ", but got " + ppType tFound) pos

let reportTypesDifferent place tFound1 tFound2 pos =
  reportError ("Type mismatch in " + place + ": expected " +
               "equal types, but got " + ppType tFound1 +
               " and " + ppType tFound2) pos

let reportTypeWrongKind place kExp tFound pos =
  reportError ("Type mismatch in " + place + ": expected a(n) " +
               kExp + " type, but got " + ppType tFound) pos

let reportArityWrong place nExp (args, res) pos =
  reportError ("Arity mismatch in " + place + ": expected " +
               "a function of arity " + string nExp + ", but got " +
               showFunType (args, res)) pos

let reportUnknownId kind name pos =
  reportError ("Unkown " + kind + " identifier: " + name) pos

let reportOther msg pos = reportError msg pos

(* Determine if a value of some type can be printed with write() *)
let printable (tp : Type) : bool =
  match tp with
    | Int  -> true
    | Bool -> true
    | Char -> true
    | Array Char -> true
    | _    -> false  (* For all other array types *)

(* Type-check the two operands to a binary operator - they must both be
   of type 't'. Returns the decorated operands on success. *)
let rec checkBinOp  (ftab : FunTable)
                    (vtab : VarTable)
                    (pos : Position, t  : Type, e1 : UntypedExp, e2 : UntypedExp)
                  : (TypedExp * TypedExp) =
    let (t1, e1') = checkExp ftab vtab e1
    let (t2, e2') = checkExp ftab vtab e2
    if t1 <> t then
      reportTypeWrong "1st argument of binary operator" t t1 pos
    if t2 <> t then
      reportTypeWrong "2nd argument of binary operator" t t2 pos
    (e1', e2')

(* Determine the type of an expression.  On the way, decorate each
   node in the syntax tree with inferred types.  The result consists
   of a pair: the result type tupled with the type-decorated
   expression. An exception is raised immediately on the first type mismatch
   by reportError. (We could instead collect each error as part of the
   result of checkExp and report all errors at the end.) *)

and checkExp  (ftab : FunTable)
              (vtab : VarTable)
              (exp  : UntypedExp)
            : (Type * TypedExp) =
    match exp with
    | Constant  (v, pos) -> (valueType v, Constant (v, pos))
    | StringLit (s, pos) -> (Array Char, StringLit (s, pos))
    | ArrayLit  ([], _, pos) -> reportOther "Impossible empty array" pos
    | ArrayLit  (exp::exps, _, pos) ->
      let (type_exp, exp_dec) = checkExp ftab vtab exp
      let exps_dec =
        List.map (fun ei -> let (ti, ei') = checkExp ftab vtab ei
                            if ti <> type_exp then
                              reportTypesDifferent "components of array literal"
                                                   type_exp ti pos
                            ei')
                 exps
      (Array type_exp, ArrayLit (exp_dec :: exps_dec, type_exp, pos))

    | Var (s, pos) ->
        match SymTab.lookup s vtab with
          | None   -> reportUnknownId "variable" s pos
          | Some t -> (t, Var (s, pos))

    | Plus (e1, e2, pos) ->
        let (e1_dec, e2_dec) = checkBinOp ftab vtab (pos, Int, e1, e2)
        (Int, Plus (e1_dec, e2_dec, pos))

    | Minus (e1, e2, pos) ->
        let (e1_dec, e2_dec) = checkBinOp ftab vtab (pos, Int, e1, e2)
        (Int, Minus (e1_dec, e2_dec, pos))

    (* TODO project task 1:
        Implement by pattern matching Plus/Minus above.
        See `AbSyn.fs` for the expression constructors of `Times`, ...
    *)
    | Times (e1, e2, pos) ->
        failwith "Unimplemented type check of multiplication"

    | Divide (_, _, _) ->
        failwith "Unimplemented type check of division"

    | And (_, _, _) ->
        failwith "Unimplemented type check of &&"

    | Or (_, _, _) ->
        failwith "Unimplemented type check of ||"

    | Not (_, _) ->
        failwith "Unimplemented type check of not"

    | Negate (_, _) ->
        failwith "Unimplemented type check of negate"

    (* The types for e1, e2 must be the same. The result is always a Bool. *)
    | Equal (e1, e2, pos) ->
        let  (t1, e1') = checkExp ftab vtab e1
        let  (t2, e2') = checkExp ftab vtab e2
        match (t1 = t2, t1) with
          | (false, _) -> reportTypesDifferent "arguments of == " t1 t2 pos
          | (true, Array _) -> reportTypeWrongKind "arguments of == " "base" t1 pos
          | _ -> (Bool, Equal (e1', e2', pos))

    | Less (e1, e2, pos) ->
        let  (t1, e1') = checkExp ftab vtab e1
        let  (t2, e2') = checkExp ftab vtab e2
        match (t1 = t2, t1) with
          | (false, _) -> reportTypesDifferent "arguments of < " t1 t2 pos
          | (true, Array _) -> reportTypeWrongKind "arguments of < " "base" t1 pos
          | _ -> (Bool, Less (e1', e2', pos))

    | If (pred, e1, e2, pos) ->
        let (pred_t, pred') = checkExp ftab vtab pred
        let (t1, e1') = checkExp ftab vtab e1
        let (t2, e2') = checkExp ftab vtab e2
        let target_type = if t1 = t2 then t1
                          else reportTypesDifferent "branches of conditional"
                                                    t1 t2 pos
        match pred_t with
          | Bool -> (target_type, If (pred', e1', e2', pos))
          | _ -> reportTypeWrong "predicate in conditional" Bool pred_t pos

    (* Look up f in function table, get a list of expected types for each
       function argument and an expected type for the return value. Check
       each actual argument.  Ensure that each actual argument type has the
       expected type. *)
    | Apply (f, args, pos) ->
        let (result_type, expected_arg_types, _) =
            match SymTab.lookup f ftab with
              | Some tup -> tup  (* 2-tuple *)
              | None     -> reportUnknownId "function" f pos
        let nargs = List.length args
        let ntypes =  List.length expected_arg_types
        if nargs <> ntypes then
          reportOther ("Arity mismatch: expected " + string ntypes +
                       " argument(s), but got " + string nargs) pos
        let args_dec =
            List.mapi2 (fun i ti ai ->
                          let (ti', ai') = checkExp ftab vtab ai
                          if ti' <> ti then
                            reportTypeWrong ("function argument #"+string (i+1))
                                            ti ti' pos
                          ai')
                       expected_arg_types args
        (result_type, Apply (f, args_dec, pos))

    | Let (Dec (name, exp, pos1), exp_body, pos2) ->
        let (t1, exp_dec)      = checkExp ftab vtab exp
        let new_vtab           = SymTab.bind name t1 vtab
        let (t2, exp_body_dec) = checkExp ftab new_vtab exp_body
        (t2, Let (Dec (name, exp_dec, pos1), exp_body_dec, pos2))

    | Read (t, pos) ->
        match t with
          | Int | Char ->  (t, Read (t, pos))
          | _ -> reportTypeWrongKind "argument of read" "int or char" t pos

    | Write (e, _, pos) ->
        let (t, e') = checkExp ftab vtab e
        if printable t
        then (t, Write (e', t, pos))
        else reportTypeWrongKind "argument of write" "printable" t pos

    | Index (s, i_exp, t, pos) ->
        let (e_type, i_exp_dec) = checkExp ftab vtab i_exp
        if e_type <> Int then
          reportTypeWrong "indexing expression" Int e_type pos
        let arr_type =
            match SymTab.lookup s vtab with
              | Some (Array t) -> t
              | None       -> reportUnknownId "indexed-variable" s pos
              | Some other -> reportTypeWrongKind ("indexed variable " + s) "array" other pos
        (arr_type, Index (s, i_exp_dec, arr_type, pos))

    | Iota (n_exp, pos) ->
        let  (e_type, n_exp_dec) = checkExp ftab vtab n_exp
        if e_type <> Int then
          reportTypeWrong "argument of iota" Int e_type pos
        (Array Int, Iota (n_exp_dec, pos))

    | Length (arr_exp, (), pos) ->
        let  (arr_type, arr_exp_dec) = checkExp ftab vtab arr_exp
        match arr_type with
          | Array t -> (Int, Length(arr_exp_dec, t, pos))
          | _ -> reportTypeWrongKind "argument of length" "array" arr_type pos

    | Map (f, arr_exp, _, _, pos) ->
        let (arr_type, arr_exp_dec) = checkExp ftab vtab arr_exp
        let elem_type =
            match arr_type with
              | Array t -> t
              | _ -> reportTypeWrongKind "second argument of map" "array" arr_type pos
        let (f', f_res_type, f_arg_type) =
            match checkFunArg ftab vtab pos f with
              | (f', res, [a1]) -> (f', res, a1)
              | (_, res, args) ->
                   reportArityWrong "first argument of map" 1 (args,res) pos
        if elem_type <> f_arg_type then
          reportTypesDifferent "function-argument and array-element types in map"
                               f_arg_type elem_type pos
        (Array f_res_type, Map (f', arr_exp_dec, elem_type, f_res_type, pos))

    | Reduce (f, e_exp, arr_exp, _, pos) ->
        let (e_type  , e_dec  ) = checkExp ftab vtab e_exp
        let (arr_type, arr_dec) = checkExp ftab vtab arr_exp
        let elem_type =
            match arr_type with
              | Array t -> t
              | _ -> reportTypeWrongKind "third argument of reduce" "array" arr_type pos
        let (f', f_argres_type) =
            match checkFunArg ftab vtab pos f with
              | (f', res, [a1; a2]) ->
                  if a1 <> a2 then
                     reportTypesDifferent "argument types of operation in reduce"
                                          a1 a2 pos
                  if res <> a1 then
                     reportTypesDifferent "argument and return type of operation in reduce"
                                          a1 res pos
                  (f', res)
              | (_, res, args) ->
                  reportArityWrong "operation in reduce" 2 (args,res) pos
        if elem_type <> f_argres_type then
          reportTypesDifferent "operation and array-element types in reduce"
                               f_argres_type elem_type pos
        if e_type <> f_argres_type then
          reportTypesDifferent "operation and start-element types in scan"
                               f_argres_type e_type pos
        (f_argres_type, Reduce (f', e_dec, arr_dec, elem_type, pos))

    (* TODO project task 2:
        See `AbSyn.fs` for the expression constructors of
        `Replicate`, `Filter`, `Scan`.

        Hints for `replicate(n, a)`:
        - recursively type check `n` and `a`
        - check that `n` has integer type
        - assuming `a` is of type `t` the result type
          of replicate is `[t]`
    *)
    | Replicate (_, _, _, _) ->
        failwith "Unimplemented type check of replicate"

    (* TODO project task 2: Hint for `filter(f, arr)`
        Look into the type-checking lecture slides for the type rule of `map`
        and think of what needs to be changed for filter (?)
        Use `checkFunArg` to get the signature of the function argument `f`.
        Check that:
            - `f` has type `ta -> Bool`
            - `arr` should be of type `[ta]`
            - the result of filter should have type `[ta]`
    *)
    | Filter (_, _, _, _) ->
        failwith "Unimplemented type check of filter"

    (* TODO project task 2: `scan(f, ne, arr)`
        Hint: Implementation is very similar to `reduce(f, ne, arr)`.
              (The difference between `scan` and `reduce` is that
              scan's return type is the same as the type of `arr`,
              while reduce's return type is that of an element of `arr`).
    *)
    | Scan (_, _, _, _, _) ->
        failwith "Unimplemented type check of scan"

and checkFunArg  (ftab : FunTable)
                 (vtab : VarTable)
                 (pos  : Position)
                 (ff   : UntypedFunArg)
               : (TypedFunArg * Type * Type list) =
  match ff with
  | FunName fname ->
    match SymTab.lookup fname ftab with
      | None -> reportUnknownId "parameter function" fname pos
      | Some (ret_type, arg_types, _) -> (FunName fname, ret_type, arg_types)
  | Lambda (rettype, parms, body, funpos) ->
    let lambda = FunDec ("<lambda>", rettype, parms, body, funpos)
    let (FunDec (_, _, _, body', _)) =
        checkFunWithVtable ftab vtab pos lambda
    ( Lambda (rettype, parms, body', pos)
    , rettype
    , List.map (fun (Param (_, ty)) -> ty) parms)


(* Check a function declaration, but using a given vtable rather
than an empty one. *)
and checkFunWithVtable  (ftab : FunTable)
                        (vtab : VarTable)
                        (pos  : Position)
                        (fdec : UntypedFunDec)
                      : TypedFunDec =
    let (FunDec (fname, rettype, parms, body, funpos)) = fdec
    (* Expand vtable by adding the parameters to vtab. *)
    let addParam ptable (Param (pname, ty)) =
            match SymTab.lookup pname ptable with
              | Some _ -> reportOther ("Multiple parameters named " + pname)
                                      funpos
              | None   -> SymTab.bind pname ty ptable
    let paramtable = List.fold addParam (SymTab.empty()) parms
    let vtab' = SymTab.combine paramtable vtab
    let (body_type, body') = checkExp ftab vtab' body
    if body_type = rettype
    then (FunDec (fname, rettype, parms, body', pos))
    else reportTypeWrong "function body" rettype body_type funpos


(* Convert a funDec into the (fname, ([arg types], result type),
   pos) entries that the function table, ftab, consists of, and
   update the function table with that entry. *)
let updateFunctionTable  (ftab   : FunTable)
                         (fundec : UntypedFunDec)
                       : FunTable =
    let (FunDec (fname, ret_type, args, _, pos)) = fundec
    let arg_types = List.map (fun (Param (_, ty)) -> ty) args
    match SymTab.lookup fname ftab with
      | Some (_, _, old_pos) -> reportOther ("Duplicate function " + fname) pos
      | None -> SymTab.bind fname (ret_type, arg_types, pos) ftab

(* Functions are guaranteed by syntax to have a known declared type.  This
   type is checked against the type of the function body, taking into
   account declared argument types and types of other functions called.
 *)
let checkFun  (ftab   : FunTable)
              (fundec : UntypedFunDec)
            : TypedFunDec =
    let (FunDec (_, _, _, _, pos)) = fundec
    checkFunWithVtable ftab (SymTab.empty()) pos fundec

let checkProg (funDecs : UntypedFunDec list) : TypedFunDec list =
    let ftab = List.fold updateFunctionTable initFunctionTable funDecs
    let decorated_funDecs = List.map (checkFun ftab) funDecs
    match SymTab.lookup "main" ftab with
      | None         -> reportOther "No main function defined" (0,0)
      | Some (_, [], _) -> decorated_funDecs  (* all fine! *)
      | Some (ret_type, args, mainpos) ->
        reportArityWrong "declaration of main" 0 (args,ret_type) mainpos
