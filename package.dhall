let imports =
      { GHA =
          https://raw.githubusercontent.com/awseward/dhall-misc/5cd89bd529926b2e06e04731c87c02e07b3423b8/GHA/package.dhall sha256:c646e22542997a419218871938b9c902aeb9ed134116ad0e5ca06bd119d2c663
      }

let GHA = imports.GHA

let name = "awseward/gh-actions-dhall"

let version = "0.2.5"

let Inputs = { Type = { dhallVersion : Text }, default.dhallVersion = "1.36.0" }

let mkStep =
      λ(common : GHA.Step.Common.Type) →
      λ(inputs : Inputs.Type) →
        GHA.Step.mkUses
          common
          GHA.Step.Uses::{ uses = "${name}@${version}", `with` = toMap inputs }

in  { mkStep, Inputs } ⫽ GHA.Step.{ Common }
