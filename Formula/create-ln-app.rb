class CreateLnApp < Formula
  desc "Make a Lightning app with a local regtest network"
  homepage "https://create-ln-app.dev"
  url "https://registry.npmjs.org/create-ln-app/-/create-ln-app-1.6.0.tgz"
  sha256 "b910bc2656a7e3a0be00d1957e5a79f602640bbbbcdac1f33ea61e7cf1b460c5"
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
