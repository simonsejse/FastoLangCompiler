(* We will inline any function that does not call itselt. *)
module Inlining

open AbSyn
open CallGraph

let mutable inlining_ctr = 0 (* for generating fresh variable names *)

let newSuffix () =
    inlining_ctr <- inlining_ctr + 1
    "_I" + string inlining_ctr

let rec inlineInExp (graph : CallGraph)
                    (prog  : TypedProg)
                    (e     : TypedExp) =
    match e with
        | Constant _ -> e
        | StringLit _ -> e
        | ArrayLit (es, t, pos) ->
            ArrayLit (List.map (inlineInExp graph prog) es, t, pos)
        | Var _ -> e
        | Plus (e1, e2, pos) ->
            Plus (inlineInExp graph prog e1,
                  inlineInExp graph prog e2, pos)
        | Minus (e1, e2, pos) ->
            Minus (inlineInExp graph prog e1,
                   inlineInExp graph prog e2, pos)
        | Equal (e1, e2, pos) ->
            Equal (inlineInExp graph prog e1,
                   inlineInExp graph prog e2, pos)
        | Less (e1, e2, pos) ->
            Less (inlineInExp graph prog e1,
                  inlineInExp graph prog e2, pos)
        | If (e1, e2, e3, pos) ->
            If (inlineInExp graph prog e1,
                inlineInExp graph prog e2,
                inlineInExp graph prog e3,
                pos)
        | Apply (fname, es, pos) ->
            if calls fname fname graph then
                (* Function is recursive - do not inline. *)
                Apply (fname, List.map (inlineInExp graph prog) es, pos)
            else (* OK - inline. *)
            inlineFuncall fname graph prog es pos
        | Let (Dec (name, e, decpos), body, pos) ->
            Let (Dec (name, inlineInExp graph prog e, decpos),
                 inlineInExp graph prog body,
                 pos)
        | Index (name, e, t, pos) ->
            Index (name, inlineInExp graph prog e, t, pos)
        | Iota (e, pos) ->
            Iota (inlineInExp graph prog e, pos)
        | Length (e, t, pos) ->
            Length (inlineInExp graph prog e, t, pos)
        | Map (farg, e, t1, t2, pos) ->
            Map (inlineInFunArg graph prog farg,
                 inlineInExp graph prog e,
                 t1, t2, pos)
        | Filter (farg, e, t1, pos) ->
            Filter (inlineInFunArg graph prog farg,
                    inlineInExp graph prog e,
                    t1, pos)
        | Reduce (farg, e1, e2, t, pos) ->
            Reduce (inlineInFunArg graph prog farg,
                    inlineInExp graph prog e1,
                    inlineInExp graph prog e2,
                    t, pos)
        | Replicate (n, e, t, pos) ->
            Replicate (inlineInExp graph prog n,
                       inlineInExp graph prog e,
                       t, pos)
        | Scan (farg, e1, e2, t, pos) ->
            Scan (inlineInFunArg graph prog farg,
                  inlineInExp graph prog e1,
                  inlineInExp graph prog e2,
                  t, pos)
        | Times (e1, e2, pos) ->
            Times (inlineInExp graph prog e1,
                   inlineInExp graph prog e2,
                   pos)
        | Divide (e1, e2, pos) ->
            Divide (inlineInExp graph prog e1,
                    inlineInExp graph prog e2,
                    pos)
        | And (e1, e2, pos) ->
            And (inlineInExp graph prog e1,
                 inlineInExp graph prog e2,
                 pos)
        | Or (e1, e2, pos) ->
            Or (inlineInExp graph prog e1,
                inlineInExp graph prog e2,
                pos)
        | Not (e, pos) ->
            Not (inlineInExp graph prog e, pos)
        | Negate (e, pos) ->
            Negate (inlineInExp graph prog e, pos)
        | Read (t, pos) ->
            Read (t, pos)
        | Write (e, t, pos) ->
            Write (inlineInExp graph prog e, t, pos)

and inlineInFunArg (graph : CallGraph)
                   (prog  : TypedProg) = function
                       | Lambda (rettype, paramls, body, pos) ->
                           Lambda (rettype, paramls, inlineInExp graph prog body, pos)
                       | FunName fname ->
                           match List.tryFind (fun (FunDec (x, _, _, _, _)) -> x = fname) prog with
                               | None -> FunName fname
                               | Some (FunDec (_, rettype, paramls, body, pos)) ->
                                   inlineInFunArg graph prog (Lambda (rettype, paramls, body, pos))

and inlineFuncall (fname : string)
                  (graph : CallGraph)
                  (prog  : TypedProg)
                  (args  : TypedExp list)
                  (pos   : Position) =
    match List.tryFind (fun (FunDec(x, _, _, _, _)) -> x = fname) prog with
        | None -> Apply (fname, List.map ( inlineInExp graph prog) args, pos)
        | Some (FunDec (_, _, paramls, body, _)) ->
            let parNames = List.map (fun (Param (v,t)) ->  v) paramls
            // let paramBindings = List.zip parNames args (* too simplistic *)
            let uniq = newSuffix () (* can use same suffix for all pars *)
            let parNames1 = List.map (fun v -> v + uniq) parNames
            let paramBindings =
              List.zip parNames1 args @
              List.zip parNames (List.map (fun v -> Var (v,pos)) parNames1)
            let rec mkLetsAroundBody = function
                | [] -> body
                | ((paramname, arg) :: rest) ->
                    Let ( Dec ( paramname, arg, pos),
                          mkLetsAroundBody rest,
                          pos)
            inlineInExp graph prog (mkLetsAroundBody paramBindings)

let inlineInFunction (graph : CallGraph)
                     (prog : TypedProg)
                     (FunDec (fname, rettype, paramls, body, pos)) =
    FunDec (fname, rettype, paramls, inlineInExp graph prog body, pos)

let inlineOptimiseProgram (prog : TypedProg) =
    let graph = callGraph prog
    List.map (inlineInFunction graph prog) prog
