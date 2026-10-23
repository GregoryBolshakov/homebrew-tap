class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI, GitHub Copilot CLI or Kiro CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://peekme.dev"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.6.0/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "400b7be7f8740b2527dc5252763d919a44712a79c1ec12f62a04499ad7580688"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.6.0/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "a126db915cc550233decc3b2f20b8cb4242be93770b033e8431030d7a289dd61"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.6.0/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f895543728ef9406e6fc1dbebed5f28893e1a038d74461be8c1f83671de2fc58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.6.0/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c4bfe7cb26408b67b72e1d79da9fbb1bab338727271287ef68179ff598da3db"
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
