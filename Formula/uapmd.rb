class Uapmd < Formula
  desc "Ubiquitous Audio Plugin MIDI Device tools and libraries"
  homepage "https://github.com/atsushieno/uapmd"
  url "https://github.com/atsushieno/uapmd.git",
      revision: "175da6e64fc3e0c70568046d8a1b259d521ed259"
  version "0.1.0"
  license "MIT"
  head "https://github.com/atsushieno/uapmd.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "qt@5"
  depends_on "sdl3"

  def install
    ENV.append_path "CMAKE_PREFIX_PATH", Formula["qt@5"].opt_prefix

    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                    "-DUAPMD_VERSION=#{version}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/remidy-scan", "--help"
  end
end
