# Section 1.3

Two ways to load source file into GHCi, `stack ghci hello.hs`;
or `stack ghci`, then `:l hello`.

Run the `main` function after loading with `main`.

# QC 1.1

With stack instead of Haskell Platform, compile source file with
`stack ghc hello.hs`, or with specified binary name:
`stack ghc -- hello.hs -o helloworld`.

# Summary

The develop workflow for Python and Haskell are both the loop:
edit source file -> load into repl -> run the function ->
add something new in the source file -> reload into repl -> test again ...

For Python, load/reload source file with `import <file-name>` in IPython repl.
For Haskell, load/reload source file with `:l <file-name>` in GHCi repl.

## Q1.1
```
Prelude> 2 ^ 123
10633823966279326983230456482242756608
```

## Q1.2

```
stack ghc -- first_prog.hs -o email
./email
```
