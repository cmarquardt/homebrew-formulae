class PythonUtils < Formula
  desc "Some Python utilities"
  url "https://github.com/cmarquardt/python-utils.git"
  version "2.0"
  homepage "https://github.com/cmarquardt/python-utils"

  depends_on "python"
  depends_on "python@2"

  env :std

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<~EOS
    This formula installs two scripts supporting Jupyter Notebooks and Lab,
    respectively. Usage:

        notebook start|status|stop
        jupyterlab start|status|stop

    Both run their respective server on port 9999, so they can *not* be running
    simultaneously.
    EOS
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    # Run the test with `brew test python-packages`.
    system "which", "notebook"
    system "which", "jupyterlab"
  end
end
