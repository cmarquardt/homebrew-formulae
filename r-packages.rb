require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class RPackages < Formula
  url "https://github.com/cmarquardt/R-packages.git"
  version "1.1"
  homepage ""

  depends_on 'r'
  depends_on 'jpeg' => :build

  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install-packages"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    R packages installed in this homebrew installation can be updated by running

       R-packages-update
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test r-packages`.
    system "Rscript", "-e", "library(ncdf4)"
  end
end
