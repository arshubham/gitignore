<div align="center">
  <span align="center">     <a href="https://appcenter.elementary.io/com.github.arshubham.gitignore"><img width="80" height="80" class="center" src="https://raw.githubusercontent.com/arshubham/gitignore/master/data/images/com.github.arshubham.gitignore.png" alt="Icon">    </a></span>
  <h1 align="center">Gitignore</h1>
  <h3 align="center">Gitignore reference for various languages</h3>
</div>

<br/>

<p align="center">
  <a href="https://github.com/arshubham/gitignore/blob/master/LICENSE.md">
    <img src="https://img.shields.io/badge/license-GPLv3-brightgreen.svg">
  </a>
</p>

<p align="center">
    <img  src="https://raw.githubusercontent.com/arshubham/gitignore/master/data/images/Screenshot-1.png" alt="Screenshot-1"> <br>
    <img  src="https://raw.githubusercontent.com/arshubham/gitignore/master/data/images/Screenshot-3.png" alt="Screenshot-3"> <br>
  <a href="https://github.com/arshubham/gitignore/issues"> Report a problem! </a>
</p>

### Dependencies
These dependencies must be present before building:
 - `meson`
 - `valac`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libgranite-3.0-dev`
 - `libsoup2.4-dev`


<h2>Installation</h2>
<br>

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

### License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE.md) file for details.
