# cabal-template

Minimal template with nix flakes, with materialization and cross-compilation support.

## Preparing a project

1. Change the project name. This includes the cabal file's name, references inside the cabal file, and ``flake.nix``
2. Change the license inside the ``.cabal`` file (default is MIT)
3. Pick a ghc version, preferably one that is [cached](https://input-output-hk.github.io/haskell.nix/reference/supported-ghc-versions.html) by ``haskell.nix``
4. Change the description within the cabal file and ``flake.nix``
5. Run ``nix develop``. Take note of the index state from the trace logs
6. Set the index-state within ``flake.nix`` and ``cabal.project``

## Materializing dependencies

Before running the steps, make sure every line of ``plan-sha256`` and ``materialized`` is commented out.

1. Run ``nix build '.#gcroot' -o gcroot``. This creates a ``gcroot`` folder that should not be added to version control.
2. Run ``materialize.sh``. This creates a ``materialized`` folder that **should** be added to version control.  
   Hashes printed onto the console need to be set in the corresponding ``plan-sha256`` variables in ``flake.nix``.
   
## Cross-compiling the executable

An example command for cross-compiling to Windows x64 (where ``hello-project`` is the project name):
```
nix build .#x86_64-w64-mingw32:hello-project:exe:hello-project
```
``flake.nix`` must have the desired platform defined in ``crossPlatforms`` for this to work.

Here is a [list](https://github.com/NixOS/nixpkgs/blob/master/lib/systems/examples.nix) of all the supported platform's configuration names.
