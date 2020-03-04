class Jar2app < Formula
  desc "Convert any Java jar to a Mac OS X App bundle"
  homepage "https://github.com/Jorl17/jar2app"
  url "https://github.com/Jorl17/jar2app/archive/stable-1.0.tar.gz"
  sha256 "20edbf0565df983e0b2865c60e49f9923f216e4629f300562075ff5f28be2529"
  version "1.0"

  def install
    bin.mkpath
    system "./install.sh", "#{prefix}/bin"
  end

  test do
    system "#{bin}/jar2app", "--help"
  end
end
