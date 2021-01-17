{ description = "Checkout a Git repository at a particular version"
, inputs =
  { clean =
    { default = True
    , description =
        "Whether to execute `git clean -ffdx && git reset --hard HEAD` before fetching"
    }
  , fetch-depth =
    { default = 1
    , description =
        "Number of commits to fetch. 0 indicates all history for all branches and tags."
    }
  , lfs = { default = False, description = "Whether to download Git-LFS files" }
  , path.description
    = "Relative path under \$GITHUB_WORKSPACE to place the repository"
  , persist-credentials =
    { default = True
    , description =
        "Whether to configure the token or SSH key with the local git config"
    }
  , ref.description
    =
      ''
      The branch, tag or SHA to checkout. When checking out the repository that triggered a workflow, this defaults to the reference or SHA for that event.  Otherwise, uses the default branch.
      ''
  , repository =
    { default = "\${{ github.repository }}"
    , description = "Repository name with owner. For example, actions/checkout"
    }
  , ssh-key.description
    =
      ''
      SSH key used to fetch the repository. The SSH key is configured with the local git config, which enables your scripts to run authenticated git commands. The post-job step removes the SSH key.

      We recommend using a service account with the least permissions necessary.

      [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
      ''
  , ssh-known-hosts.description
    =
      ''
      Known hosts in addition to the user and global host key database. The public SSH keys for a host may be obtained using the utility `ssh-keyscan`. For example, `ssh-keyscan github.com`. The public key for github.com is always implicitly added.
      ''
  , ssh-strict =
    { default = True
    , description =
        ''
        Whether to perform strict host key checking. When true, adds the options `StrictHostKeyChecking=yes` and `CheckHostIP=no` to the SSH command line. Use the input `ssh-known-hosts` to configure additional hosts.
        ''
    }
  , submodules =
    { default = False
    , description =
        ''
        Whether to checkout submodules: `true` to checkout submodules or `recursive` to recursively checkout submodules.

        When the `ssh-key` input is not provided, SSH URLs beginning with `git@github.com:` are converted to HTTPS.
        ''
    }
  , token =
    { default = "\${{ github.token }}"
    , description =
        ''
        Personal access token (PAT) used to fetch the repository. The PAT is configured with the local git config, which enables your scripts to run authenticated git commands. The post-job step removes the PAT.

        We recommend using a service account with the least permissions necessary. Also when generating a new PAT, select the least scopes necessary.

        [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
        ''
    }
  }
, name = "Checkout"
, runs = { main = "dist/index.js", post = "dist/index.js", `using` = "node12" }
}
