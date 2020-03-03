# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraPdfPoppler < Formula
  homepage "https://pwmt.org/projects/zathura-pdf-poppler/"
  url "https://github.com/pwmt/zathura-pdf-poppler/archive/0.3.0.tar.gz"
  version "0.3.0"
  sha256 "2034f70a936d458ddc9276f769e77ff308ba3bb1b7a7cdc87bab8b9ef7ade84a"

  depends_on 'zathura'
  depends_on 'poppler'
  depends_on 'pkg-config'

  def install
    inreplace "meson.build", "zathura.get_pkgconfig_variable('plugindir')", "prefix"
    system "mkdir build"
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"

  end

  def caveats
    <<-EOS
      To enable this plugin you will need to link it in place.
      First create the plugin directory if it does not exist yet:
        $ mkdir -p $(brew --prefix zathura)/lib/zathura
      Then link the .dylib to the directory:
        $ ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

      More information as to why this is needed: https://github.com/zegervdv/homebrew-zathura/issues/19
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura-pdf-poppler`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
