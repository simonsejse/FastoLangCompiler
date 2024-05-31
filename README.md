# Compiler & Interpreter for Fasto

This is a compiler and interpreter for the Fasto programming language. The source code resides in the `Fasto` directory.

## Commits
For a detailed overview of changes and additions, check the commit history: [Commit History](https://github.com/simonsejse/FastoLangCompiler/commits/master/).

## Requirements
- .NET 8.0 SDK (*not* a Mono-based F#, ensure the `dotnet` executable is in your search path).
- `bash` for executing various test scripts in the `/bin` folder.
- Java Runtime Environment (JRE) to run the RARS simulator for RISC-V assembly.

## Building the Compiler
To build the compiler, run:
```
make
```
or 
```
dotnet build Fasto
```

## Usage
- **Interpret, compile, or optimize a Fasto program**: 
  ```
  bin/fasto.sh
  ```
- **Execute a compiled program (in RISC-V assembly)**: 
  ```
  bin/rars.sh
  ```
- **Compile and immediately execute a Fasto program**: 
  ```
  bin/compilerun.sh
  ```

## Running Tests
To run all tests from the `tests` directory (or another specified directory), use:
```
bin/runtests.sh
```
Options:
- `-i` to run in interpreted mode
- `-o` to enable optimizations in the compiler

### Running tests for compiler optimization
You can show the result of the optimizations with:
- `fasto.sh -p OPTS foo.fo`
where `OPTS` is a list of optimization passes, e.g., ic for just inlining and copy/constant propagation.

Ex. `./bin/fasto.sh -p ic tests/copyConstPropFold2.fo` 

For a detailed view over the `OPTS`:
```fsharp
let extractOpt (op : opt) =
    match op with
        | 'i' -> Some inlineOptimiseProgram
        | 'c' -> Some optimiseProgram
        | 'd' -> Some removeDeadBindings
        | 'D' -> Some removeDeadFunction
```
where `i` and `c` was just explained, and the rest is pretty selfexplanatory.


### Parameter list for `./bin/fasto.sh`
```fsharp
match paramList with
  | [|"-i"; file|] -> interpret (sanitiseFilename file)
  | [|"-r"; file|] -> let res = interpretSimple (sanitiseFilename file)
                      printfn "\n\nResult of 'main': %s\n" (AbSyn.ppVal 0 res)
  | [|"-c"; file|] -> compile  (sanitiseFilename file) (fun x -> x)
  | [|"-o"; file|] -> compile  (sanitiseFilename file) defaultOptimisations
  | [|"-o"; opts; file|] ->
      match extractOpts (explode opts) with
        | Some (opts') -> compile (sanitiseFilename file) opts'
        | None         -> bad ()
  | [|"-P"; file|] ->
      printOptimised (sanitiseFilename file) withoutOptimisations
  | [|"-p"; file|] ->
      printOptimised (sanitiseFilename file) defaultOptimisations
  | [|"-p"; opts; file|] ->
      match extractOpts (explode opts) with
          | Some (opts') -> printOptimised (sanitiseFilename file) opts'
          | None         -> bad ()
  | _ -> bad ()
```
Here is a detailed view over all params you can use for the fasto.sh file!

For more details and updates, check the commit history: [Commit History](https://github.com/simonsejse/FastoLangCompiler/commits/master/)
