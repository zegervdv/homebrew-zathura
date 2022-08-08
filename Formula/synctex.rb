class Synctex < Formula
  desc "Parser libary for synctex"
  homepage "https://github.com/jlaurens/synctex"
  url "https://github.com/jlaurens/synctex", using: :git, revision: "a256d4835b7df2a0472cfa3d557af73a1b83f076", branch: "2020"
  version "1.22.0"
  revision 2

  bottle do
    root_url "https://github.com/zegervdv/homebrew-zathura/releases/download/synctex-1.22.0_2"
    sha256 cellar: :any,                 big_sur:      "28ecec53683b7cc5bb5686705f8ab9f07517fa790527625c792094a51d4e0b25"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aaa344cbb93e7794e72da4f97c492a7a89dadc533dbd9639672512aa5d94c9a4"
  end

  depends_on "zlib"

  def install
    flags = ["-Wall", "-I.", "-lz", "-shared"]
    flags += ["-fPIC"] if OS.linux?
    system ENV.cc.to_s, *flags, "synctex_parser.c", "synctex_parser_utils.c", "-o", "libsynctex.dylib"

    lib.install "libsynctex.dylib"
    mkdir "#{include}/synctex"
    cp "synctex_parser.h", "#{include}/synctex/"
    cp "synctex_parser_utils.h", "#{include}/synctex/"
    cp "synctex_version.h", "#{include}/synctex/"

    open("synctex.pc.in", "w") do |file|
      file.puts "prefix=#{prefix}
exec_prefix=#{prefix}
libdir=#{lib}
includedir=#{include}

Name: synctex
Description: SyncTeX parser library
Version: 1.21.0
Requires.private: zlib
Libs: -L${libdir} -lsynctex
Cflags: -I${includedir}/synctex"
    end

    mkdir "#{lib}/pkgconfig"
    cp "synctex.pc.in", "#{lib}/pkgconfig/synctex.pc"
  end
end
