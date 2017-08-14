# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraPs < Formula
  homepage "https://pwmt.org/projects/zathura-ps/"
  url "https://pwmt.org/projects/zathura-ps/download/zathura-ps-0.2.2.tar.gz"
  version "0.2.2"
  sha256 "e6546261db03b0b6b6499a8e109dc9ff3b8eb8b154ce45f5c6284c1e76d1d7a8"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'zathura'
  depends_on 'libspectre'

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-ps-Makefile.patch'
    sha256 "e726007906c015981945a973001eb36935f730a6d6032414593c2fdcef59ee89"
  end

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-ps-config.mk.patch'
    sha256 "c766cbe844d146b5d44571b2fe52c73fd897134f3b4763a0ceef3aa7548647e7"
  end

  def install
    ENV['PREFIX'] = prefix
    ENV['ZATHURA_BIN'] = Formula['zathura'].bin
    ENV['PLUGINDIR'] = lib
    system "make"
    system "make install"

  end

  def caveats
    <<-EOS.undent
      To enable this plugin you will need to link it in place.
      First create the plugin directory if it does not exist yet:
        $ mkdir -p $(brew --prefix zathura)/lib/zathura
      Then link the .dylib to the directory:
        $ ln -s $(brew --prefix zathura-ps)/lib/ps.dylib $(brew --prefix zathura)/lib/zathura/ps.so

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
