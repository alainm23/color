## Color View
Visualizer and color converter to hex, rgb, etc 

## Installation

### Dependencies
These dependencies must be present before building

 - `meson`
 - `valac`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libglib2.0-dev`

### Building

```
meson build --prefix=/usr
cd build
ninja test
```
To install, use `ninja install`, then execute with `com.github.alainm23.colorview`
```
sudo ninja install
com.github.alainm23.colorview
```

### Deconstruct

```
sudo ninja uninstall
```
