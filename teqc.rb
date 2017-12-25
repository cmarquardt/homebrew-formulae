require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2017.09.15"
  sha256 "b03ef660eeca61a48c72e5bcf34535e0fe299ec4d303c2ea77ef473e796d9990"

  def install
    bin.install "teqc"
  end

  test do
    system "#{bin}/teqc", "-version"
  end
end
