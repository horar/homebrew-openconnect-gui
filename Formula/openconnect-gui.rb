class OpenconnectGui < Formula
  desc "Graphical OpenConnect VPN client"
  homepage "https://openconnect.github.io/openconnect-gui/"
  stable do
    url "https://github.com/openconnect/openconnect-gui/archive/v1.5.3.tar.gz"
    # version "1.5.3"
    # revision 1
    sha256 "bb93486a9911b4834ab93ab4396f4719725d885ca5538cd70c21699cc49c9a8a"
  end

  bottle do
    root_url "https://github.com/openconnect/openconnect-gui/releases/download/v1.5.3"
    sha256 "b4e5c8618cb327cd3ba612a25976d7df7b49f612669f90488d8c680e32f8f61f" => :high_sierra
  end

  head do
    url "https://github.com/openconnect/openconnect-gui.git", :branch => "develop", :shallow => false
  end

  option "with-ini-settings", "Store the settings in INI files"

  depends_on :macos => :el_capitan

  depends_on :xcode => :build
  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "openconnect"

  def install
    ENV.deparallelize

    args = std_cmake_args # .split
    args << "-D PROJ_INI_SETTINGS=on" if build.with? "ini-settings"

    mkdir "build" do
      system "cmake", *args, "../"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
