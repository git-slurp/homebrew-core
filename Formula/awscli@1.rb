class AwscliAT1 < Formula
  include Language::Python::Virtualenv

  desc "Official Amazon AWS command-line interface"
  homepage "https://aws.amazon.com/cli/"
  # awscli should only be updated every 10 releases on multiples of 10
  url "https://files.pythonhosted.org/packages/74/30/796aceddb015018f32ec164b5fa5d15c04b69d96f3573fd0e8c1241c44ed/awscli-1.27.10.tar.gz"
  sha256 "f652c250c0719d14e09e17b4417e7cba986e2395686ee3ec7e816c1f4633a023"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/aws/aws-cli.git"
    regex(/^v?(1(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c0fcfa38d689a8ee6b8c6a8f7261f83eb74d7509db842852840cc48f6fe4461"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0dda6b001edc6efe6550fc46746a3625fe234ccc214229f22ba3961683eb51d1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "eee64241f51912f37368315b485fafb8a9a3058e451af0bb6dc6d356340c0959"
    sha256 cellar: :any_skip_relocation, ventura:        "110a21b1bd00e05d88e4b6c313bea00c0785a81d49e525e57fa9763c72253d4b"
    sha256 cellar: :any_skip_relocation, monterey:       "301143407960395e8423fb2af3f57cb21d8726692bc244a43363cfe35e1bc429"
    sha256 cellar: :any_skip_relocation, big_sur:        "cd3bc82a2d5e71aa33363c680f31c9930879c4613c4efef1e2b313b9dbbf6c2d"
    sha256 cellar: :any_skip_relocation, catalina:       "cc2e70bb320c7f631330ff1ccdbe93b49f91cedab5aa9b09c830411d669d3655"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db5656236ccf4cce729fc1b67139af846c83b2cc13ade14adb4cb49100cb2444"
  end

  keg_only :versioned_formula

  depends_on "docutils"
  depends_on "python@3.11"
  depends_on "pyyaml"
  depends_on "six"

  # Remove this dependency when the version is at or above 1.27.6
  # and replace with `uses_from_macos "mandoc"`
  on_system :linux, macos: :ventura_or_newer do
    depends_on "groff"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/b7/b3/e65206ed1f7e4a9a877cca45128d9dee751f3bd340efd879bca23d0f0810/botocore-1.29.10.tar.gz"
    sha256 "68af34e51597389e7de5ec239ce582853b65d4288308d19f40a30eb3e241fb0d"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/00/2a/e867e8531cf3e36b41201936b7fa7ba7b5702dbef42922193f05c8976cd6/jmespath-1.0.1.tar.gz"
    sha256 "90261b206d6defd58fdd5e85f478bf633a2901798906be2ad389150c5c60edbe"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/a4/db/fffec68299e6d7bad3d504147f9094830b704527a7fc098b721d38cc7fa7/pyasn1-0.4.8.tar.gz"
    sha256 "aef77c9fb94a3ac588e87841208bdec464471d9871bd5050a287cc9a475cd0ba"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "rsa" do
    url "https://files.pythonhosted.org/packages/db/b5/475c45a58650b0580421746504b680cd2db4e81bc941e94ca53785250269/rsa-4.7.2.tar.gz"
    sha256 "9d689e6ca1b3038bc82bf8d23e944b6b6037bc02301a574935b2dd946e0353b9"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/e1/eb/e57c93d5cd5edf8c1d124c831ef916601540db70acd96fa21fe60cef1365/s3transfer-0.6.0.tar.gz"
    sha256 "2ed07d3866f523cc561bf4a00fc5535827981b117dd7876f036b0c1aca42c947"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  def install
    virtualenv_install_with_resources
    pkgshare.install "awscli/examples"

    rm Dir["#{bin}/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh}"]
    bash_completion.install "bin/aws_bash_completer"
    zsh_completion.install "bin/aws_zsh_completer.sh"
    (zsh_completion/"_aws").write <<~EOS
      #compdef aws
      _aws () {
        local e
        e=$(dirname ${funcsourcetrace[1]%:*})/aws_zsh_completer.sh
        if [[ -f $e ]]; then source $e; fi
      }
    EOS
  end

  def caveats
    <<~EOS
      The "examples" directory has been installed to:
        #{HOMEBREW_PREFIX}/share/awscli/examples
    EOS
  end

  test do
    assert_match "topics", shell_output("#{bin}/aws help")
  end
end
