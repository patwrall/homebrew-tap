class Ferry < Formula
  desc "Parallel AI agents, one warm build: forkable, isolated Cargo target dirs per git worktree"
  homepage "https://patwrall.github.io/ferry"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.2/ferry-rs-aarch64-apple-darwin.tar.xz"
      sha256 "265dfb0b2d79c3344722c3ac7b4181cbb7ec3122137c588ac9fd6a5200ff382f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.2/ferry-rs-x86_64-apple-darwin.tar.xz"
      sha256 "fec365a26f576889605c2a0aa2d4b89a5b0d519f8c6262ab056ae14237e01ce7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.2/ferry-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e17e79c2aad6c6a23942eb28398f72eb6366de04f15556e223b3002022fbf83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.2/ferry-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba9d82599ca40234adc740d8b7f87e1ef4d38aab79e47fdaee1ac3e1b1f94de8"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
      bin.install "ferry"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ferry"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ferry"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ferry"
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
