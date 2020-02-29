require "formula"

class Eugene < Formula
  desc "EUMETSAT EPS data format library and python interface"
  homepage ""
  url "file:///Users/marq/Dropbox/Code/eumetsat/eugene-4.20.tar.gz"
  sha256 "be5d31deb51ab043b370e4ed270ad98f2d3e3027b33698dfccc8eb8750c8c805"

  depends_on "python@2" => :recommended
  depends_on "jpeg"

  def install
    inreplace "setup.py", /os.path.join\(sys.prefix, 'share', 'eugene'\)/, "os.path.join\('#{HOMEBREW_PREFIX}', 'share', 'eugene'\)"

    system "./configure", "--enable-shared",
                          "--enable-libeugene",
                          "--prefix=#{prefix}"
    system "make", "install"

    if build.with? 'python'
      system "python2", "setup.py", "install", "--prefix=#{prefix}"
    end
  end

  test do
    system "#{bin}/eugene", "--version"
  end

end
