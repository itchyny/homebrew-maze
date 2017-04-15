class Maze < Formula
  homepage 'https://github.com/itchyny/maze'
  version '0.0.1'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/maze/releases/download/v0.0.1/maze_darwin_amd64.zip'
    sha256 'dc2cf6045a9191edccf6192f6f5af09510feebbbb6625da4f376cb4010c027c9'
  else
    url 'https://github.com/itchyny/maze/releases/download/v0.0.1/maze_darwin_386.zip'
    sha256 '4f1e6d6874fc460023ab638c692e2a0d1f12cdcc73eb9da2bfe2ad7980a1c4c6'
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
