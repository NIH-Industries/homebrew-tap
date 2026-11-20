class VeryNormal < Formula
  desc "A terminal typing tutor that makes a keyboard layout from your own typing and moves you to it from the layout you type on now, a few keys at a time"
  homepage "https://github.com/NIH-Industries/very-normal"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.7.0/very-normal-aarch64-apple-darwin.tar.xz"
      sha256 "c5b78bd1faade0d1502a35ca88e22877617906a12abe1425a3c066a046a4c299"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.7.0/very-normal-x86_64-apple-darwin.tar.xz"
      sha256 "65083c70994cedaac8999aaa8cab2b505a88912dc649f9b81c30f737a944d17a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.7.0/very-normal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b885afa5ee8c2a67e36075b18755aa5e895fcfd210551ae5e0e7f7639e8bbf78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.7.0/very-normal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "71bd62d0004039538243b5eecf78ebd02f83d436162543041f384014d0551c73"
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
