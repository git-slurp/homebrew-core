class GalleryDl < Formula
  include Language::Python::Virtualenv

  desc "Command-line downloader for image-hosting site galleries and collections"
  homepage "https://github.com/mikf/gallery-dl"
  url "https://files.pythonhosted.org/packages/4e/f8/79493ddad367efcea05c4f87e7c4bcacb6e6f316ecd85ee7f403c0aae25d/gallery_dl-1.24.0.tar.gz"
  sha256 "2c66633e4897db9d88460446d5fc554b821d9ca0374605633a164bc5849c209a"
  license "GPL-2.0-only"
  head "https://github.com/mikf/gallery-dl.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dfa1dd55ec06ca65a769c2cf0db7aa68f7df8b356ff266b92f2b5284cdc6760a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "042bb0ec1fdbf0e2a8d468f2264a253a1750c429beb9467f46cf14ee461c1080"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "01b1cc510d18ebebf730f0ec43f283ffa570194cc38a4c11c75ed7de97ec38cd"
    sha256 cellar: :any_skip_relocation, ventura:        "dfbb93ed5910a87eea39eb539f153e3f603fd8b186e18e4c64e04ceb68f39a5c"
    sha256 cellar: :any_skip_relocation, monterey:       "db9a0868da3b8c382befe660877f379f8ee83428998b8cce7947caaa1b81120b"
    sha256 cellar: :any_skip_relocation, big_sur:        "ec5c2bfc7b151158890da748946c787596d9a55b680869cf0d15f7effa090444"
    sha256 cellar: :any_skip_relocation, catalina:       "6cafab82a2660f6730a972abb6becee92bf0d87d92714ba9f43bb631dc4e33fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0479611a9fc4068ba2cf66761b176d2091a3ab50ca4e5697e24dcf80372525aa"
  end

  depends_on "python@3.11"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/cb/a4/7de7cd59e429bd0ee6521ba58a75adaec136d32f91a761b28a11d8088d44/certifi-2022.9.24.tar.gz"
    sha256 "0d9c601124e5a6ba9712dbc60d9c53c21e34f5f641fe83002317394311bdce14"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/a1/34/44964211e5410b051e4b8d2869c470ae8a68ae274953b1c7de6d98bbcf94/charset-normalizer-2.1.1.tar.gz"
    sha256 "5a3d016c7c547f69d6f81fb0db9449ce888b418b5b9952cc5e6e66843e9dd845"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/a5/61/a867851fd5ab77277495a8709ddda0861b28163c4613b011bc00228cc724/requests-2.28.1.tar.gz"
    sha256 "7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"gallery-dl", "https://imgur.com/a/dyvohpF"
    expected_sum = "126fa3d13c112c9c49d563b00836149bed94117edb54101a1a4d9c60ad0244be"
    file_sum = Digest::SHA256.hexdigest File.read(testpath/"gallery-dl/imgur/dyvohpF/imgur_dyvohpF_001_ZTZ6Xy1.png")
    assert_equal expected_sum, file_sum
  end
end
