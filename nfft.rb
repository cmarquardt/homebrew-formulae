require 'formula'

# must compile with gcc, so 'brew install --use-llvm nfft'
# this installs headers and shared+static libnfft3 libs

class Nfft < Formula
  homepage 'http://www-user.tu-chemnitz.de/~potts/nfft'
  url 'http://www-user.tu-chemnitz.de/~potts/nfft/download/nfft-3.2.3.tar.gz'
  sha1 '9338cb0afbd5f4ddaf2bc5f9be5329ad61dc2ded'

  depends_on 'fftw'

  def install
    system "./configure", "--enable-all", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install" # compiles with gcc (the build can parallelize)
  end

end