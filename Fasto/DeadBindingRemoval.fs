module DeadBindingRemoval

(*
    val removeDeadBindings : TypedProg -> TypedProg
*)

open AbSyn

type DBRtab = SymTab.SymTab<unit>

let isUsed (name : string) (stab : DBRtab) =
    match SymTab.lookup name stab with
      | None   -> false
      | Some _ -> true

let recordUse (name : string) (stab : DBRtab) =
    match SymTab.lookup name stab with
      | None   -> SymTab.bind name () stab
      | Some _ -> stab

let rec unzip3 = function
    | []         -> ([], [], [])
    | (x,y,z)::l ->
        let (xs, ys, zs) = unzip3 l
        (x::xs, y::ys, z::zs)
let anytrue = List.exists (fun x -> x)

(*  Input: the expression to be optimised (by removing inner dead bindings)
    The result is a three-tuple:
      - bool refers to whether the expression _may_ contain I/O
        operations (directly or indirectly). We always err on the safe side;
        that is, we only return false if we are certain that
        a dead binding to this expression is safe to remove.
      - DBRtab is the symbol table that is synthesized from processing the
        subexpressions -- its keys are the names that were used in subexpressions.
      - the TypedExp is the resulting (optimised) expression
    The idea is that you do a bottom-up traversal of AbSyn, and you record
        any (variable) names that you find in the symbol table. You find such
        names when (1) the expression is a `Var` expression or (2) an `Index`
        expression.
    Then, whenever you reach a `Let` expression, you check whether the body
        of the let has used the variable name currently defined. If not, then
        the current binding is unused and can be omitted/removed, _if_
        it contains no I/O operations. For example, assume the original
        program is:
            `let x = (let y = 4 + 5 in 6) in x * 2`
        then one can observe that `y` is unused and the binding `let y = 4 + 5`
        can be removed (because `y` is not subsequently used), resulting in the
        optimised program: `let x = 6 in x * 2`.
    The rest of the expression constructors mainly perform the AbSyn (bottom-up)
        traversal by recursively calling `removeDeadBindingsInExp` on subexpressions
        and joining the results.
*)
let rec removeDeadBindingsInExp (e : TypedExp) : (bool * DBRtab * TypedExp) =
    match e with
        | Constant  (x, pos) -> (false, SymTab.empty(),  Constant (x, pos))
        | StringLit (x, pos) -> (false, SymTab.empty(), StringLit (x, pos))
        | ArrayLit  (es, t, pos) ->
            let (ios, uses, es') = unzip3 (List.map removeDeadBindingsInExp es)
            (anytrue ios,
             List.fold SymTab.combine (SymTab.empty()) uses,
             ArrayLit (es', t, pos) )
        (* ToDO: Task 3: implement the cases of `Var`, `Index` and `Let` expressions below *)
        | Var (name, pos) ->
            (* Task 3, Hints for the `Var` case:
                  - 1st element of result tuple: can a variable name contain IO?
                  - 2nd element of result tuple: you have discovered a name, hence
                        you need to record it in a new symbol table.
                  - 3rd element of the tuple: should be the optimised expression.
            *)
            failwith "Unimplemented removeDeadBindingsInExp for Var"
        | Plus (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Plus (x', y', pos))
        | Minus (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Minus (x', y', pos))
        | Equal (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Equal (x', y', pos))
        | Less (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Less (x', y', pos))
        | If (e1, e2, e3, pos) ->
            let (ios1, uses1, e1') = removeDeadBindingsInExp e1
            let (ios2, uses2, e2') = removeDeadBindingsInExp e2
            let (ios3, uses3, e3') = removeDeadBindingsInExp e3
            (ios1 || ios2 || ios3,
             SymTab.combine (SymTab.combine uses1 uses2) uses3,
             If (e1', e2', e3', pos))
        | Apply (fname, args, pos) ->
            let (ios, uses, args') = unzip3 (List.map removeDeadBindingsInExp args)
            (* Since we don't currently analyze the body of the called function,
               we don't know if it might contain I/O. Thus, we always mark
               a function call as non-removable, unless it is to a
               known-safe builtin function, such as "ord" or "chr".
               (However, if we perform function inlining before removing
               dead bindings, being overly cautious here will generally
               not cause us to miss many optimization opportunities.) *)
            (anytrue ios || not (List.contains fname ["ord"; "chr"]),
             List.fold SymTab.combine (SymTab.empty()) uses,
             Apply (fname, args', pos))
        | Index (name, e, t, pos) ->
            (* Task 3, `Index` case: is similar to the `Var` case, except that,
                        additionally, you also need to recursively optimize the index
                        expression `e` and to propagate its results (in addition
                        to recording the use of `name`).
            *)
            failwith "Unimplemented removeDeadBindingsInExp for Index"

        | Let (Dec (name, e, decpos), body, pos) ->
            (* Task 3, Hints for the `Let` case:
                  - recursively process the `e` and `body` subexpressions
                    of the Let-binding
                  - a Let-binding contains IO if at least one of `e`
                    and `body` does.
                  - a variable is used in a Let-binding if it is used
                    in either `e` or `body`, except that any uses in
                    `body` do not count if they refer to the local
                    binding of `name`. For example, in
                      `let x = y+1 in x*z`,
                    `x` is _not_ considered to be used in the
                    Let-expression, but `y` and `z` are.  Consider how
                    to express this with the SymTab operations.
                  - the optimized expression will be either just the
                    optimized body (if it doesn't use `name` _and_ `e`
                    does not contain IO), or a new Let-expression
                    built from the optimized subexpressions
                    (otherwise). Note that the returned IO-flag and
                    used-variable table should describe the expression
                    *resulting* from the optmization, not the original
                    Let-expression.

            *)
            failwith "Unimplemented removeDeadBindingsInExp for Let"
        | Iota (e, pos) ->
            let (io, uses, e') = removeDeadBindingsInExp e
            (io,
             uses,
             Iota (e', pos))
        | Length (e, t, pos) ->
            let (io, uses, e') = removeDeadBindingsInExp e
            (io,
             uses,
             Length (e', t, pos))
        | Map (farg, e, t1, t2, pos) ->
            let (eio, euses, e') = removeDeadBindingsInExp e
            let (fio, fuses, farg') = removeDeadBindingsInFunArg farg
            (eio || fio,
             SymTab.combine euses fuses,
             Map (farg', e', t1, t2, pos))
        | Filter (farg, e, t1, pos) ->
            let (eio, euses, e')    = removeDeadBindingsInExp e
            let (fio, fuses, farg') = removeDeadBindingsInFunArg farg
            (eio || fio,
             SymTab.combine euses fuses,
             Filter (farg', e', t1, pos))
        | Reduce (farg, e1, e2, t, pos) ->
            let (io1, uses1, e1') = removeDeadBindingsInExp e1
            let (io2, uses2, e2') = removeDeadBindingsInExp e2
            let (fio, fuses, farg') = removeDeadBindingsInFunArg farg
            (io1 || io2 || fio,
             SymTab.combine (SymTab.combine uses1 uses2) fuses,
             Reduce(farg', e1', e2', t, pos))
        | Replicate (n, e, t, pos) ->
            let (nio, nuses, n') = removeDeadBindingsInExp n
            let (eio, euses, e') = removeDeadBindingsInExp e
            (nio || eio,
             SymTab.combine nuses euses,
             Replicate (n', e', t, pos))
        | Scan (farg, e1, e2, t, pos) ->
            let (io1, uses1, e1') = removeDeadBindingsInExp e1
            let (io2, uses2, e2') = removeDeadBindingsInExp e2
            let (fio, fuses, farg') = removeDeadBindingsInFunArg farg
            (io1 || io2 || fio,
             SymTab.combine (SymTab.combine uses1 uses2) fuses,
             Scan(farg', e1', e2', t, pos))
        | Times (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Times (x', y', pos))
        | Divide (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Divide (x', y', pos))
        | And (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             And (x', y', pos))
        | Or (x, y, pos) ->
            let (xios, xuses, x') = removeDeadBindingsInExp x
            let (yios, yuses, y') = removeDeadBindingsInExp y
            (xios || yios,
             SymTab.combine xuses yuses,
             Or (x', y', pos))
        | Not (e, pos) ->
            let (ios, uses, e') = removeDeadBindingsInExp e
            (ios, uses, Not (e', pos))
        | Negate (e, pos) ->
            let (ios, uses, e') = removeDeadBindingsInExp e
            (ios, uses, Negate (e', pos))
        | Read (x, pos) ->
            (true, SymTab.empty(), Read (x, pos))
        | Write (e, t, pos) ->
            let (_, uses, e') = removeDeadBindingsInExp e
            (true, uses, Write (e', t, pos))

and removeDeadBindingsInFunArg (farg : TypedFunArg) =
    match farg with
        | FunName fname -> (false, SymTab.empty(), FunName fname)
        | Lambda (rettype, paramls, body, pos) ->
            let (io, uses, body') = removeDeadBindingsInExp body
            let uses' = List.fold (fun acc (Param (pname,_)) ->
                                     SymTab.remove pname acc
                                  ) uses paramls
            (io,
             uses',
             Lambda (rettype, paramls, body', pos))

let removeDeadBindingsInFunDec (FunDec (fname, rettype, paramls, body, pos)) =
    let (_, _, body') = removeDeadBindingsInExp body
    FunDec (fname, rettype, paramls, body', pos)

(* Entrypoint: remove dead bindings from the whole program *)
let removeDeadBindings (prog : TypedProg) =
    List.map removeDeadBindingsInFunDec prog
