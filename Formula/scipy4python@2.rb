class Scipy4pythonAT2 < Formula
  desc "Software for mathematics, science, and engineering"
  homepage "https://www.scipy.org"
  url "https://files.pythonhosted.org/packages/62/4f/7e95c5000c411164d5ca6f55ac54cda5d200a3b6719dafd215ee0bd61578/scipy-1.2.3.tar.gz"
  sha256 "ecbe6413ca90b8e19f8475bfa303ac001e81b04ec600d17fa7f816271f7cca57"
  head "https://github.com/scipy/scipy.git"

  depends_on "swig" => :build
  depends_on "gcc" # for gfortran
  depends_on "numpy4python@2"
  depends_on "openblas"
  depends_on "python@2"

  cxxstdlib_check :skip

  def install
    openblas = Formula["openblas"].opt_prefix
    ENV["ATLAS"] = "None" # avoid linking against Accelerate.framework
    ENV["BLAS"] = ENV["LAPACK"] = "#{openblas}/lib/libopenblas.dylib"

    config = <<~EOS
      [DEFAULT]
      library_dirs = #{HOMEBREW_PREFIX}/lib
      include_dirs = #{HOMEBREW_PREFIX}/include
      [openblas]
      libraries = openblas
      library_dirs = #{openblas}/lib
      include_dirs = #{openblas}/include
    EOS

    Pathname("site.cfg").write config

    ["python2"].each do |python|
      version = Language::Python.major_minor_version python
      ENV["PYTHONPATH"] = Formula["numpy"].opt_lib/"python#{version}/site-packages"
      ENV.prepend_create_path "PYTHONPATH", lib/"python#{version}/site-packages"
      system python, "setup.py", "build", "--fcompiler=gnu95"
      system python, *Language::Python.setup_install_args(prefix)
    end
  end

  # cleanup leftover .pyc files from previous installs which can cause problems
  # see https://github.com/Homebrew/homebrew-python/issues/185#issuecomment-67534979
  def post_install
    rm_f Dir["#{HOMEBREW_PREFIX}/lib/python*.*/site-packages/scipy/**/*.pyc"]
  end

  def caveats
    homebrew_site_packages = Language::Python.homebrew_site_packages
    user_site_packages = Language::Python.user_site_packages "python"
    <<~EOS
    This formula provides the latest version of scipy (v1.2.3) still supporting
    Python@2, and only installs it into the Python 2.7 site-library.
    EOS
  end

  test do
    ["python2"].each do |python|
      system python, "-c", "import scipy"
    end
  end
end
