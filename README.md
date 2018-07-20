<div align="center">
  <span align="center"> <img width="80" height="70" class="center" src="git@github.com:arshubham/gitignore.git/blob/master/data/images/com.github.arshubham.gitignore.png" alt="Icon"></span>
  <h1 align="center">Gitignore</h1>
  <h3 align="center">Gitignore reference for various languages</h3>
</div>

<br/>

<p align="center">
    <a href="https://appcenter.elementary.io/com.github.arshubham.gitignore">
        <img src="https://appcenter.elementary.io/badge.svg">
    </a>
</p>

<p align="center">
  <a href="git@github.com:arshubham/gitignore.git/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-GPL-3.0-blue.svg">
  </a>
  <a href="git@github.com:arshubham/gitignore.git/releases">
    <img src="https://img.shields.io/badge/Release-v%201.0.0-orange.svg">
  </a>
</p>

<p align="center">
    <img  src="git@github.com:arshubham/gitignore.git/blob/master/data/images/screenshot.png" alt="Screenshot"> <br>
  <a href="git@github.com:arshubham/gitignore.git/issues/new"> Report a problem! </a>
</p>

## Installation

### Dependencies
These dependencies must be present before building:
 - `meson`
 - `valac`
 - `debhelper`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libgtksourceview-3.0-dev`


Use the App script to simplify installation by running `./app install-deps`
 
 ### Building

```
git clone git@github.com:arshubham/gitignore.git.git com.github.arshubham.gitignore && cd com.github.arshubham.gitignore
./app install-deps && ./app install
```

### Deconstruct

```
./app uninstall
```

### Development & Testing

Gitignore includes a script to simplify the development process. This script can be accessed in the main project directory through `./app`.

```
Usage:
  ./app [OPTION]

Options:
  clean             Removes build directories (can require sudo)
  generate-i18n     Generates .pot and .po files for i18n (multi-language support)
  install           Builds and installs application to the system (requires sudo)
  install-deps      Installs missing build dependencies
  run               Builds and runs the application
  test              Builds and runs testing for the application
  test-run          Builds application, runs testing and if successful application is started
  uninstall         Removes the application from the system (requires sudo)
```

### Contributing

To help, access the links below:

- [Guide on Code Style](git@github.com:arshubham/gitignore.git/wiki/Guide-on-code-style)

- [Proposing Design Changes](git@github.com:arshubham/gitignore.git/wiki/Proposing-Design-Changes)

- [Reporting Bugs](git@github.com:arshubham/gitignore.git/wiki/Reporting-Bugs)

- [Translate](git@github.com:arshubham/gitignore.git/wiki/Translate)


### License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE.md) file for details.
