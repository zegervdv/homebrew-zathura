

class ZathuraCb < Formula
  homepage "https://pwmt.org/projects/zathura-cb/"
  url "https://pwmt.org/projects/zathura-cb/download/zathura-cb-0.1.8.tar.xz"
  version "0.1.8"
  sha256 "452a0702e257dbed6a84b7faf6b51e4eb57a163654bbcddf6301143d3770ccc4"

  depends_on 'zathura'
  depends_on 'libarchive'
  depends_on 'pkg-config'

  def install
    inreplace "meson.build", "zathura.get_pkgconfig_variable('plugindir')", "'#{prefix}'"
    system "mkdir build"
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura-pdf-mudpf`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
