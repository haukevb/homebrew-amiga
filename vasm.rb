require 'formula'

class Vasm < Formula
  homepage 'http://sun.hasenbraten.de/vasm/'
  url 'http://todi.se/brew/vasm/1.7d/vasm.tar.gz'
  version '1.7d'
  sha256 'ff2fe8ce717c6f5565a7cc88e7f75bd7da6292f6c48f07389c4d7b44dbcaccc3'

  def install
    system "mkdir -p obj"

    inreplace 'Makefile' do |s|
      s.change_make_var! 'COPTS', "-c #{ENV.cflags}"
      s.change_make_var! 'LDFLAGS', "-lm #{ENV.ldflags}"
    end


    syntaxes = ['mot', 'oldstyle', 'std']
    cpus = ['6502', 'arm', 'c16x', 'm68k', 'ppc', 'x86', 'z80']

    syntaxes.each do |syntax|
      cpus.each do |cpu|

       if (!(cpu == 'c16x' && syntax == 'oldstyle') && !(cpu == 'm68k' && syntax == 'oldstyle'))
          system "make CPU=#{cpu} SYNTAX=#{syntax} vasm#{cpu}_#{syntax}"
          bin.install "vasm#{cpu}_#{syntax}"
        end
      end
    end


    system 'make vobjdump'
    bin.install 'vobjdump'

  end

end
