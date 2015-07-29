require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2015.06.23"
  sha1 "19f621178adf464689cc4e83ebdb1548c1fde8b5"

  def install
    bin.install "teqc"
  end
  
  test do
    system "#{bin}/teqc", "-version"
  end
end