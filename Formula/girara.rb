class Girara < Formula
  desc "Interface library"
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.3.7.tar.gz"
  sha256 "41342213f8e745258f1db28cbb6ccc27a63009a5e001bf791bbe01ce436d4db7"
  head "https://github.com/pwmt/girara.git", branch: "develop"

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+3"
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
