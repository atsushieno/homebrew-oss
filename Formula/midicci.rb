class Midicci < Formula
  desc "midicci MIDI-CI tools and libraries"
  homepage "https://github.com/atsushieno/midicci"
  url "https://github.com/atsushieno/midicci.git",
      revision: "0.1.1"
  version "0.1.1"
  license "MIT"
  head "https://github.com/atsushieno/midicci.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "sdl3"

  def install
    ENV.append_path "CMAKE_PREFIX_PATH", Formula["qt@5"].opt_prefix

    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja",
                    "-DCMAKE_BUILD_TYPE=Release",
                    "-DCMAKE_INSTALL_PREFIX=#{prefix}",
                    "-DMIDICCI_VERSION=#{version}"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "#{bin}/remidy-scan", "--help"
  end
end
