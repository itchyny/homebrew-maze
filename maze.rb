class Maze < Formula
  homepage 'https://github.com/itchyny/maze'
  version '0.0.2'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/maze/releases/download/v0.0.2/maze_darwin_amd64.zip'
    sha256 '2205832985be101669ec6e8a8ac0aea1cdde5908fa7365e5c7f1a070c683b1f9'
  else
    url 'https://github.com/itchyny/maze/releases/download/v0.0.2/maze_darwin_386.zip'
    sha256 '3645d4960f36a446d1c9cc4c4f0599e65487a8f79b0982998752bc20f29363e3'
  end

  head do
    url 'https://github.com/itchyny/maze.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/itchyny'
      ln_s buildpath, buildpath/'.go/src/github.com/itchyny/maze'
      system 'make', 'build'
      bin.install 'build/maze'
    else
      bin.install 'maze'
    end
  end

  test do
    system 'maze', '--version'
  end
end
