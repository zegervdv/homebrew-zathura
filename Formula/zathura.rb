class Zathura < Formula
  desc "PDF viewer"
  homepage "https://pwmt.org/projects/zathura/"
  url "https://github.com/pwmt/zathura/archive/0.4.9.tar.gz"
  sha256 "82235cbc89899421fca98477265626f2149df7d072740f0360550cc8d4e449d6"
  revision 0
  head "https://github.com/pwmt/zathura.git", branch: "develop"

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "adwaita-icon-theme"
  depends_on "desktop-file-utils"
  depends_on "gettext"
  depends_on "girara"
  depends_on "glib"
  depends_on "intltool"
  depends_on "libmagic"
  depends_on "sphinx"
  depends_on "sphinx-doc"
  depends_on "synctex" => :optional
  on_macos do
    depends_on "gtk-mac-integration"
  end

  def install
    # Set Homebrew prefix
    ENV["PREFIX"] = prefix
    # Add the pkgconfig for girara to the PKG_CONFIG_PATH
    # TODO: Find out why it is not added correctly for Linux
    ENV["PKG_CONFIG_PATH"] = "#{ENV["PKG_CONFIG_PATH"]}:#{Formula["girara"].prefix}/lib/x86_64-linux-gnu/pkgconfig"
    
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    system "true" # TODO
  end
end
