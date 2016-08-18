# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Zathura < Formula
  homepage "https://pwmt.org/projects/zathura/"
  url "https://pwmt.org/projects/zathura/download/zathura-0.3.6.tar.gz"
  version "0.3.6"
  sha1 "db5e76815fdfd0c2d6b5d5c16492995720268440"

  # depends_on "cmake" => :build
  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'pkg-config'
  depends_on "libmagic"
  depends_on "gettext"
  depends_on "girara"
  depends_on "gnome-icon-theme"
  depends_on "glib"
  depends_on "desktop-file-utils"
  depends_on "intltool"

  # patch :p0 do
  #   url "https://raw.githubusercontent.com/zegervdv/homebrew-zathura/master/zathura-main.c.patch"
  #   sha1 "8bfffd0ac105f8094eb0019feeec23b9155985f4"
  # end
  
  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-zathura/raw/1efa3c89cd454cac88729c7334f9ee46e254b299/zathura.h.patch'
    sha256 '07c3948280cbe4f757c6c86761845a637092a4e433f53be28362bec3f7fe4237'
  end


  def install
    # Set Homebrew prefix
    ENV['PREFIX'] = prefix
    system "make"
    ENV.deparallelize
    system "make install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
