# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraDjvu < Formula
  desc "Zathura DJVU plugin"
  homepage "https://pwmt.org/projects/zathura-djvu/"
  url "https://pwmt.org/projects/zathura-djvu/download/zathura-djvu-0.2.8.tar.xz"
  sha256 "d0e664d5312bdc0674fdf8cc6e259c9ee1365714172bc809f9c0f69659d8b32b"
  version "0.2.8"

  depends_on :x11
  depends_on 'zathura'
  depends_on 'djvulibre'
  depends_on 'pkg-config'

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
        $ ln -s $(brew --prefix zathura-djvu)/libdjvu.dylib $(brew --prefix zathura)/lib/zathura/libdjvu.dylib

      More information as to why this is needed: https://github.com/zegervdv/homebrew-zathura/issues/19
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura-djvu`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
