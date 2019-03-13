class Maze < Formula
  homepage 'https://github.com/itchyny/maze'
  version '0.0.3'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/maze/releases/download/v0.0.3/maze_darwin_amd64.zip'
    sha256 'cc952a9045796acda4234d12e5289bffd77299b151c69af2b5c95660965a328a'
  else
    url 'https://github.com/itchyny/maze/releases/download/v0.0.3/maze_darwin_386.zip'
    sha256 '6977a603659bfd5b1a9dbcc0ce6efb8bf56b46c9fa9d342c8a8763d65ffcd4c3'
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
