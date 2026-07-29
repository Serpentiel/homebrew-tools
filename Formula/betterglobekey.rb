class Betterglobekey < Formula
  desc "Reworked Globe key for faster input source switching"
  homepage "https://github.com/Serpentiel/betterglobekey"
  url "https://github.com/Serpentiel/betterglobekey/archive/refs/tags/v4.0.1.tar.gz"
  sha256 "7afa2128bbd2fb2a7c33f4a9b6c2ddfe26a370017d9eb8a0dee904c49f7e915d"
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
    # `list` drives the live Text Input Sources API through the binary; every
    # macOS session exposes at least one Apple keyboard layout.
    list = shell_output("#{bin}/betterglobekey list")
    assert_match(/^com\.apple\.keylayout\./, list)

    # `current` must report a source the same API just enumerated.
    current_id = shell_output("#{bin}/betterglobekey current").split("\t").first.strip
    assert_match current_id, list

    # `doctor` validates a config we hand it (HOME is the test sandbox),
    # cross-checks it against the system's sources, and reports the control
    # socket probe failing as expected with no service running.
    (testpath/".betterglobekey.yaml").write <<~EOS
      version: 2
      logger:
        path: #{testpath}/betterglobekey.log
      collections:
        - name: primary
          sources:
            - #{current_id}
    EOS
    doctor = shell_output("#{bin}/betterglobekey doctor")
    assert_match "config:        valid (1 collection(s))", doctor
    assert_match "accessibility: unknown (service not running", doctor
    assert_match "current source: #{current_id}", doctor
  end
end
