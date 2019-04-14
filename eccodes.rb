# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Eccodes < Formula
  desc "ADecode and encode messages in the GRIB 1/2 and BUFR 3/4 formats, with python and netcdf support"
  homepage "https://software.ecmwf.int/wiki/display/ECC"
  url "https://software.ecmwf.int/wiki/download/attachments/45757960/eccodes-2.12.0-Source.tar.gz"
  sha256 "f75ae5ce9e543622e8e40c3037619f8d9e6542c902933adb371bac82aee91367"

  conflicts_with "grib-api", :because => "ecCodes replaces grip-api; they cannot be installed in parallel"

  option "with-static", "Build static in addition to shared library."

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "jasper" => :recommended
  depends_on "libpng" => :recommended
  depends_on "python" => :recommended
  depends_on "numpy"  => :recommended
  depends_on "netcdf" => :recommended

  def install
    inreplace "CMakeLists.txt", "find_package( OpenJPEG )", ""

    args = std_cmake_args
    args << "-DENABLE_PNG=ON" if build.with? "libpng"
    args << "-DENABLE_PYTHON=OFF" if build.without? "python"
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
