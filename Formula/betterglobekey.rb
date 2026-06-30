class Betterglobekey < Formula
  desc "Reworked Globe key for faster input source switching"
  homepage "https://github.com/Serpentiel/betterglobekey"
  url "https://github.com/Serpentiel/betterglobekey/archive/refs/tags/v4.0.0.tar.gz"
  sha256 "af3fc1f9ef7aa63f626aa0a992d6e3f77bee8404c77330949795c5fa8ae4a714"
  license "MIT"
  head "https://github.com/Serpentiel/betterglobekey.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}")
    generate_completions_from_executable(bin/"betterglobekey", "completion")
  end

  service do
    run opt_bin/"betterglobekey"
    keep_alive true
    log_path var/"log/betterglobekey.log"
    error_log_path var/"log/betterglobekey.log"
  end

  test do
    assert_match "Available Commands:", shell_output("#{bin}/betterglobekey --help")
    assert_match "#compdef betterglobekey", shell_output("#{bin}/betterglobekey completion zsh")
  end
end
