class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI, GitHub Copilot CLI or Kiro CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://github.com/GregoryBolshakov/peekme"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.2/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "e7e5422963b5cc5842adf7f20ae4a9008a02594564a1fb6a9e2ecf00a6ba1ab5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.2/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "42ba193c27137fece3d67b4b7fbbc76ed0114a55cc9a60e12613cb83cba77de3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.2/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9358bb2967d1eb07ecb7e10e0598295d2d0bb0f50d8fc1082a23dce6b4727c08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.2/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf7acd8a827af42b18cfa25c525d91b21a0dc5f653c69168131de68ed1bab401"
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
