# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "http://openconnect.github.io/openconnect-gui/"
  stable do
    url "https://github.com/openconnect/openconnect-gui/archive/v1.5.3.tar.gz"
    version "1.5.3"
    #revision 1
    sha256 "bb93486a9911b4834ab93ab4396f4719725d885ca5538cd70c21699cc49c9a8a"
  end

  bottle do
    root_url "https://github.com/openconnect/openconnect-gui/releases/download/v1.5.3"
    sha256 "b4e5c8618cb327cd3ba612a25976d7df7b49f612669f90488d8c680e32f8f61f" => :high_sierra
  end

  head do
    url "https://github.com/openconnect/openconnect-gui.git", :branch => 'develop', :shallow => false
  end

  option "with-ini-settings", "TODO"
  option "with-pkcs11", "TODO"

  depends_on :macos => :mavericks

  depends_on :xcode => :build
  depends_on "cmake" => :build
  depends_on "qt"
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
