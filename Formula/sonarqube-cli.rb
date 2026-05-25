class SonarqubeCli < Formula
  desc "Command-line interface for SonarQube with AI agent integration"
  homepage "https://cli.sonarqube.com/"
  version "0.13.0.1692"
  license "LGPL-3.0-or-later"

  on_macos do
    depends_on arch: :arm64

    url "https://binaries.sonarsource.com/Distribution/sonarqube-cli/0.13.0.1692/macos/sonarqube-cli-0.13.0.1692-macos-arm64.exe"
    sha256 "d9f070b34f6d1dfc1040ff569134223c9695fdb8d01bd0d2d305410eb2552b13"
  end

  on_linux do
    on_arm do
      url "https://binaries.sonarsource.com/Distribution/sonarqube-cli/0.13.0.1692/linux/sonarqube-cli-0.13.0.1692-linux-arm64.exe"
      sha256 "b6623fcb5bb644118d1048a215bcc9791097e1cea08f8e2cf71cf989601a1497"
    end

    on_intel do
      url "https://binaries.sonarsource.com/Distribution/sonarqube-cli/0.13.0.1692/linux/sonarqube-cli-0.13.0.1692-linux-x86-64.exe"
      sha256 "9257362d3bec48d612dd039dfcd0b9f644ff66b6c07b71f2ff815c88a60a2fd4"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      odie "sonarqube-cli is not available for macOS Intel because upstream only publishes a macOS arm64 binary"
    end

    bin.install Dir["*.exe"].fetch(0) => "sonar"
    chmod 0755, bin/"sonar"
  end

  test do
    assert_match "0.13.0", shell_output("#{bin}/sonar --version")
  end
end
