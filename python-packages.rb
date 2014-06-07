require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class PythonPackages < Formula
  url "https://github.com/cmarquardt/Python-packages.git"
  version "0.4"
  homepage ""

  depends_on :python
  depends_on 'netcdf'
  depends_on 'pillow'
  depends_on 'matplotlib'
  depends_on 'basemap'
  
  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install-packages"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    Python packages installed in this homebrew installation can be updated by running

       python-packages-update

    The installed version of numpy should have been patched for the setfield bug
    in recarrays; the patch can be reapplied (e.g., after an update of numpy) with

       numpy-patch

    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test python-packages`.
    system "python", "-c", "'import netCDF4'"
  end
end
