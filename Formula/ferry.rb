class Ferry < Formula
  desc "Parallel AI agents, one warm build: forkable, isolated Cargo target dirs per git worktree"
  homepage "https://patwrall.github.io/ferry"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.0/ferry-rs-aarch64-apple-darwin.tar.xz"
      sha256 "feaeed5c78885980d9504485133d3394e51f20b9d7943ff32859b58105661a0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.0/ferry-rs-x86_64-apple-darwin.tar.xz"
      sha256 "f1288ceb6f858a44b8cc0872318d9de032c721e7b7ac0420c2358a6490f6fc00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.0/ferry-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2518faa19272f1bec90cdf041dfc74c8cd1e181f1f8d34d28864ac19e6d958f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/patwrall/ferry/releases/download/v0.1.0/ferry-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f8acb25c9973c3634b2f344ecb465f2cdcdb47309798d868a5168fdab230c7e3"
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
