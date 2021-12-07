-- This probably belongs on the library side of things…
let Prelude = (./imports.dhall).Prelude

let Map = Prelude.Map

let JSON = Prelude.JSON

in  λ(Inputs : Type) →
    λ(fn : Inputs → Prelude.Map.Type Text JSON.Type) →
      { Type = Inputs, toJSON = λ(x : Inputs) → JSON.object (fn x) }
