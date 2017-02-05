require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2016.11.07"
  sha256 "c09dcf16a77a40026767fc810ccb6bd6a70407af0722bc89686a6fc11fcfab4b"

  def install
    bin.install "teqc"
  end
  
  test do
    system "#{bin}/teqc", "-version"
  end
end