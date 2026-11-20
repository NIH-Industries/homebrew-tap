class VeryNormal < Formula
  desc "A terminal typing tutor that makes a keyboard layout from your own typing and moves you to it from the layout you type on now, a few keys at a time"
  homepage "https://github.com/NIH-Industries/very-normal"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.6.0/very-normal-aarch64-apple-darwin.tar.xz"
      sha256 "a6c4254cb1868bd482d5f6d3bcb8a80293a35f3b702ec9e6e1a3306ab8a1dbdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.6.0/very-normal-x86_64-apple-darwin.tar.xz"
      sha256 "d15d6c781710da9ebc6094a5de334783e701bd534198a4cecbc9d406e38e1962"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.6.0/very-normal-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb16d43e19eff9415e089f62bace027656c0bae6859ffd3282247d5895f27ab0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/very-normal/releases/download/v0.6.0/very-normal-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "776ed10c0314e4d6be2e9d82c94f0023626e7566f739e95fcedb37113ba1d203"
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
