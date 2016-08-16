# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraPdfPoppler < Formula
  homepage "https://pwmt.org/projects/zathura-pdf-poppler/"
  url "https://pwmt.org/projects/zathura-pdf-poppler/download/zathura-pdf-poppler-0.2.5.tar.gz"
  version "0.2.5"
  sha256 "7baa6b12526c13c4088eb206147d6cb3539f53b8"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'zathura'
  depends_on 'poppler'
  depends_on 'pkg-config'

  # Apply patches from http://stackoverflow.com/a/29460237
  patch :p0 do
    url "https://raw.githubusercontent.com/zegervdv/homebrew-zathura/master/zathura-pdf-poppler-config.mk.diff"
    sha256 "beebbe4112b84a1c2c196f7eede68390026e4dc7"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/zegervdv/homebrew-zathura/master/zathura-pdf-poppler-Makefile.diff"
    sha256 "2b70a49572e5cd538402a3e9968a1093f2762154"
  end

  def install
    inreplace "Makefile", /\$\{PREFIX\}\/bin\/zathura/, "#{Formula['zathura'].prefix}/bin/zathura"
    ENV['PREFIX'] = prefix
    system "make"
    system "make install"

    # Rename pdf.dylib to pdf.so to make it work
    mv "#{Formula['zathura'].prefix}/lib/zathura/pdf.dylib", "#{Formula['zathura'].prefix}/lib/zathura/pdf.so"
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
