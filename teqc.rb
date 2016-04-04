require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2016.04.01"
  sha1 "de15d7f8a29e3d719985f6ea3d5470a091dde086"

  def install
    bin.install "teqc"
  end
  
  test do
    system "#{bin}/teqc", "-version"
  end
end