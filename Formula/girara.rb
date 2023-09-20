class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.4.0.tar.gz"
  sha256 "24edfa3d493e7d4bbf491bb730d036cfedbd6c34ada1a7cfcd6273e78cffa44c"
  head "https://github.com/pwmt/girara.git", branch: "develop"

  bottle do
    root_url "https://ghcr.io/v2/zegervdv/zathura"
    rebuild 1
    sha256 ventura:      "de3d8697345a2f225cc0ea5b24f78935b8f19062faa847785051d52bea637ea1"
    sha256 x86_64_linux: "a4d3262b78ef8c778dda19e6e078c9fce68b862b51d44470eca325cf26648b2c"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "cmake"
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "json-c"
  depends_on "json-glib"
  depends_on "libnotify"
  depends_on "libpthread-stubs"

  def install
    inreplace "girara/utils.c" do |s|
      s.gsub!(/xdg-open/, "open")
    end
    # Set HOMBREW_PREFIX
    ENV["CMAKE_INSTALL_PREFIX"] = prefix

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
