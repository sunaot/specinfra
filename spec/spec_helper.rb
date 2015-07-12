require 'specinfra'
require 'rspec/mocks/standalone'
require 'rspec/its'
require 'specinfra/helper/set'
require 'specinfra/helper/host_inventory'
include Specinfra::Helper::Set

set :backend, :exec

module GetCommand
  def get_command(method, *args)
    Specinfra.command.get(method, *args)
  end
end

include GetCommand
