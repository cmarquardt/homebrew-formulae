class EccodesCm < Formula
  desc "Decode and encode messages in the GRIB 1/2 and BUFR 3/4 formats, with netcdf, Python 2 interfaces and optional static libraries"
  homepage "https://confluence.ecmwf.int/display/ECC"
  url "https://software.ecmwf.int/wiki/download/attachments/45757960/eccodes-2.16.0-Source.tar.gz"
  sha256 "141406b724d531fde5ca908a00f9382e1426e32b24d3d96dc31cb2392e7ff8a3"

  option "with-static", "Build static in addition to shared library."

  depends_on "cmake"  => :build
  depends_on "gcc"    # for gfortran
  depends_on "jasper" => :recommended
  depends_on "libpng" => :recommended
  depends_on "netcdf" => :recommended

  depends_on "cmarquardt/formulae/python@2"   => :recommended
  depends_on "cmarquardt/formulae/numpy4Python@2" => :recommended

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

  # Patch to turn fprintf() warnings into proper debug messages
  patch :DATA

end

__END__
*** eccodes-2.16.0-Source/src/grib_accessor_class_bufr_data_array.c.orig	2020-02-07 18:52:13.000000000 +0100
--- eccodes-2.16.0-Source/src/grib_accessor_class_bufr_data_array.c	2020-02-07 18:56:41.000000000 +0100
***************
*** 787,794 ****
          } else {
              if (*v > maxAllowed || *v < minAllowed) {
                  if (dont_fail_if_out_of_range) {
!                     fprintf(stderr, "ECCODES WARNING :  encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g)."
!                             " Setting it to missing value\n", bd->shortName, *v, minAllowed, maxAllowed);
                      grib_set_bits_on(buff->data,pos,modifiedWidth);
                  } else {
                      grib_context_log(c, GRIB_LOG_ERROR, "encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g).",
--- 787,794 ----
          } else {
              if (*v > maxAllowed || *v < minAllowed) {
                  if (dont_fail_if_out_of_range) {
!                    grib_context_log(c, GRIB_LOG_DEBUG, "encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g). Setting to missing value.",
!                            bd->shortName, *v, minAllowed, maxAllowed);
                      grib_set_bits_on(buff->data,pos,modifiedWidth);
                  } else {
                      grib_context_log(c, GRIB_LOG_ERROR, "encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g).",
***************
*** 841,849 ****
          while (ii<nvals) {
              /* Turn out-of-range values into 'missing' */
              if (*v!=GRIB_MISSING_DOUBLE && (*v < minAllowed || *v > maxAllowed)) {
!                 fprintf(stderr, "ECCODES WARNING :  encode_double_array: %s. Value at index %ld (%g) out of range (minAllowed=%g, maxAllowed=%g)."
!                         " Setting it to missing value\n",
!                         bd->shortName, (long)ii, *v, minAllowed, maxAllowed);
                  *v = GRIB_MISSING_DOUBLE;
              }
              ii++;
--- 841,848 ----
          while (ii<nvals) {
              /* Turn out-of-range values into 'missing' */
              if (*v!=GRIB_MISSING_DOUBLE && (*v < minAllowed || *v > maxAllowed)) {
!                 grib_context_log(c, GRIB_LOG_DEBUG, "encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g). Setting to missing value.",
!                         bd->shortName, *v, minAllowed, maxAllowed);
                  *v = GRIB_MISSING_DOUBLE;
              }
              ii++;
***************
*** 950,958 ****
      }
      else if (value>maxAllowed || value<minAllowed) {
          if (dont_fail_if_out_of_range) {
!             fprintf(stderr, "ECCODES WARNING :  encode_double_value: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g)."
!                     " Setting it to missing value\n",
!                     bd->shortName, value, minAllowed, maxAllowed);
              value = GRIB_MISSING_DOUBLE;  /* Ignore the bad value and instead use 'missing' */
              grib_set_bits_on(buff->data,pos,modifiedWidth);
          } else {
--- 949,956 ----
      }
      else if (value>maxAllowed || value<minAllowed) {
          if (dont_fail_if_out_of_range) {
!             grib_context_log(c, GRIB_LOG_DEBUG, "encode_double_array: %s. Value (%g) out of range (minAllowed=%g, maxAllowed=%g). Setting to missing value.",
!                     bd->shortName, value, minAllowed, maxAllowed);
              value = GRIB_MISSING_DOUBLE;  /* Ignore the bad value and instead use 'missing' */
              grib_set_bits_on(buff->data,pos,modifiedWidth);
          } else {
