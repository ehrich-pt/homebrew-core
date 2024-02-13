require "language/node"

class CubejsCli < Formula
  desc "Cube.js command-line interface"
  homepage "https://cube.dev/"
  url "https://registry.npmjs.org/cubejs-cli/-/cubejs-cli-0.34.52.tgz"
  sha256 "4e1c4cd5ccdab8c0d3b09ced231b4a1f9a668a3d77d3f51b0fa196cf4d537a7c"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any, arm64_sonoma:   "0387e34a12dc0328721ab0aec8074f367f534f85db3a6c9ac421c2f2572746a6"
    sha256 cellar: :any, arm64_ventura:  "0387e34a12dc0328721ab0aec8074f367f534f85db3a6c9ac421c2f2572746a6"
    sha256 cellar: :any, arm64_monterey: "0387e34a12dc0328721ab0aec8074f367f534f85db3a6c9ac421c2f2572746a6"
    sha256 cellar: :any, sonoma:         "7909cbc2d4b92a3ecdecd06db4f935d2054d13ac962bc4ea2b02ade070c6dc29"
    sha256 cellar: :any, ventura:        "7909cbc2d4b92a3ecdecd06db4f935d2054d13ac962bc4ea2b02ade070c6dc29"
    sha256 cellar: :any, monterey:       "7909cbc2d4b92a3ecdecd06db4f935d2054d13ac962bc4ea2b02ade070c6dc29"
  end

  depends_on "node"
  uses_from_macos "zlib"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cubejs --version")
    system bin/"cubejs", "create", "hello-world", "-d", "postgres"
    assert_predicate testpath/"hello-world/model/cubes/orders.yml", :exist?
  end
end
