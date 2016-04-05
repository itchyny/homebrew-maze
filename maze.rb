class Maze < Formula
  homepage 'https://github.com/itchyny/maze'
  version '0.0.0'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/maze/releases/download/v0.0.0/maze_darwin_amd64.zip'
    sha256 '857c560b24380060f2674472c6d9a47d8fc75c59cf334c440a7797e1c69ef88c'
  else
    url 'https://github.com/itchyny/maze/releases/download/v0.0.0/maze_darwin_386.zip'
    sha256 'efb43eda13e8bf8aa86bed53d99fddc414947999ba65e27bc4da8dfe7d2eabe0'
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
