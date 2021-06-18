  { gh-actions-dhall =
      https://raw.githubusercontent.com/awseward/gh-actions-dhall/0.3.2/package.dhall
        sha256:68a54da7afaf63133bd2f5cb049c5a42ab008491d0bfe95189ae31694230d603
  }
⫽ (   env:DHALL_MISC
    ? https://raw.githubusercontent.com/awseward/dhall-misc/20210618093657/package.dhall
        sha256:401dd621799f1481244580856c2fd18f7c0ba9323c7b5b3a309b4e3017c9c57b
  ).{ GHA, job-templates, actions-catalog }
