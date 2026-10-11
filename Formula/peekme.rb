class Peekme < Formula
  desc "Select text in Claude Code, Codex CLI, GitHub Copilot CLI or Kiro CLI output and get a short explanation right under it, inside the terminal"
  homepage "https://peekme.dev"
  version "0.4.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.5/peekme-aarch64-apple-darwin.tar.xz"
      sha256 "e9539c685db963dc25308b128746a8b8ec0efe9dbe0cfac03948c4513de07b7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.5/peekme-x86_64-apple-darwin.tar.xz"
      sha256 "12d30d55fa0fbeace1574e1df9f8642865fecb71d0e2fac2b9f88f65fe2951ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.5/peekme-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6b42d10590740d56105e0096682cb37328c9f085a7c22c6a94aad10cb16ee5b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GregoryBolshakov/peekme/releases/download/v0.4.5/peekme-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3b7c08d28795e3992f375bc71daeaa4bf19064bd675b75f0a0673f02c420a914"
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
