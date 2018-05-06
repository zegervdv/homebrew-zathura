# Zathura

Homebrew formulae to install zathura and plugins on Mac OS X

## Installation
Tap the repository:
```brew tap zegervdv/zathura```

__Before installing__

Install the latest `meson` package from `HEAD`:
```
$ brew install --HEAD meson
```
A bug in the latest stable version was fixed but has not been released yet.

Install zathura and required plugins
```
brew install zathura
brew install zathura-pdf-poppler
```
Follow the instructions to link the plugins into place:
```
$ mkdir -p $(brew --prefix zathura)/lib/zathura
$ ln -s $(brew --prefix zathura-pdf-poppler)/lib/pdf.dylib $(brew --prefix zathura)/lib/zathura/pdf.so
```

### Copying to clipboard
Add the following to your `~/.config/zathura/zathurarc`:
```
set selection-clipboard clipboard
```
Thanks to [geigi](https://github.com/geigi) (see [#5](https://github.com/zegervdv/homebrew-zathura/issues/5))

## Known Issues
Currently plugins are installed in the zathura folder, which means that uninstalling
a plugin does not work.
