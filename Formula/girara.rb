class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.4.0.tar.gz"
  sha256 "24edfa3d493e7d4bbf491bb730d036cfedbd6c34ada1a7cfcd6273e78cffa44c"
  head "https://github.com/pwmt/girara.git", branch: "develop"

  bottle do
    root_url "https://github.com/zegervdv/homebrew-zathura/releases/download/girara-0.3.7"
    rebuild 2
    sha256 monterey:     "e937d11bdd14a93d178c90d0ae7a76d9a07ec8e02469d5adabc75094ebf9e185"
    sha256 x86_64_linux: "e4f555c3f8da92f701a427a11f266722fd68c5ead0dac59b3e49992b37cdf9d3"
  end

  depends_on "cmake" => :build, :install
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "json-c"
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
