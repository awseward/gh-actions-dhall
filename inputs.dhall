let Prelude = (./imports.dhall).Prelude

let JSON = Prelude.JSON

let type =
      { dhallVersion : Text
      , typecheck_no_cache : Bool
      , typecheck_package_files_only : Bool
      }

in  { Type = type
    , default =
      { dhallVersion = "1.39.0"
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
