class Peekme < Formula
  desc "Select text in Codex CLI or Claude Code output and get a short explanation right under it, inside the terminal"
  homepage "https://github.com/GregoryBolshakov/peekme"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.2.1/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "37d8b48a1462de8e77f21ae2af17265090e4e60054f3604b4e917414de29ca66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.2.1/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "60140cbd41ef6a362c57c9c27537172a893eff9a3e152700a1df0228bf4845c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.2.1/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "db8d5982dd161e5d7eb014b352133780a2ace9150906d1df78ebe1bb56bc1d0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.2.1/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "07eb3aa9bd950642d7757f5d5071ef55ec664bca3472b263e23139674806460a"
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
