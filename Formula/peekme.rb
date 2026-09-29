class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI or GitHub Copilot CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://github.com/GregoryBolshakov/peekme"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.3/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "c9abbe48fa9d81774719fd114fa58f7866ce6bdcec9dfc57bf5e37ec3a3740e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.3/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "077ed536ec3fc6373fee55d501d0c8f384da2298ba0148f5842dece01cced7b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.3/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4ddb93c50a284a5ff63bf66ed8dade3da1c8674eb8c22f99eb31e8b39cfa7ebc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.3/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "06688898c368e520ffa3acdaac2da67a39ad174e032a36c44bdb6f4f575d7b62"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "peekme"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "peekme"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "peekme"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "peekme"
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
