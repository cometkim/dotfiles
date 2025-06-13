# My Environment

## OS environments

I use MacOS at work, Ubuntu at home. Check host before running any OS-dependent scripts.

## Tools & Aliases

Available tools, may replace other common tools in my shell environment.

- `lsd` replaces `ls`
  ```sh
  alias l="lsd"
  alias ls="lsd"
  alias lsa="lsd -a"
  alias ll="lsd -l"
  alias lla="lsd -la"
  alias lt="lsd --tree"
  ```
- `zoxide` replaces `cd`
- `gh`: GitHub CLI

## Scripting

Prefer using Node.js then Bash or Python for scripting.

Use `.mjs` extension to use ESM and top-level await.

## Workspace structure

My workspace is always placed under `~/Workspace` path.

- Projects: `~/Workspace/src/{url}`, url is same with the upstream repo.
  (E.g. `~/Workspace/src/github.com/cometkim/dotfiles`)
- Temp, PoC projects: `~/Workspace/tmp/{name}`

## Git Workflow

Always use GitHub workflow, so projects are mostly have two remote `upstream` and `origin`.

- If the Git repository is my own (`cometkim`), then I use `origin` as the main remote and no `upstream`.
- If the Git repository is my fork, then I use `upstream` as the main remote and `origin` as the forked repository.
- If the project uses more remote, the remote name follows the username on GitHub (if available)

And the workspace name follows `upstream` URL.

For example when I'm working on ReScript (`https://github.com/rescript-lang/rescript`):
- Workspace is `~/Workspace/src/github.com/rescript-lang/rescript`
- `upstream` is `https://github.com/rescript-lang/rescript.git`
- `origin` is `https://github.com/cometkim/rescript.git`
- `otheruser` is `https://github.com/otheruser/rescript.git`

Never use `git merge`, but rebase.

## Coding Style

Follow project's rule. If there're no explicit rules, then follow rules from here.

### JavaScript / TypeScript

- Use semicolons.
- Prefer single quote.
