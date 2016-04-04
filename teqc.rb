require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2016.04.01"
  sha256 "14e57cf16c91d6d8c920f25dcab39d3c29ef623aeb38857697ae20801ae33828"

  def install
    bin.install "teqc"
  end
  
  test do
    system "#{bin}/teqc", "-version"
  end
end