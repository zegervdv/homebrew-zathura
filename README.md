# Zathura

Homebrew formulae to install zathura and plugins on Mac OS X

## Installation
Tap the repository:
```brew tap zegervdv/homebrew-zathura```

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
Thanks to @geigi (see #5)

## Known Issues
Currently plugins are installed in the zathura folder, which means that uninstalling
a plugin does not work.
