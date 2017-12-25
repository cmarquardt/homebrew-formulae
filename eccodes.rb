# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Eccodes < Formula
  desc "APIs and tools to handle WMO GRIB (editions 1 and 2) and BUFR (editions 3 and 4) data"
  homepage "https://software.ecmwf.int/wiki/display/ECC"
  url "https://software.ecmwf.int/wiki/download/attachments/45757960/eccodes-2.5.0-Source.tar.gz"
  sha256 "18ab44bc444168fd324d07f7dea94f89e056f5c5cd973e818c8783f952702e4e"

  conflicts_with "grib-api", :because => "ecCodes replaces grip-api; they cannot be installed in parallel"

  option "with-static", "Build static in addition to shared library."

  depends_on "cmake" => :build
  depends_on "jasper" => :recommended
  depends_on "libpng" => :recommended
  depends_on "python" => :recommended
  depends_on "numpy"  => :recommended
  depends_on "netcdf" => :recommended
  depends_on :fortran

  def install
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
    system "#{bin}/grib_ls", "-V"
    system "#{bin}/bufr_ls", "-V"
    system "#{bin}/gts_ls", "-V"
    system "#{bin}/metar_ls", "-V"
  end
end
