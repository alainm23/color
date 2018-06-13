## Color
Create and save perfect palettes in seconds!

## Installation

### Dependencies
These dependencies must be present before building

 - `meson`
 - `valac`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libglib2.0-dev`
 - `libsqlite3-dev`

### Building

```
meson build --prefix=/usr
cd build
ninja test
```
To install, use `ninja install`, then execute with `com.github.alainm23.color`
```
sudo ninja install
com.github.alainm23.color
```

### Deconstruct

```
sudo ninja uninstall
```
