class Ferry < Formula
  desc "Parallel AI agents, one warm build: forkable, isolated Cargo target dirs per git worktree"
  homepage "https://patwrall.github.io/ferry"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.1/ferry-rs-aarch64-apple-darwin.tar.xz"
      sha256 "daf4139a59c721cc3cdeb658cd3a44405e6d49323ba05e390bcee7cddbad416a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.1/ferry-rs-x86_64-apple-darwin.tar.xz"
      sha256 "ae0807939048a1c6d1aeef3873f0aec10e6d44b7c0f2191019e28d28e05e8fec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.1/ferry-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91a11a62d43a87983d96cbd1d3fc5bd215d21bfea084a70f0068399d93177ae5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.1/ferry-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1008f9a09939c81f69b4b8bf9ea75b5f9b90d2010f2d5e9aaf3182b5d7e4a681"
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
