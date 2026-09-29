class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI or GitHub Copilot CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://github.com/GregoryBolshakov/peekme"
  version "0.3.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.4/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "1606a32243dbded36ed9ba2b8d1832d721f8e9b58e059a1cad7ab3e127b6ad33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.4/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "a205d321ad9fe1419ebe566e6616703c9ef3f0c6c5e9c3e2dea30c6d78549e65"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.4/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a48ee5e21e2e3c6ce144f95f844bb3d0de8b79237079f3e9ddf74866e56d1b99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.3.4/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "29a6fe0291be08b0a6e2027de80adcbe163654cd3e79c0a19a0baf9d6bfdbd3c"
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
