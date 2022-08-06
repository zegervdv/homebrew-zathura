class ZathuraPs < Formula
  desc "Postscript backend plugin for zathura"
  homepage "https://pwmt.org/projects/zathura-ps/"
  url "https://github.com/pwmt/zathura-ps/archive/0.2.6.tar.gz"
  sha256 "08c1927bfb8a40e201fa3638f9523d4b6d70e3444ef070bd4aa8a869b6574567"

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "libspectre"
  depends_on "zathura"

  def install
    inreplace "meson.build", "zathura.get_pkgconfig_variable('plugindir')", "'#{prefix}'"
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
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
    system "true" # TODO
  end
end
