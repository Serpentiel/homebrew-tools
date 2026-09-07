<!-- markdownlint-disable -->
<div id="top"></div>

<div align="center">
  <a href="https://github.com/Serpentiel/homebrew-tools/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/Serpentiel/homebrew-tools.svg?style=for-the-badge" alt="Contributors" height="28">
  </a>
  <a href="https://github.com/Serpentiel/homebrew-tools/network/members">
    <img src="https://img.shields.io/github/forks/Serpentiel/homebrew-tools.svg?style=for-the-badge" alt="Forks" height="28">
  </a>
  <a href="https://github.com/Serpentiel/homebrew-tools/stargazers">
    <img src="https://img.shields.io/github/stars/Serpentiel/homebrew-tools.svg?style=for-the-badge" alt="Stars" height="28">
  </a>
  <a href="https://github.com/Serpentiel/homebrew-tools/issues">
    <img src="https://img.shields.io/github/issues/Serpentiel/homebrew-tools.svg?style=for-the-badge" alt="Issues" height="28">
  </a>
  <a href="https://github.com/Serpentiel/homebrew-tools/blob/main/LICENSE.md">
    <img src="https://img.shields.io/github/license/Serpentiel/homebrew-tools.svg?style=for-the-badge" alt="License" height="28">
  </a>
  <br>
  <br>
  <a href="https://github.com/Serpentiel/homebrew-tools">
    <img src="https://github.com/Serpentiel/homebrew-tools/blob/repo-assets/README.md/logo.png" alt="Logo" width="256" height="256">
  </a>
  <h3>homebrew-tools</h3>
  <p>Custom Tools for Enhanced Productivity</p>
  <br>
  <br>
  <p>
    <a href="https://github.com/Serpentiel/homebrew-tools/issues/new?labels=question&template=01_question.md">Ask a Question</a>
    &bullet;
    <a href="https://github.com/Serpentiel/homebrew-tools/issues/new?labels=bug&template=02_bug.md">Report a Bug</a>
    &bullet;
    <a href="https://github.com/Serpentiel/homebrew-tools/issues/new?labels=enhancement&template=03_feature.md">Request a Feature</a>
  </p>
</div>
<details>
  <summary>Table of Contents</summary>
  <ul>
    <li>
      <a href="#about-the-project">1. About the Project</a>
    </li>
    <li>
      <a href="#getting-started">2. Getting Started</a>
      <ul>
        <li>
          <a href="#prerequisites">2.1. Prerequisites</a>
        </li>
        <li>
          <a href="#installation">2.2. Installation</a>
        </li>
      </ul>
    </li>
    <li>
      <a href="#usage">3. Usage</a>
    </li>
    <li>
      <a href="#contributing">4. Contributing</a>
    </li>
    <li>
      <a href="#license">5. License</a>
    </li>
  </ul>
</details>
<!-- markdownlint-restore -->

## About the Project

`homebrew-tools` is a personal repository of Homebrew formulae and casks, offering a range of tools developed to
enhance productivity and ease of use on macOS.

The tap ships `betterglobekey-companion`, the graphical configuration editor for
[`betterglobekey`](https://github.com/Serpentiel/betterglobekey) — a rework of the macOS Globe key for faster input
source switching. `betterglobekey` itself lives in `homebrew/core` and no longer needs this tap.

<!-- markdownlint-disable -->
<p align="right"><a href="#top">(back to top)</a></p>
<!-- markdownlint-restore -->

## Getting Started

### Prerequisites

- macOS with Homebrew installed
- Basic knowledge of using terminal and Homebrew

### Installation

`betterglobekey` comes from `homebrew/core` — no tap required:

```bash
brew install betterglobekey
```

The companion is a cask from this tap, and pulls in the `betterglobekey` formula:

```bash
brew install --cask serpentiel/tools/betterglobekey-companion
```

> **N.B.** Existing tap installations of `betterglobekey` migrate to `homebrew/core` automatically on `brew update`.

<!-- markdownlint-disable -->
<p align="right"><a href="#top">(back to top)</a></p>
<!-- markdownlint-restore -->

## Usage

Configure `betterglobekey` from the terminal, or through the companion app. The configuration format and every option
are covered in the
[`betterglobekey` documentation](https://github.com/Serpentiel/betterglobekey/blob/main/docs/README.md).

<!-- markdownlint-disable -->
<p align="right"><a href="#top">(back to top)</a></p>
<!-- markdownlint-restore -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create, so any
contributions you make are greatly appreciated.

If you would like to contribute, please make sure to take a look
at [this guideline](https://github.com/Serpentiel/homebrew-tools/blob/main/CONTRIBUTING.md) beforehand.

Please see our [security policy](https://github.com/Serpentiel/homebrew-tools/blob/main/SECURITY.md) to report any possible
vulnerabilities or serious issues.

<!-- markdownlint-disable -->
<p align="right"><a href="#top">(back to top)</a></p>
<!-- markdownlint-restore -->

## License

Distributed under the MIT License. See [`LICENSE.md`](https://github.com/Serpentiel/homebrew-tools/blob/main/LICENSE.md)
for more information.

> **N.B.** This project explicitly does not require its contributors to sign a _Contributor License Agreement_ nor does
> it possess one.

<!-- markdownlint-disable -->
<p align="right"><a href="#top">(back to top)</a></p>
<!-- markdownlint-restore -->
