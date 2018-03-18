require "formula"

# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md

class RPackages < Formula
  url "https://github.com/cmarquardt/R-packages.git"
  version "v2.0"
  homepage ""

  depends_on "r"
  depends_on "jpeg"    => :build
  depends_on "gdal2"   => :build
  depends_on "nlopt"   => :build
  depends_on "proj"    => :build
  depends_on "udunits" => :build

  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<-EOS
    Standard R packages can be installed in this homebrew installation with

       R-packages-install

    and later updated with

       R-packages-update

    The ROracle package requires a working Oracle Instant Client installation
    with ORACLE_HOME pointing to its root directory. It's installed with

       R-oracle-install

    EOS
  end

end
