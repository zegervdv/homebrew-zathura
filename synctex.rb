class Synctex < Formula
  homepage "https://github.com/jlaurens/synctex"
  url "https://github.com/jlaurens/synctex", :using => :git, :revision => "04371f6aff29deeb3bebff063961e2052d0d1b03", :branch => "2017"
  version "1.21.0"

  depends_on 'zlib'

  def install
    system "gcc -Wall -I. -lz -shared synctex_parser.c synctex_parser_utils.c -o libsynctex.dylib"
    lib.install "libsynctex.dylib"
    mkdir "#{include}/synctex"
    cp "synctex_parser.h", "#{include}/synctex/"
    cp "synctex_parser_utils.h", "#{include}/synctex/"

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
