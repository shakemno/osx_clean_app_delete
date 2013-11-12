require 'thor'

class Thor
  class << self

    # override to show help if an unknown command is used
    def handle_no_command_error(command, has_namespace = $thor_runner) #:nodoc:
      if has_namespace
        raise UndefinedCommandError, "Could not find command #{command.inspect} in #{namespace.inspect} namespace."
      else
        raise UndefinedCommandError, "Could not find command #{command.inspect}."
      end
    rescue UndefinedCommandError => e
        # do nothing
        puts"!!! #{e.message}"
        self.start(["help"])
        exit
    end
    alias handle_no_task_error handle_no_command_error

    # override to dont show an error if we have a possibility, rather show help
    protected
      def normalize_command_name(meth)
        return default_command.to_s.gsub('-', '_') unless meth

        possibilities = find_command_possibilities(meth)
        if possibilities.size > 1
          raise ArgumentError, "Ambiguous command #{meth} matches [#{possibilities.join(', ')}]"
        elsif possibilities.size < 1
          meth = meth || default_command
        elsif map[meth]
          meth = map[meth]
        else
          meth = possibilities.first
        end

        meth.to_s.gsub('-','_') # treat foo-bar as foo_bar
      rescue ArgumentError => e
        # do nothing
        puts"!!! #{e.message}"
        "help"
      end
      alias normalize_task_name normalize_command_name
  end

end