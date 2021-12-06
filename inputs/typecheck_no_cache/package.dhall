let imports = ../imports.dhall

let JSON = imports.JSON

in  { default = ./default.dhall ? JSON.null
    , deprecationMessage = Some ./deprecationMessage.dhall as Text ? None Text
    , description = ./description.txt as Text
    , required = ./required.dhall
    }
