require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "http://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2015.11.06"
  sha1 "647ea11eb30ead524fd6b6f0c04e153f28dd9d5c"

  def install
    bin.install "teqc"
  end
  
  test do
    system "#{bin}/teqc", "-version"
  end
end