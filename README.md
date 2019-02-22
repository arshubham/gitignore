<div align="center">
  <span align="center">  <a href="https://appcenter.elementary.io/com.github.arshubham.gitignore"><img width="80" height="80" class="center" src="https://raw.githubusercontent.com/arshubham/gitignore/master/data/images/com.github.arshubham.gitignore.png" alt="Icon">    </a></span>
  <h1 align="center">Gitignore</h1>
  <h3 align="center">Gitignore reference for various languages</h3>
</div>

<p align="center">
  <a href="https://github.com/arshubham/gitignore/blob/master/LICENSE.md">
    <img src="https://img.shields.io/badge/license-GPLv3-brightgreen.svg">
  </a>
</p>


<p align="center">
    <img src="https://github.com/arshubham/gitignore/blob/master/data/images/Screenshot-1.png" alt="Screenshot">
    <table>
      <tr>
        <td>
          <img src="https://github.com/arshubham/gitignore/blob/master/data/images/Screenshot-3.png" alt="Screenshot">
        </td>
        <td>
          <img src="https://github.com/arshubham/gitignore/blob/master/data/images/Screenshot-2.png" alt="Screenshot">
        </td>
        <td>
          <img src="https://github.com/arshubham/gitignore/blob/master/data/images/Screenshot-4.png" alt="Screenshot">
        </td>
      </tr>
    </table>
</p>

<p align="center">
 <a href="https://github.com/arshubham/gitignore/issues"> Report a problem! </a>
</p>

# Contents
 - [Prerequisites](https://github.com/manavbabber/gitignore#prerequisites)
 - [Installation](https://github.com/manavbabber/gitignore#installation)
 - [Contributing workflow](https://github.com/manavbabber/gitignore/blob/master/README.md#contributing-workflow)
 - [Special Thanks](https://github.com/manavbabber/gitignore/blob/master/README.md#special-thanks)
 - [License](https://github.com/manavbabber/gitignore#-license-)

# Prerequisites
Dependencies required before building:
 - `meson`
 - `valac`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libgranite-3.0-dev`
 - `libsoup2.4-dev`
 - `libsqlite3-dev`


# Installation

```
git clone https://github.com/arshubham/gitignore.git
cd gitignore
meson build --prefix=/usr
```
```
cd build
ninja
sudo ninja install
```
# Contributing workflow
Here’s how we suggest you go about proposing a change to this project:

1. [Fork this project][fork] to your account.
2. [Create a branch][branch] for the change you intend to make.
3. Make your changes to your fork.
4. [Send a pull request][pr] from your fork’s branch to our `master` branch.

Using the web-based interface to make changes is fine too, and will help you
by automatically forking the project and prompting to send a pull request too

[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository
[pr]: https://help.github.com/articles/using-pull-requests/

# Special Thanks 
- [Nathan Bnm](https://github.com/NathanBnm) for his help in French translations
- [Sahil Arora](https://github.com/sahilarora3117) for icon

# License 
This project is distributed under the terms of the GNU General Public License, version 3 - see the [LICENSE.md](LICENSE.md) file for details.
