require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class RPackages < Formula
  homepage ""
  url "https://raw2.github.com/cmarquardt/homebrew-formulae/master/packages/r-packages"
  version "0.1"
  home ""
  sha1 "2e9356b1f9a47f87150af7f0918ddaee403f7dc6"

  depends_on 'r'
  
  env :std

  def install
    system "configure", "--prefix=#{}{prefix}"
    system "make", "install-packages"
    system "make", "intall"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test r-packages`.
    system "Rscript", "-e", "library(ncdf4)"
  end
end
