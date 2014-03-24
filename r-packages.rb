require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class RPackages < Formula
  homepage ""
  url "https://raw2.github.com/cmarquardt/homebrew-formulae/master/scripts/r-packages-0.1.r"
  sha1 "2e9356b1f9a47f87150af7f0918ddaee403f7dc6"

  depends_on 'r'

  def install
    system "Rscript", "r-packages-0.1.r"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test r-packages`.
    system "Rscript", "-e", "library(ncdf4)"
  end
end
