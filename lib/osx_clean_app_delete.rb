require_relative "osx_clean_app_delete/version"
require_relative "osx_clean_app_delete/osx_clean_app_delete/osx_clean_app_delete_cli"

module OsxCleanAppDelete
  # https://github.com/geemus/formatador
  # http://www.michaelrigart.be/en/blog/a-simple-ruby-command-line-tool.html
  # http://blog.plataformatec.com.br/tag/thor/ make this default and start with argvs?

  begin 
    OsxCleanAppDeleteCli.start(ARGV)
  rescue SystemExit, SignalException, Interrupt
    # puts "\n--- SystemExit ---\n\n"
  end
end
