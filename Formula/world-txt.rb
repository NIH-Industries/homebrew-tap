class WorldTxt < Formula
  desc "A cozy multiplayer text world: wander, chat, garden and craft on a shared island. No battles, just bonhomie."
  homepage "https://github.com/NIH-Industries/world.txt"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/world.txt/releases/download/v0.13.0/world-txt-aarch64-apple-darwin.tar.xz"
      sha256 "02a67f7f9931ec96bffea36724c672ea51c10e430bb7d4d3a695cb3765ada30e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/world.txt/releases/download/v0.13.0/world-txt-x86_64-apple-darwin.tar.xz"
      sha256 "cba9f03178e5ef272e5700a60dbde73359bbd93ca0b2c472260047b91441bd92"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/NIH-Industries/world.txt/releases/download/v0.13.0/world-txt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93628fedf3891f0980c13a4313eb19f31442ddb5e91f147620a42fa5737e01a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/NIH-Industries/world.txt/releases/download/v0.13.0/world-txt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "680b15c1944c6a50493f6d416ae131e410f51514ed1b11d5d770a3956b1e2fb9"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {
      "world-txt": [
        "world.txt"
      ]
    },
    "aarch64-unknown-linux-gnu": {
      "world-txt": [
        "world.txt"
      ]
    },
    "x86_64-apple-darwin": {
      "world-txt": [
        "world.txt"
      ]
    },
    "x86_64-unknown-linux-gnu": {
      "world-txt": [
        "world.txt"
      ]
    }
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
      bin.install "world-txt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "world-txt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "world-txt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "world-txt"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  def caveats
    <<~EOS
      For sound in the terminal client (radios, gramophones, jukeboxes, hums
      and the island's own sounds), and to play your own songs from it:
        brew install mpv
      Then type `sound on` in world.txt play.
    EOS
  end

  test do
    assert_match "world.txt #{version}", shell_output("#{bin}/world.txt --version")
  end
end
