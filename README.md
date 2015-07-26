# Zathura

Homebrew formulae to install zathura and plugins on Mac OS X

## Installation
Tap the repository:
```brew tap zegervdv/zathura```

Install zathura and required plugins
```
brew install zathura
brew install zathura-pdf-poppler
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
