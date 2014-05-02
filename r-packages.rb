require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class RPackages < Formula
  url "https://github.com/cmarquardt/R-packages.git"
  version "0.1"
  homepage ""

  depends_on 'r'
  
  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install-packages"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test r-packages`.
    system "Rscript", "-e", "library(ncdf4)"
  end
end
