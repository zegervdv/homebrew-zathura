class ZathuraCb < Formula
  desc "Comic book plugin for zathura"
  homepage "https://pwmt.org/projects/zathura-cb/"
  url "https://pwmt.org/projects/zathura-cb/download/zathura-cb-0.1.8.tar.xz"
  sha256 "452a0702e257dbed6a84b7faf6b51e4eb57a163654bbcddf6301143d3770ccc4"

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "libarchive"
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
        $ ln -s $(brew --prefix zathura-cb)/libcb.dylib $(brew --prefix zathura)/lib/zathura/libcb.dylib

      More information as to why this is needed: https://github.com/zegervdv/homebrew-zathura/issues/19
    EOS
  end

  test do
    system "true" # TODO
  end
end
