require "formula"

class Eugene < Formula
  homepage ""
  url "file:///Users/marq/Dropbox/Code/eugene-4.19.tar.gz"
  sha1 "a5331aedb105f556cb70367c267ed5c8e0c40728"

  depends_on :python => :recommended
  depends_on 'jpeg'

  def install
    inreplace "setup.py", /os.path.join\(sys.prefix, 'share', 'eugene'\)/, "os.path.join\('#{HOMEBREW_PREFIX}', 'share', 'eugene'\)"
    
    system "./configure", "--enable-shared",
                          "--enable-libeugene",
                          "--prefix=#{prefix}"
    system "make", "install"
    
    if build.with? 'python'
      system "python", "setup.py", "install", "--prefix=#{prefix}"
    end
  end

  test do
    system "#{bin}/eugene", "--version"
  end

end
