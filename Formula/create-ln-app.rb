class CreateLnApp < Formula
  desc "Make a Lightning app with a local regtest network"
  homepage "https://create-ln-app.dev"
  url "https://registry.npmjs.org/create-ln-app/-/create-ln-app-1.7.0.tgz"
  sha256 "bece376988ca2f7ae309d9b9e37e65a1849cb6449df3e6e5c05d05c1354585b6"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      The regtest network needs Docker with Docker Compose v2.
      On macOS, install Docker Desktop, then start it:
        brew install --cask docker-desktop
      On Linux, install Docker Engine:
        https://docs.docker.com/engine/install/
    EOS
  end

  test do
    # Docker is not necessary to make the project. The doctor fails, but the CLI exits 0.
    system bin/"create-ln-app", "app", "--skip-install"
    assert_path_exists testpath/"app/package.json"
  end
end
