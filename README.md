# Benchmark for zip package

The time consumed by `copyEntry` in the `zip` Haskell package is quite huge and this example demonstrates that.

# Running the benchmark

1. Build the representative program.

   `$ stack build`

2. Download the representative input [here](https://drive.google.com/file/d/0BzZRqRiH9sHyUXBSODN1LUZfVVU/view?usp=sharing) and extract the contents to the root of this repo.

3. Run the program with timing:

   `time stack exec -- zip-bench HSbase-4.8.2.0.jar HSghc-prim-0.4.0.0.jar HSinteger-0.5.1.0.jar HSrts-0.1.0.0.jar`

   The observed time will come out to be ~20 seconds on first run and ~8 seconds on subsequent runs (observed on OS X, most likely due to OS-level specifics).

4. To investigate which functions are consuming the most time, build with profiling

   `stack build --executable-profiling --library-profiling --ghc-options="-fprof-auto -rtsopts"`

   and run the following command:

   `stack exec -- zip-bench HSbase-4.8.2.0.jar HSghc-prim-0.4.0.0.jar HSinteger-0.5.1.0.jar HSrts-0.1.0.0.jar +RTS -p`
