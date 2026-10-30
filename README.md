# bnonni/homebrew-tap

Homebrew formulae from [bnonni](https://github.com/bnonni).

## create-ln-app

[create-ln-app](https://create-ln-app.dev) makes a Lightning app with a local regtest network.

```bash
brew install bnonni/tap/create-ln-app
create-ln-app my-lapp
cd my-lapp
npm run dev
```

Then open `http://localhost:5173` and pay your first invoice.

The formula installs Node.js. The regtest network also needs Docker with Docker Compose v2. Homebrew does not install Docker for you, because a formula cannot depend on a cask.

- On macOS, run `brew install --cask docker-desktop`, then start Docker Desktop.
- On Linux, install [Docker Engine](https://docs.docker.com/engine/install/).

For the options and the troubleshooting steps, see the [create-ln-app README](https://github.com/bnonni/create-ln-app#readme).

## Update the formula

The formula installs the npm tarball of create-ln-app. After a publish to npm, a maintainer runs the `bump` workflow:

```bash
gh workflow run bump --repo bnonni/homebrew-tap
```

The workflow sets `url` and `sha256` to the npm latest version. To set a different version, add `-f version=1.6.0`. The workflow installs and tests the formula, then pushes the change to `main`.

## Checks

The `tests` workflow runs on each push and pull request, on Linux and macOS. It runs `brew style`, `brew audit --strict --online`, `brew install --build-from-source`, and `brew test`.
