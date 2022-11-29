class Censys < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface for the Censys APIs (censys.io)"
  homepage "https://github.com/censys/censys-python"
  url "https://files.pythonhosted.org/packages/73/34/4a770e29e823242e8e9c8d9456193662754b9245d061686b7aea6f9d151f/censys-2.1.9.tar.gz"
  sha256 "caccc151083232c9ea989b705c676a5629743b51e5d8d3998012be08bb921001"
  license "Apache-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "8e4f720ffea10c8b33f5664165e001667c3d5e253a059cced71a7d3aadc13e2e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "61634a1f1bab414835f2370a8326cbffc124e16a3e2293d4304c8ee663c60146"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "895b358c869ac1d649af52642c30c9144226e640e0913e58b9b2d5f0172d423a"
    sha256 cellar: :any_skip_relocation, ventura:        "ba01e8344bcebea36605c7a4969b2bc736cf3ad5f97dd5afed7e5909f76b894b"
    sha256 cellar: :any_skip_relocation, monterey:       "51a1a461f5d4602ae29aaf7081283fb4a4de40090223bd4a69bda05cd9fc9616"
    sha256 cellar: :any_skip_relocation, big_sur:        "25797d090339da2fc9197884d3a46ba678091b11e893bfd478968a325a069ba4"
    sha256 cellar: :any_skip_relocation, catalina:       "f35f564e23dc1bf9133c04ca171b7a178b32d9f5905a99f16f96787c5aab43b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8992257e82ef1a8d535f0e97c7846b3530205bd40c87b3034ead7599c8d113e"
  end

  depends_on "pygments"
  depends_on "python@3.11"

  resource "backoff" do
    url "https://files.pythonhosted.org/packages/47/d7/5bbeb12c44d7c4f2fb5b56abce497eb5ed9f34d85701de869acedd602619/backoff-2.2.1.tar.gz"
    sha256 "03f829f5bb1923180821643f8753b0502c3b682293992485b0eef2807afa5cba"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/cb/a4/7de7cd59e429bd0ee6521ba58a75adaec136d32f91a761b28a11d8088d44/certifi-2022.9.24.tar.gz"
    sha256 "0d9c601124e5a6ba9712dbc60d9c53c21e34f5f641fe83002317394311bdce14"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "commonmark" do
    url "https://files.pythonhosted.org/packages/60/48/a60f593447e8f0894ebb7f6e6c1f25dafc5e89c5879fdc9360ae93ff83f0/commonmark-0.9.1.tar.gz"
    sha256 "452f9dc859be7f06631ddcb328b6919c67984aca654e5fefb3914d54691aed60"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/11/23/814edf09ec6470d52022b9e95c23c1bef77f0bc451761e1504ebd09606d3/rich-12.6.0.tar.gz"
    sha256 "ba3a3775974105c221d31141f2c116f4fd65c5ceb0698657a11e9f295ec93fd0"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "usage: censys", shell_output("#{bin}/censys --help")
    assert_equal "Censys Python Version: #{version}", shell_output("#{bin}/censys --version").strip
    assert_match "Successfully configured credentials", pipe_output("#{bin}/censys asm config", "test\nn\n", 0)
  end
end
