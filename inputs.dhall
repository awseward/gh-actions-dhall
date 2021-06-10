let Prelude =
      https://prelude.dhall-lang.org/v20.0.0/package.dhall
        sha256:21754b84b493b98682e73f64d9d57b18e1ca36a118b81b33d0a243de8455814b

let JSON = Prelude.JSON

let type =
      { dhallVersion : Text
      , typecheck_no_cache : Bool
      , typecheck_package_files_only : Bool
      }

in  { Type = type
    , default =
      { dhallVersion = "1.36.0"
      , typecheck_no_cache = False
      , typecheck_package_files_only = False
      }
    , toJSON =
        λ(inputs : type) →
          toMap
            { dhallVersion = JSON.string inputs.dhallVersion
            , typecheck_no_cache = JSON.bool inputs.typecheck_no_cache
            , typecheck_package_files_only =
                JSON.bool inputs.typecheck_package_files_only
            }
    }
