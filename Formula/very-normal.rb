class VeryNormal < Formula
  desc "A terminal typing tutor that makes a keyboard layout from your own typing and moves you to it from the layout you type on now, a few keys at a time"
  homepage "https://github.com/NIH-Industries/very-normal"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.5.0/very-normal-aarch64-apple-darwin.tar.xz"
      sha256 "007e0f9dd049a21ecefd3d8851d4b9c5a6b68add8c536e863501d858771ff8ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.5.0/very-normal-x86_64-apple-darwin.tar.xz"
      sha256 "be06e86c912ad509d115e114d8cd22dc383e43943424275755c669a3e867ea66"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.5.0/very-normal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d30a9626a1c85c096cb9dab379a15523f77c093e2b82725be2c4fd5eab0a5aaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.5.0/very-normal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bba815d36cc7e12474bb5b1783cc8220d00623fe1f99c8eb78e794bf81060aac"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "very-normal"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "very-normal"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "very-normal"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "very-normal"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
