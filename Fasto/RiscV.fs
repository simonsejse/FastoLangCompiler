(* Types and utilities for the abstract syntax of RISC-V, adapted from MIPS. *)

module RiscV

open AbSyn

type reg  = RN of int | RS of string
type imm  = int (* various size limits, depending on instruction *)
type addr = string

(* Standard register names *)
let Rzero = RN 0  (* constant zero *)
let Rra = RN 1    (* return address *)
let Rsp = RN 2    (* stack pointer *)
let Rgp = RN 3    (* global pointer *)
let Rt1 = RN 6    (* temporary 1 *)
let Rt2 = RN 7    (* temporary 2 *)
let Ra0 = RN 10   (* 1st function/syscall arg *)
let Ra1 = RN 11   (* 2nd function/syscall arg *)
let Ra7 = RN 17   (* 8th function/syscall arg *)

let Rrv = Ra0     (* function/syscall return value *)
let Rsn = Ra7     (* RARS syscall number *)

type Instruction =
    LABEL   of addr     (* Define a label (for code or data) *)
  | COMMENT of string   (* Add a comment in the assembler code *)

  (* Data movement *)
  | LA   of reg*addr    (* LA($rd,addr):    $rd = addr (label) pseudoinstr] *)
  | LI   of reg*imm     (* LI($rd,imm):     $rd = imm  [pseudoinstr] *)
  | MV   of reg*reg     (* MV($rd,$rs):     $rd = $rs  [pseudoinstr] *)
  // could add: LUI (but subsumed by LI)

  | LW   of reg*reg*imm (* LW($rd,$rs,imm): $rd = *(int * )($rs + imm) *)
  | LB   of reg*reg*imm (* LB($rd,$rs,imm): $rd = *(signed char * )($rs + imm) *)
  | LBU  of reg*reg*imm (* LBU($rd,$rs,imm): $rd = *(unsigned char * )($rs + imm) *)
  | SW   of reg*reg*imm (* SW($rw,$rm,imm): *(int * )($rm + imm) = $rw *)
  | SB   of reg*reg*imm (* SB($rb,$rm,imm): *(char * )($rm + imm) = $rb *)
  // could add: LH, SH, LHU

  (* Arithmetic instructions *)
  | ADD  of reg*reg*reg (* ADD($rd,$rs,$rt): $rd = $rs + $rt *)
  | ADDI of reg*reg*imm (* ADDI($rd,$rs,imm): $rd = $rs + imm *)
  | SUB  of reg*reg*reg (* SUB($rd,$rs,$rt): $rd = $rs - $rt *)
  | MUL  of reg*reg*reg (* MUL($rd,$rs,$rt): $rd = $rs * $rt *)
  | DIV  of reg*reg*reg (* DIV($rd,$rs,$rt): $rd = $rd / $rs *)
  // could add: MULH, MULHSU, MULHU, DIVU, REM, REMU

  (* Bitwise operations *)
  | AND  of reg*reg*reg (* AND($rd,$rs,$rt):  $rd = $rs & $rt *)
  | ANDI of reg*reg*imm (* ANDI($rd,$rs,imm): $rd = $rs & imm *)
  | OR   of reg*reg*reg (* OR($rd,$rs,$rt):   $rd = $rs | $rt *)
  | ORI  of reg*reg*imm (* ORI($rd,$rs,imm):  $rd = $rs | imm *)
  | XOR  of reg*reg*reg (* XOR($rd,$rs,$rt):  $rd = $rs ^ $rt *)
  | XORI of reg*reg*imm (* XORI($rd,$rs,imm): $rd = $rs ^ imm *)

  (* Bit-shifting *)
  | SLLI  of reg*reg*imm (* SLLI($rd,$rs,imm):  $rd = $rs << imm *)
  | SRAI  of reg*reg*imm (* SRAI($rd,$rs,imm):  $rd = $rs >> imm *)
  // could add: SRLI, SLL, SRA, SRL

  (* Comparisons and branches/jumps *)
  | SLT  of reg*reg*reg    (* SLT($rd,$rs,$rt):  $rd = $rs < $rt *)
  | SLTI of reg*reg*imm    (* SLTI($rd,$rs,imm): $rd = $rs < imm *)
  | BEQ  of reg*reg*addr   (* BEQ($rs,$rt,addr): if ($rs == $rt) goto(addr) *)
  | BNE  of reg*reg*addr   (* BNE($rs,$rt,addr): if ($rs != $rt) goto(addr) *)
  | BLT  of reg*reg*addr   (* BLT($rs,$rt,addr): if ($rs < $rt) goto(addr) *)
  | BGE  of reg*reg*addr   (* BGE($rs,$rt,addr): if ($rs >= $rt) goto(addr) *)
  | J    of addr           (* J(addr):        goto(addr)            *)
  | JR   of reg * reg list (* JR($rd,regs):   goto($rd)             *)
  | JAL  of addr* reg list (* JAL(addr,regs): $Rra = $PC; goto(addr) *)
  | NOP
  | ECALL                  (* Perform syscall given by $Rsn *)
  // could add: SLTU, SLTIU, BLTU, BGEU, JALR

  (* Assembler directives *)
  | GLOBL   of addr
  | TEXT    of addr
  | DATA    of addr
  | SPACE   of int
  | ASCII   of string
  | ASCIIZ  of string
  | ALIGN   of int         (* align to power of 2. 0 = byte, 2 = word *)
  | BYTE    of int list    (* byte data; list must be non-empty *)
  | WORD    of int list    (* word data; list must be non-empty *)

