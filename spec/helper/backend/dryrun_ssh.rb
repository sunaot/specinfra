module Specinfra
  module Backend
    class DryrunSsh < Ssh
      def clear_ssh_last_exec_command
        @ssh_last_exec_command = nil
      end

      def ssh_last_exec_command
        @ssh_last_exec_command
      end

      private
      def ssh_exec!(command)
        @ssh_last_exec_command = command
        { :stdout => '', :exit_status => 0 }
      end
    end
  end
end
