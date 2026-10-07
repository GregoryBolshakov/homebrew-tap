class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI or GitHub Copilot CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://github.com/GregoryBolshakov/peekme"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.1/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "34e088ee695d8d2bd864e17aa82543e237cbae48c92bf315155383b03340e6d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.1/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "ece977ef782599d51cb792bd131b3e7ede207e5345840d74b1e0dc9964b3068b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.1/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "68ee645d69c8f81987db15f3c29462c6b80602cf06ba03fb0a8521145bc145f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.1/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1ef64788d60d4f58bb19e551870e077608bee7283a83d44652461136d6ce67f2"
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
