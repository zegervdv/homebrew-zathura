# Zathura

Homebrew formulae to install zathura and plugins on Mac OS X

## Installation
Tap the repository:
```brew tap zegervdv/zathura```

__Before installing__


Install zathura and required plugins
```
brew install zathura
brew install zathura-pdf-poppler
```
Follow the instructions to link the plugins into place:
```
$ mkdir -p $(brew --prefix zathura)/lib/zathura
$ ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
```


__OSX_native_integration__

The OSX native integration (dock, window manager) has been added to the develop branch of zathura.
You can install it by
```
# unlink installed zathura and girara
brew unlink girara
brew unlink zathura

# install HEAD
brew install girara --HEAD
brew install zathura --HEAD
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
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
