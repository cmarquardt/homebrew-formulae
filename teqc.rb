require "formula"

class Teqc < Formula
  desc "TEQC - The Toolkit for GPS/GLONASS/Galileo/SBAS/Beidou/QZSS Data"
  homepage "https://www.unavco.org/software/data-processing/teqc/teqc.html"
  url "https://www.unavco.org/software/data-processing/teqc/development/teqc_OSX_i5_gcc4.3d_64.zip"
  version "2017.07.03"
  sha256 "3b20d7a3e8825d92ad719f19664dba9a11b1b6cb2d1340681085ed3e88326ed2"

  def install
    bin.install "teqc"
  end

  test do
    system "#{bin}/teqc", "-version"
  end
end
