class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI, Pi, GitHub Copilot CLI or Kiro CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://peekme.dev"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.7.0/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "d51a04081471c0fb1cd47497de8c5a15cbda22fff75e7d5b7da22a016f2e5502"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.7.0/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "2c79e0fe16ca1f991616e08add0abd8d078c7eb90f8a97c43e39e3d10eb41b87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.7.0/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8b8f935fd90cff32dd340303908a59063353eee648b153d6daca66c723fbeb57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.7.0/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60191a0d48d8f3e5393a57817a0274b329d55d031136408e08415d7b9a218ef7"
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
