class Synctex < Formula
  homepage "https://github.com/barracks510/synctexdir"
  url "https://github.com/barracks510/synctexdir/archive/master.zip"
  version "0.0.0"

  def install
    system "gcc -D__SYNCTEX_WORK__ -Wall -I. -lz -shared synctex_parser.c synctex_parser_utils.c -o libsynctex.dylib"
    lib.install "libsynctex.dylib"
    mkdir "#{include}/synctex"
    cp "synctex_parser.h", "#{include}/synctex/"
    cp "synctex_parser_utils.h", "#{include}/synctex/"
    # cp "synctex_version.h", "#{include}/synctex/"
  
    # Install pkgconfig
    inreplace "synctex.pc.in" do |s|
      s.gsub! "@prefix@", prefix
      s.gsub! "@exec_prefix@", prefix
      s.gsub! "@libdir@", lib
      s.gsub! "@includedir@", include
      s.gsub! "@SYNCTEXVERSION@", "0.0.0"
    end

    mkdir "#{lib}/pkgconfig"
    cp "synctex.pc.in", "#{lib}/pkgconfig/synctex.pc"

  end
end
