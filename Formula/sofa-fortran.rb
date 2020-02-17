class SofaFortran < Formula
  desc "Standards of Fundamental Astronomy (SOFA) library - Fortran version"
  homepage "http://www.iausofa.org/"
  url "http://www.iausofa.org/2019_0722_F/sofa_f-20190722.tar.gz"
  sha256 "56c2b50ddb57fa342456caa1bc047311e8a650df41b48907b2e6b4ac3955ed3d"

  option "with-shared", "Build static in addition to shared library."

  depends_on "gcc"      # for gfortran

  def install
    cd "20190722"
    cd "f77"
    cd "src"

    args = std_cmake_args

    # Build and install
    system "make", "HOME=#{prefix}"
    system "make", "HOME=#{prefix}", "install"

  end

  def caveats; <<~EOS
    The Fortran version of the Standards of Fundamental Astronomy (SOFA) library
    is installed as 'libsofa.a'. It can be linked with

       gfortran ... -L#{lib} -lsofa ...

    EOS
  end

  test do
    (testpath/"test.f90").write <<~EOS
      program test

        implicit  none
        integer   ihmsf(4)
        character s

        call iau_a2tf(4, -3.01234D0, s, ihmsf)

        print *, "The SOFA (Fortran) installation appears to be fine."

      end program
    EOS

    system "gfortran", "test.f90", "-L#{lib}", "-lsofa", "-o", "test"
    system "./test"
  end
end
