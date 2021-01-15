-- Usage: yaml-to-dhall ./schema.dhall --file ./action.yml --records-loose
--
let Prelude =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/v20.0.0/Prelude/package.dhall sha256:21754b84b493b98682e73f64d9d57b18e1ca36a118b81b33d0a243de8455814b

let Input =
      { description : Text, required : Optional Bool, default : Optional Text }

in  { name : Text, description : Text, inputs : Prelude.Map.Type Text Input }
