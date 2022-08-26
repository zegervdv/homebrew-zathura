class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.3.7.tar.gz"
  sha256 "41342213f8e745258f1db28cbb6ccc27a63009a5e001bf791bbe01ce436d4db7"
  head "https://github.com/pwmt/girara.git", branch: "develop"

  bottle do
    root_url "https://github.com/zegervdv/homebrew-zathura/releases/download/girara-0.3.7"
    sha256 big_sur:      "edcefda742a6b7706e2c38a5fa09a5eb55e598b8f2e3edbe0de45647c1a2ac0f"
    sha256 x86_64_linux: "a2537e075aa5e0b537bb4bc2efb821580f06766bd8cccefa3d2c0c6e0f96d96a"
  end

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "json-c"
  depends_on "libnotify"

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
