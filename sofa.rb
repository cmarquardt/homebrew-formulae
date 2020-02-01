class Sofa < Formula
  desc "Standards of Fundamental Astronomy (SOFA) library - C version"
  homepage "http://www.iausofa.org/"
  url "http://www.iausofa.org/2019_0722_C/sofa_c-20190722.tar.gz"
  sha256 "a7063a140fdc78909f4d5ddf6b30143f9f60bfed7d5141047072515f51fa8647"

  option "with-shared", "Build static in addition to shared library."

  def install
    cd "20190722"
    cd "c"
    cd "src"

    args = std_cmake_args

    # Build and install
    system "make", "HOME=#{prefix}", "CCOMPC=#{ENV.cc}"
    system "make", "HOME=#{prefix}", "install"

  end

  def caveats; <<~EOS
    The C version of the Standards of Fundamental Astronomy (SOFA) library is
    installed as 'libsofa_c.a' to avoid name clashes with the Fortran version
    of the same library. It can be linked with

       clang ... -lsofa_c ...

    EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <sofa.h>

      int main() {
        int ihmsf[4];
        char s;

        iauA2tf(4, -3.01234, &s, ihmsf);
        printf("The SOFA (C) installation appears to be fine.");
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lsofa_c", "-o", "test"
    system "./test"
  end
end
