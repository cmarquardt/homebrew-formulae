require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook

class RPackages < Formula
  homepage ""
  url "https://raw2.github.com/cmarquardt/homebrew-formulae/master/scripts/r-packages-0.1.r"
  sha1 "886f1ccc216a42b8e2786a6f87c490337e1031b8"

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
