require "formula"

class Eugene < Formula
  desc "EUMETSAT Polar System (EPS) data format library and python interface"
  homepage "https://gitlab.eumetsat.int/eps-tools/eugene"

  url "https://oauth2:#{ENV['HOMEBREW_EUMETSAT_GITLAB_TOKEN']}@gitlab.eumetsat.int/eps-tools/eugene.git", :tag => "v5.0"

  depends_on "libtool"  => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  #depends_on "python"   => :recommended
  depends_on "python@2" => :recommended
  depends_on "jpeg"

  def install
    inreplace "autogen.sh", /libtoolize/, "glibtoolize"
    inreplace "setup.py", /os.path.join\(sys.prefix, 'share', 'eugene'\)/, "os.path.join\('#{HOMEBREW_PREFIX}', 'share', 'eugene'\)"

    # Note: The autogen.sh script already calls configure
    system "./autogen.sh", "--enable-shared",
                           "--enable-libeugene",
                           "--prefix=#{prefix}"
    system "make", "install"

    #if build.with? 'python'
    #  system "python3", "setup.py", "install", "--prefix=#{prefix}"
    #end

    if build.with? 'python@2'
      system "python2", "setup.py", "install", "--prefix=#{prefix}"
    end
  end

  test do
    system "#{bin}/eugene", "--version"
  end

end
