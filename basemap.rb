require "formula"

class Basemap < Formula
  homepage "http://matplotlib.org/basemap/"
  url "http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz"
  sha1 "e1d5750aab4b2d2c3191bba078a6ae3e2bafa068"

  depends_on :python
  depends_on 'geos'
  depends_on 'matplotlib'

  def install
    inreplace "setup.py", /GEOS_dir = None/, "GEOS_dir = '#{HOMEBREW_PREFIX}'"
    system "python", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    system "python", "-c", "from mpl_toolkits.basemap import Basemap"
  end

end
