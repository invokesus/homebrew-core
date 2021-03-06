class Par2 < Formula
  desc "Parchive: Parity Archive Volume Set for data recovery"
  homepage "https://parchive.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/parchive/par2cmdline/0.4/par2cmdline-0.4.tar.gz"
  sha256 "9e32b7dbcf7bca8249f98824757d4868714156fe2276516504cd26f736e9f677"

  bottle do
    cellar :any_skip_relocation
    sha256 "bf25adffe0240c407aa4cb09dbd00d710687087b9aa62a07ddbeab9f7be3bf2b" => :sierra
    sha256 "0ad074a40f27a29d3cde489eab4f9e74c1f5bf6fa9be3ca116d4d9e123d290d2" => :el_capitan
    sha256 "562c1b75782b0ce231416d4d27c7d9a8bc12b467f307db84102267bdfd355ef3" => :yosemite
    sha256 "9423c0e84f2dbed9f4ab1df4b94551f350c6fdd98c53d13bacb799a77b2a04a5" => :mavericks
    sha256 "367db0a915a8bdaa9de30be2abc6de9e641d8031864df71998efa7d1be7ef53f" => :mountain_lion
  end

  # Clang doesn't like variable length arrays of non-POD types.
  patch :DATA

  # Fixes compilation with GCC 4 and still required for clang
  patch do
    url "https://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/app-arch/par2cmdline/files/par2cmdline-0.4-gcc4.patch?revision=1.1"
    sha256 "eda0a381f944b1bc9d3d78bf4526f77620bcb01de48abcb08878178e47c833f7"
  end

  # http://parchive.cvs.sourceforge.net/viewvc/parchive/par2-cmdline/par2creatorsourcefile.cpp?r1=1.4&r2=1.5
  patch :p0 do
    url "https://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/app-arch/par2cmdline/files/par2cmdline-0.4-offset.patch?revision=1.2"
    sha256 "c4820b11376c9932ece944752ddd388fb50fcbcd47aaadda073997142952d969"
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

__END__
diff --git a/par2fileformat.h b/par2fileformat.h
index 9920b24..248cfaf 100644
--- a/par2fileformat.h
+++ b/par2fileformat.h
@@ -84,7 +84,7 @@ struct FILEVERIFICATIONPACKET
   PACKET_HEADER         header;
   // Body
   MD5Hash               fileid;     // MD5hash of file_hash_16k, file_length, file_name
-  FILEVERIFICATIONENTRY entries[];
+  FILEVERIFICATIONENTRY entries[0];
 } PACKED;

 // The file description packet is used to record the name of the file,
