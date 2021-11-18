# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Zathura < Formula
  homepage "https://pwmt.org/projects/zathura/"
  url "https://github.com/pwmt/zathura/archive/0.4.8.tar.gz"
  head "https://git.pwmt.org/pwmt/zathura.git", branch: "develop"
  version "0.4.8"
  revision 0
  sha256 "7b53921a90ff29319588f604575348ef78fa55816d866bbdf7687a8972536c8f"

  depends_on 'pkg-config'
  depends_on "libmagic"
  depends_on "gettext"
  depends_on "girara"
  depends_on "gnome-icon-theme"
  depends_on "glib"
  depends_on "desktop-file-utils"
  depends_on "intltool"
  depends_on "sphinx-doc"
  depends_on "meson"
  depends_on "synctex" => :optional
  depends_on "gtk-mac-integration"


  def install
    # Set Homebrew prefix
    ENV['PREFIX'] = prefix
    # Add the pkgconfig for girara to the PKG_CONFIG_PATH
    # TODO: Find out why it is not added correctly for Linux
    ENV['PKG_CONFIG_PATH'] = "#{ENV['PKG_CONFIG_PATH']}:#{Formula['girara'].prefix}/lib/x86_64-linux-gnu/pkgconfig"

    inreplace "meson.build" do |s|
      s.gsub! "subdir('doc')", ""
    end

    system 'mkdir build'
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"
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
