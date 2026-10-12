class Wxpython < Formula
  desc "Python bindings for wxWidgets"
  homepage "https://www.wxpython.org/"
  url "https://files.pythonhosted.org/packages/3d/dd/026f6286f8beefcdd9551ad2e05b4e3edb45e638cdc067db211c53c950ce/wxpython-4.3.1.tar.gz"
  sha256 "4e3a95b63175be8e10f0662de506a36d8cc6cb86ecc5b30ae880c8dafb34a0cd"
  license "LGPL-2.0-or-later" => { with: "WxWindows-exception-3.1" }
  revision 1

  depends_on "doxygen" => :build
  depends_on "python-setuptools" => :build
  depends_on "sip" => :build
  depends_on "numpy"
  depends_on "pillow"
  depends_on "python@3.14"
  depends_on "wxwidgets"

  on_linux do
    depends_on "pkgconf" => :build
    depends_on "gtk+3"
  end

  pypi_packages exclude_packages: %w[numpy pillow]

  # Local override: homebrew-core's cython is built for python@3.15, so its site-packages are
  # invisible to the python@3.14 build and wx/svg/_nanosvg.c is never generated. Use Cython's
  # pure-Python wheel instead. Drop this override once upstream aligns the Python versions.
  resource "cython" do
    url "https://files.pythonhosted.org/packages/bf/77/67b0b24e45073a699610e50f00c18474ff9b09ea29ecc95083bdf5e60acd/cython-3.3.0-py3-none-any.whl"
    sha256 "9b24b5c8cd536946b62086fcafee6d5509d3f549f72d553d2336af87ffbe0da1"
  end

  # Upstream pins Doxygen 1.9.1, which keeps `constexpr` in the XML type; ours is newer
  # and reports it as an attribute, so `constexpr` members get a setter and fail to build.
  patch :DATA

  # Fix Doxygen binding generation, upstream PR ref, https://github.com/wxWidgets/Phoenix/pull/2963
  patch do
    url "https://github.com/wxWidgets/Phoenix/commit/911bd596087a4be61aa1da6654e2e4410f30a461.patch?full_index=1"
    sha256 "90c3c3273efdc7d5f9239e2b3f462ca7e9b564fc62ac0311dfa603f909a1122c"
    type :unofficial
  end

  # Declare the SIP ABI requirement, upstream PR ref, https://github.com/wxWidgets/Phoenix/pull/2964
  patch do
    url "https://github.com/wxWidgets/Phoenix/commit/169e00e00824bb68af6b66b951f7dc082ffe9c7f.patch?full_index=1"
    sha256 "864eebaef96a87cb6ff5cc911a550b08e7795ebfc0d1de763750e6af6338b57e"
    type :unofficial
  end

  def install
    wxwidgets = deps.find { |dep| dep.name.match?(/^wxwidgets(@\d+(\.\d+)*)?$/) }.to_formula
    wx_config = wxwidgets.opt_bin/"wx-config-#{wxwidgets.version.major_minor}"
    ENV["WX_CONFIG"] = wx_config.to_s

    # Homebrew stages wheels without unpacking them, so install it with pip.
    resource("cython").stage do
      system python3, "-m", "pip", "install", "--no-deps", "--no-index",
             "--target=#{buildpath}/cython-site", Pathname.glob("*.whl").first
    end
    ENV.append_path "PYTHONPATH", buildpath/"cython-site"
    ENV.cxx11
    ENV["DOXYGEN"] = formula_opt_bin("doxygen")/"doxygen"
    system python3, "-u", "build.py", "dox", "touch", "etg", "sip", "build_py",
                   "--release",
                   "--use_syswx",
                   "--prefix=#{prefix}",
                   "--jobs=#{ENV.make_jobs}",
                   "--verbose",
                   "--nodoc"
    system python3, "-m", "pip", "install", "--config-settings=--build-option=--skip-build", *std_pip_args, "."
  end

  test do
    output = shell_output("#{python3} -c 'import wx ; print(wx.__version__)'")
    assert_match version.to_s, output
  end
end

__END__
diff --git a/etgtools/extractors.py b/etgtools/extractors.py
index 5c3b1d4..b6e9b2d 100644
--- a/etgtools/extractors.py
+++ b/etgtools/extractors.py
@@ -222,6 +222,8 @@ class VariableDef(BaseDef):
     def extract(self, element):
         super(VariableDef, self).extract(element)
         self.type = flattenNode(element.find('type'))
+        if element.get('constexpr') == 'yes' and not self.type.startswith('const'):
+            self.type = 'const ' + self.type
         self.definition = element.find('definition').text
         self.argsString = element.find('argsstring').text
 
