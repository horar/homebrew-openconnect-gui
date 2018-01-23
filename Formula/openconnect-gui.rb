# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "http://openconnect.github.io/openconnect-gui/"
  url "https://github.com/openconnect/openconnect-gui/archive/v1.5.0.tar.gz"
  version "1.5.0"
  #revision 1
  sha256 "8dfc19333c062fc2551fb539bd364f64b812f00e149dbb4877d20faa7e02970e"

  bottle do
    sha256 "5511bf90172647f7b0eda6587a5b1e43cee22401bed32a40344f9205d32be48e" => :high_sierra
    sha256 "e05a7844a25e252ca9460331cc4522eeda7c213124306324cbbd4fb9e45b10b3" => :sierra
    sha256 "d5d62f862a89868655f9d0ab12a8742e4ec605a96a7c44a7e23cfe2961fb5542" => :el_capitan
  end

  head do
    url "https://github.com/openconnect/openconnect-gui.git", :branch => 'develop', :shallow => false
  end

  option "with-ini-settings", "TODO"
  option "with-pkcs11", "TODO"

  depends_on :macos => :mavericks

  depends_on :xcode => :build
  depends_on "cmake" => :build
  depends_on "qt5"
  #depends_on "openconnect" => ["with-stoken", "with-oath-toolkit"]
  depends_on "openconnect"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel

    args = std_cmake_args #.split
    args << "-D PROJ_INI_SETTINGS=off" if build.without? "with-ini-settings"
    args << "-D PROJ_PKCS11=off" if build.without? "with-pkcs11"
    args << "-D PROJ_GNUTLS_DEBUG=off" if build.without? "with-gnutls-debug"

    mkdir "build" do
      system "cmake", *args, "../"
      system "make", "install" # if this fails, try separate make/make install steps
    end

    #prefix.install "src/MacVim/build/Release/MacVim.app"
    prefix.install "build/bin/OpenConnect-GUI.app"
    #inreplace "src/MacVim/mvim", %r{^# VIM_APP_DIR=\/Applications$},
    #                             "VIM_APP_DIR=#{prefix}"
    #bin.install "src/MacVim/mvim"

    #inreplace "src/CMakeLists.txt", "/Applications", prefix
    #prefix.install "buid/bin/OpenConnect-GUI.app"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test openconnect-gui`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
