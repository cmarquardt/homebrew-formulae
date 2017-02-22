require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class PythonPackages < Formula
  url "https://github.com/cmarquardt/Python-packages.git"
  version "1.3"
  homepage ""

  depends_on :python
  depends_on 'numpy'
  depends_on 'scipy'
  depends_on 'netcdf'
  depends_on 'pillow'
  depends_on 'matplotlib'
  depends on 'geos'
  depends on 'proj'
  
  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install-packages"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    Python packages installed in this homebrew installation can be updated by running

       python-packages-update

    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test python-packages`.
    system "python", "-c", "'import netCDF4'"
  end
end
