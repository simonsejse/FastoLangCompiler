// Signature file for parser generated by fsyacc
module Parser
type token = 
  | AND of (Position)
  | OR of (Position)
  | NEG of (Position)
  | LCURLY of (Position)
  | RCURLY of (Position)
  | EOF of (Position)
  | COMMA of (Position)
  | SEMICOLON of (Position)
  | EQ of (Position)
  | ARROW of (Position)
  | LPAR of (Position)
  | RPAR of (Position)
  | LBRACKET of (Position)
  | RBRACKET of (Position)
  | MINUS of (Position)
  | PLUS of (Position)
  | TIMES of (Position)
  | DIVIDE of (Position)
  | DEQ of (Position)
  | LTH of (Position)
  | GTH of (Position)
  | IOTA of (Position)
  | LENGTH of (Position)
  | MAP of (Position)
  | READ of (Position)
  | REDUCE of (Position)
  | WRITE of (Position)
  | NOT of (Position)
  | TRUE of (Position)
  | FALSE of (Position)
  | BOOL of (Position)
  | CHAR of (Position)
  | ELSE of (Position)
  | FN of (Position)
  | FUN of (Position)
  | IF of (Position)
  | IN of (Position)
  | INT of (Position)
  | LET of (Position)
  | THEN of (Position)
  | ID of (string * Position)
  | STRINGLIT of (string * Position)
  | CHARLIT of (char * Position)
  | NUM of (int * Position)
type tokenId = 
    | TOKEN_AND
    | TOKEN_OR
    | TOKEN_NEG
    | TOKEN_LCURLY
    | TOKEN_RCURLY
    | TOKEN_EOF
    | TOKEN_COMMA
    | TOKEN_SEMICOLON
    | TOKEN_EQ
    | TOKEN_ARROW
    | TOKEN_LPAR
    | TOKEN_RPAR
    | TOKEN_LBRACKET
    | TOKEN_RBRACKET
    | TOKEN_MINUS
    | TOKEN_PLUS
    | TOKEN_TIMES
    | TOKEN_DIVIDE
    | TOKEN_DEQ
    | TOKEN_LTH
    | TOKEN_GTH
    | TOKEN_IOTA
    | TOKEN_LENGTH
    | TOKEN_MAP
    | TOKEN_READ
    | TOKEN_REDUCE
    | TOKEN_WRITE
    | TOKEN_NOT
    | TOKEN_TRUE
    | TOKEN_FALSE
    | TOKEN_BOOL
    | TOKEN_CHAR
    | TOKEN_ELSE
    | TOKEN_FN
    | TOKEN_FUN
    | TOKEN_IF
    | TOKEN_IN
    | TOKEN_INT
    | TOKEN_LET
    | TOKEN_THEN
    | TOKEN_ID
    | TOKEN_STRINGLIT
    | TOKEN_CHARLIT
    | TOKEN_NUM
    | TOKEN_end_of_input
    | TOKEN_error
type nonTerminalId = 
    | NONTERM__startProg
    | NONTERM_Prog
    | NONTERM_FunDecs
    | NONTERM_Fun
    | NONTERM_Type
    | NONTERM_Params
    | NONTERM_LetDecls
    | NONTERM_LetDecl
    | NONTERM_Exp
    | NONTERM_Exps
    | NONTERM_FunArg
/// This function maps tokens to integer indexes
val tagOfToken: token -> int

/// This function maps integer indexes to symbolic token ids
val tokenTagToTokenId: int -> tokenId

/// This function maps production indexes returned in syntax errors to strings representing the non terminal that would be produced by that production
val prodIdxToNonTerminal: int -> nonTerminalId

/// This function gets the name of a token as a string
val token_to_string: token -> string
val Prog : (FSharp.Text.Lexing.LexBuffer<'cty> -> token) -> FSharp.Text.Lexing.LexBuffer<'cty> -> (AbSyn.UntypedProg) 
