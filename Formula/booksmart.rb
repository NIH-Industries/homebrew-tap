class Booksmart < Formula
  desc "A terminal bookmark launcher: fuzzy-filter TOML bookmarks and open them in the right browser space"
  homepage "https://github.com/markryall/booksmart"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/markryall/booksmart/releases/download/v0.3.0/booksmart-aarch64-apple-darwin.tar.xz"
      sha256 "af53a9d3d9dc50b2d39419a5742d1c00c1511125a423339e900c31fde7b5e71b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/markryall/booksmart/releases/download/v0.3.0/booksmart-x86_64-apple-darwin.tar.xz"
      sha256 "76c39118973619037734998d47c8fec77b6aaed9722f9aa98e582fab04b67a22"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/markryall/booksmart/releases/download/v0.3.0/booksmart-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "38dc3c4dc891f06132e13440c20641e0973e68b477530f9bc56c4d750af51de9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/markryall/booksmart/releases/download/v0.3.0/booksmart-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "23be3992b7068d869449ed34ec87f854cc02bb6e005b1200c144d117a619a57d"
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
      bin.install "booksmart"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "booksmart"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "booksmart"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "booksmart"
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
