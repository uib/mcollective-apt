module MCollective
  class Application::Apt < Application
    description "Do apt specific tasks"

    usage <<-END_OF_USAGE
mco apt [OPTIONS] [FILTERS] <ACTION>

The ACTION can be one of the following:

    upgrades        - list number of available package upgrades                 
    installed       - list number of installed packages
    clean           - clean package archive files (i.e. apt-get clean)
    update          - update apt-get's local database (i.e. apt-get update)
    upgrade         - perform system upgrade (i.e. apt-get upgrade)
    distupgrade     - perform system dist-upgrade (i.e. apt-get dist-upgrade)
    END_OF_USAGE

    def post_option_parser(configuration)
      if ARGV.length > 1
        raise "ACTION can only be one specific command."
      elsif ARGV.length < 1
        raise "Please specify an action."
      else
        action = ARGV.shift

        unless action.match(/^(upgrades|installed|clean|update|upgrade|force-upgrade|distupgrade|force-distupgrade|fixbroken)$/)
          raise "Action can be one of the following: upgrades, installed, clean, update, upgrade, force-upgrade, distupgrade, force-distupgrade and fixbroken"
        end
      
        configuration[:action]  = action
      end
    end

    def validate_configuration(configuration)
      if MCollective::Util.empty_filter?(options[:filter])
        print("Do you really want to operate on services unfiltered? (y/n): ")
      
      STDOUT.flush

      exit unless STDIN.gets.strip.match(/^(?:y|yes)$/i)
      end
    end

    def main
      $0 = "mco"

      action = configuration[:action]

      rpc_service = rpcclient("apt", :options => options)

      rpc_service.progress = false

      rpc_service.send(action) do |resp|
      case action
      when "upgrades"
        begin
          printf("%-40s Package upgrades available: %s\n", resp[:senderid], resp[:body][:data][:status])
        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      when "installed"
        begin
          printf("%-40s Total number of packages installed: %s\n", resp[:senderid], resp[:body][:data][:status])
        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      else
        begin
          printf("%-40s Result of execution: %s\n", resp[:senderid], resp[:body][:data][:status])
        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end
      end

      rpc_service.disconnect
      printrpcstats
    end
  end
end
