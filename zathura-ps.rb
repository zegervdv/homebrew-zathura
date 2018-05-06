# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraPs < Formula
  homepage "https://pwmt.org/projects/zathura-ps/"
  url "https://pwmt.org/projects/zathura-ps/download/zathura-ps-0.2.6.tar.xz"
  version "0.2.6"
  sha256 "7eb085b41fc88979f997310b4e703455e6a81b6ef1ae7db0b6324b6f13c2cf73"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'zathura'
  depends_on 'libspectre'

  def install
    inreplace "meson.build", "zathura.get_pkgconfig_variable('plugindir')", "'#{prefix}'"
    system "mkdir build"
    system "meson build --datadir #{prefix}"
    system "cd build && ninja && ninja install"
  end

  def caveats
    <<-EOS
      To enable this plugin you will need to link it in place.
      First create the plugin directory if it does not exist yet:
        $ mkdir -p $(brew --prefix zathura)/lib/zathura
      Then link the .dylib to the directory:
        $ ln -s $(brew --prefix zathura-ps)/libps.dylib $(brew --prefix zathura)/lib/zathura/libps.dylib

      More information as to why this is needed: https://github.com/zegervdv/homebrew-zathura/issues/19
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura-ps`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
