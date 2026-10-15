class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI, GitHub Copilot CLI or Kiro CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://peekme.dev"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.5.0/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "a4a48d0f69b985a4ee274bc6bed2368cea69500557376a38a0fb37654719fb11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.5.0/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "9c75843ebe3ad53691ebc13b1f6f08ecfe0ea9e7c248578f5fe7efaece1c2881"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.5.0/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "db86ead9dca4e249cc1bc337a570fb463251bbbad0bbaaef3bbd513c03f29d91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.5.0/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a4e349a6cc3abd967a715313ba765d002d7b35c946e0b65a5632ad279f3d2513"
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
