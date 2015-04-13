# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraPs < Formula
  homepage "https://pwmt.org/projects/zathura-ps/"
  url "https://pwmt.org/projects/zathura-ps/download/zathura-ps-0.2.2.tar.gz"
  version "0.2.2"
  sha1 "35340171aa7dab6d2bed8a1b94a68ff5ee76e2eb"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'zathura'
  depends_on 'libspectre'

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-ps-Makefile.patch'
    sha1 '8c0ddb9b7e709376c437b0283306cc1f7c0f5b9a'
  end

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-ps-config.mk.patch'
    sha1 '2303727d83fca7446d1d20825d22ca3e5b899dc0'
  end

  def install
    ENV['PREFIX'] = prefix
    ENV['ZATHURA_BIN'] = Formula['zathura'].bin
    system "make"
    system "make install"

    # Rename dylib to so
    mv Formula['zathura'].lib/"zathura/ps.dylib", Formula['zathura'].lib/"zathura/ps.so"
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
