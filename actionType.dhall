{ description : Text
, inputs :
    { clean : { default : Bool, description : Text }
    , fetch-depth : { default : Natural, description : Text }
    , lfs : { default : Bool, description : Text }
    , path : { description : Text }
    , persist-credentials : { default : Bool, description : Text }
    , ref : { description : Text }
    , repository : { default : Text, description : Text }
    , ssh-key : { description : Text }
    , ssh-known-hosts : { description : Text }
    , ssh-strict : { default : Bool, description : Text }
    , submodules : { default : Bool, description : Text }
    , token : { default : Text, description : Text }
    }
, name : Text
, runs : { main : Text, post : Text, `using` : Text }
}
