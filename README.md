# gh-actions-dhall

A GitHub Action which typechecks and lints all [Dhall] files in a repository.

## Inputs

### `dhallVersion`

**Default:** [`1.39.0`](https://github.com/dhall-lang/dhall-haskell/releases/tag/1.39.0)

The version of [dhall-haskell] to use.

### `typecheck_no_cache`

**Default:** `false`

Set this to `true` in order to disable caching.

### `typecheck_package_files_only`

**Default:** `false`

Set this to `true` to only typecheck files named `package.dhall`. Please note
that doing so will miss files which aren't referenced directly or transitively
from any `package.dhall` files.

[dhall]: https://dhall-lang.org/
[dhall-haskell]: https://github.com/dhall-lang/dhall-haskell
