require "formula"

class Eugene < Formula
  homepage ""
  url "file:///Users/marq/Dropbox/Code/eumetsat/eugene-4.20.tar.gz"
  sha1 "9137506c24a514eb1a509a01083114fbf19380aa"

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
