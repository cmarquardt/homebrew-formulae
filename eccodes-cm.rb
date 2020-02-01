class EccodesCm < Formula
  desc "Decode and encode messages in the GRIB 1/2 and BUFR 3/4 formats, with netcdf and static library support"
  homepage "https://confluence.ecmwf.int/display/ECC"
  url "https://software.ecmwf.int/wiki/download/attachments/45757960/eccodes-2.16.0-Source.tar.gz"
  sha256 "141406b724d531fde5ca908a00f9382e1426e32b24d3d96dc31cb2392e7ff8a3"

  option "with-static", "Build static in addition to shared library."

  depends_on "cmake"    => :build
  depends_on "gcc"      # for gfortran
  depends_on "jasper"   => :recommended
  depends_on "libpng"   => :recommended
  depends_on "netcdf"   => :recommended
  depends_on "python@2" => :recommended
  depends_on "numpy"    => :recommended

  def install
    inreplace "CMakeLists.txt", "find_package( OpenJPEG )", ""

    args = std_cmake_args
    args << "-DENABLE_PNG=ON" if build.with? "libpng"
    args << "-DENABLE_PYTHON=OFF" if build.without? "python@2"
    args << "-DENABLE_NETCDF=OFF" if build.without? "netcdf"
    args << "-DBUILD_SHARED_LIBS=BOTH" if build.with? "static"

    # ecCodes requires an out-of-source build...
    mkdir "build"
    cd "build"

    # Build and install
    system "cmake", "..", *args
    system "make", "install"

    # Rewrite @rpath in .../lib/python2.7/site-packages/gribapi/_gribapi_swig.so
    system "install_name_tool", "-change", "@rpath/libeccodes.dylib", \
                                           "#{prefix}/lib/libeccodes.dylib", \
                                           "#{prefix}/lib/python2.7/site-packages/gribapi/_gribapi_swig.so"
  end

  test do
    grib_samples_path = shell_output("#{bin}/codes_info -s").strip
    assert_match "packingType", shell_output("#{bin}/grib_ls #{grib_samples_path}/GRIB1.tmpl")
    assert_match "gridType", shell_output("#{bin}/grib_ls #{grib_samples_path}/GRIB2.tmpl")

    system "#{bin}/grib_ls", "-V"
    system "#{bin}/bufr_ls", "-V"
    system "#{bin}/gts_ls", "-V"
    system "#{bin}/metar_ls", "-V"
  end
end
