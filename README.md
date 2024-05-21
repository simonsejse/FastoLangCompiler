# Compiler and Interpreter for the Fasto language (v1.0, 2024-04-28)


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

For more details and updates, check the commit history: [Commit History](https://github.com/simonsejse/FastoLangCompiler/commits/master/)
