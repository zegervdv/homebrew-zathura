# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class ZathuraDjvu < Formula
  desc ""
  homepage ""
  url "https://pwmt.org/projects/zathura-djvu/download/zathura-djvu-0.2.6.tar.gz"
  sha256 "aefef6a3b702fa06145f16f2559490f4d96d3206bafd4e0c78ac184788cac05f"

  depends_on :x11
  depends_on 'zathura'
  depends_on 'djvulibre'
  depends_on 'pkg-config'

  patch :p1 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-djvu-patch-Makefile.diff'
    sha256 'e26dbf219c58e1d3537ac2a478b0275ea4d50b9ccea05005d93f297f901da751'
  end

  patch :p1 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/master/zathura-djvu-patch-config.mk.diff'
    sha256 '1528cf683de8c6af2425c9f1ec062acfddd5e558f8017a4c50f679e09aaac0c8'
  end

  def install
    # Current prefix is not the zathura prefix
    # Replace it in the makefile
    inreplace "Makefile", /\$\{PREFIX\}\/bin\/zathura/, "#{Formula['zathura'].prefix}/bin/zathura"
    ENV['PREFIX'] = prefix
    ENV['PLUGINDIR'] = lib
    system "make", "install" # if this fails, try separate make/make install steps
  end

  def caveats
    <<-EOS.undent
      To enable this plugin you will need to link it in place.
      First create the plugin directory if it does not exist yet:
        $ mkdir -p $(brew --prefix zathura)/lib/zathura
      Then link the .dylib to the directory:
        $ ln -s $(brew --prefix zathura-djvu)/lib/djvu.dylib $(brew --prefix zathura)/lib/zathura/djvu.so

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
