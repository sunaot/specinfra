require 'spec_helper'
require 'helper/backend/dryrun_ssh'

set :backend, :dryrun_ssh
set :ssh, true # to avoid #create_ssh to create real Net::SSH object.
set :ssh_options, {:user => 'foo'}

describe Specinfra::Backend::Ssh do
  describe '#send_file' do
    let(:src) { '/path/to/srcfile' }
    let(:dest) { '/path/to/destfile' }
    let(:scp_spy) { 
      spy('scp', :upload! => nil)
    }

    before do
      set :scp, scp_spy
      Specinfra.backend.clear_ssh_last_exec_command
    end

    it 'should send file to the remote host' do
      Specinfra.backend.send_file(src, dest)
      expect(scp_spy).to have_received(:upload!).with('/path/to/srcfile', '/tmp/destfile', {})
      expect(Specinfra.backend.ssh_last_exec_command).to match(/mv/)
    end
  end

  describe '#send_directory' do
    let(:src) { '/path/to/srcdir' }
    let(:dest) { '/path/to/destdir' }
    let(:scp_spy) { 
      spy('scp', :upload! => nil)
    }

    before do
      set :scp, scp_spy
      Specinfra.backend.clear_ssh_last_exec_command
    end

    it 'should send directory to the remote host' do
      Specinfra.backend.send_directory(src, dest)
      expect(scp_spy).to have_received(:upload!).with('/path/to/srcdir', '/tmp/destdir', {:recursive => true})
      expect(Specinfra.backend.ssh_last_exec_command).to match(/mv/)
    end
  end
end