(* Legacy mnemomics for MIPS compatibility *)
(*
let MOVE (rd,rs) = MV (rd,rs)
let BGEZ (rs,addr) = BGE(rs, Rzero, addr)
let SUBI (rd, rs, imm) = ADDI (rd, rs, -imm)
let SYSCALL = ECALL
*)

type Prog = Instruction list

(* Pretty-print a list of RISC-V instructions in the
   format accepted by the RARS simulator. *)
let rec ppProg instructions =
    String.concat "\n" (List.map ppInst instructions)

(* Pretty-print a single RISC-V instruction for .asm output *)
and ppInst inst =
  match inst with
    | LABEL l         -> l + ":"
    | COMMENT s       -> "# " + s

    | LA   (rd,l)  -> "\tla\t"  + ppReg rd + ", " + l
    | LI  (rd,v)  -> "\tli\t" + ppReg rd + ", " + imm2str v
    | MV  (rd,rs)  -> "\tmv\t" + ppReg rd + ", " + ppReg rs
    | LW (rd,rs,v) -> "\tlw\t"  + ppReg rd + ", " + imm2str v + "(" + ppReg rs + ")"
    | LB (rd,rs,v) -> "\tlb\t"  + ppReg rd + ", " + imm2str v + "(" + ppReg rs + ")"
    | LBU (rd,rs,v) -> "\tlbu\t"  + ppReg rd + ", " + imm2str v + "(" + ppReg rs + ")"
    | SW (rd,rs,v) -> "\tsw\t"  + ppReg rd + ", " + imm2str v + "(" + ppReg rs + ")"
    | SB (rd,rs,v) -> "\tsb\t"  + ppReg rd + ", " + imm2str v + "(" + ppReg rs + ")"

    | ADD  (rd,rs,rt) -> "\tadd\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | ADDI (rd,rs,v)  -> "\taddi\t" + ppReg rd + ", " + ppReg rs + ", " + imm2str v
    | SUB  (rd,rs,rt) -> "\tsub\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | MUL  (rd,rs,rt) -> "\tmul\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | DIV  (rd,rs,rt) -> "\tdiv\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt

    | AND  (rd,rs,rt) -> "\tand\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | ANDI (rd,rs,v)  -> "\tandi\t" + ppReg rd + ", " + ppReg rs + ", " + imm2str v
    | OR   (rd,rs,rt) -> "\tor\t"   + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | ORI  (rd,rs,v)  -> "\tori\t"  + ppReg rd + ", " + ppReg rs + ", " + imm2str v
    | XOR  (rd,rs,rt) -> "\txor\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | XORI (rd,rs,v)  -> "\txori\t" + ppReg rd + ", " + ppReg rs + ", " + imm2str v

    | SLLI  (rd,rt,v)  -> "\tslli\t"  + ppReg rd + ", " + ppReg rt + ", " + imm2str v
    | SRAI  (rd,rt,v)  -> "\tsrai\t"  + ppReg rd + ", " + ppReg rt + ", " + imm2str v

    | SLT  (rd,rs,rt) -> "\tslt\t"  + ppReg rd + ", " + ppReg rs + ", " + ppReg rt
    | SLTI (rd,rs,v)  -> "\tslti\t" + ppReg rd + ", " + ppReg rs + ", " + imm2str v
    | BEQ  (rs,rt,l)  -> "\tbeq\t"  + ppReg rs + ", " + ppReg rt + ", " + l
    | BNE  (rs,rt,l)  -> "\tbne\t"  + ppReg rs + ", " + ppReg rt + ", " + l
    | BLT  (rs,rt,l)  -> "\tblt\t"  + ppReg rs + ", " + ppReg rt + ", " + l
    | BGE  (rs,rt,l)  -> "\tbge\t"  + ppReg rs + ", " + ppReg rt + ", " + l
    | J l             -> "\tj\t" + l
    | JAL (l,argRegs) -> "\tjal\t" + l
    | JR (r,resRegs)  -> "\tjr\t" + ppReg r
    | NOP -> "\tnop"
    | ECALL -> "\tecall"

    | GLOBL s  -> "\t.globl\t" + s
    | TEXT s   -> "\t.text\t" + s
    | DATA s   -> "\t.data\t" + s
    | SPACE s  -> "\t.space\t" + string s
    | ASCII s  -> "\t.ascii\t\"" + toCString s + "\""
    | ASCIIZ s -> "\t.asciz\t\"" + toCString s + "\""
    | ALIGN s  -> "\t.align\t" + string s
    | BYTE ns  -> "\t.byte\t" + String.concat ", " (List.map string ns)
    | WORD ns  -> "\t.word\t" + String.concat ", " (List.map string ns)

and ppReg r =
  match r with
    | RN n -> "x" + string n
    | RS s -> s

and imm2str (i:imm) = string i (* maybe add some sanity checks here *)
