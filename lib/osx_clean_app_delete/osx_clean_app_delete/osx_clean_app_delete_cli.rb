#! /usr/bin/env ruby

require "benchmark"
require "thor"
require 'shellwords'
require_relative "../helper/thor_overrides"
require_relative "../helper/osx_clean_app_delete_helper"

module OsxCleanAppDelete
  class OsxCleanAppDeleteCli < Thor
    
    # puts "make sure its osx"
    # puts `sw_vers -productVersion`
    # puts RUBY_PLATFORM
    PLATFORM_IS_OSX = (Object::RUBY_PLATFORM =~ /darwin/i) ? true : false
    unless PLATFORM_IS_OSX
      puts "am sorry, osx only..."
      exit
    end

    check_unknown_options!
    stop_on_unknown_option! :help
    default_task :help

    # argument :name   
    class_option :tell, :aliases => "-t", :type => :boolean, :desc => "(giggle) talk to me"
    class_option :delete, :aliases => "-d", :type => :boolean, :desc => "Delete the file after parsing it."
    class_option :force, :aliases => "-f", :type => :boolean, :desc => "Only ask once before deleting all files."
    class_option :verbose, :aliases => "-v", :type => :boolean, :desc => "Display extended information" #, :default => true
    class_option :superverbose, :aliases => "-s", :type => :boolean, :desc => "Display even more extended information"
      
    # method_option :force, :aliases => "-f", :type => :boolean, :desc => "Only ask once before deleting all files."

    desc "get [APP-PATH]", "list files belonging to app"
    def get(appname)
      
      # check if this is a file
      say_executing "Checking if '#{appname.shellescape}' is a valid app bundle"

      if File.directory?(appname) && File.extname(appname).eql?(".app")

        escaped_appname = "#{appname}/Contents/Info".shellescape

        # validate app bundle by getting CFBundleIdentifier
        say_executing "Reading CFBundleIdentifier"
        app_bundle = `defaults read /#{escaped_appname} CFBundleIdentifier`.chomp

        fail unless app_bundle
        
        say_success "CFBundleIdentifier: #{app_bundle}"

        files_to_delete = []
        files_to_delete << appname

        # list of dirs to check
        search_dirs = ["~/Library"]

        # check for sudo
        puts "Execute as sudo to include top level files." unless OsxCleanAppDelete.is_sudo?
        search_dirs.insert(0, "/Library") if OsxCleanAppDelete.is_sudo?

        # build search command
        search_command = ""
        app_basename = File.basename(appname.shellescape, File.extname(appname))
        search_dirs.each do |dir|
          search_command << "find #{dir} -name '#{app_basename}.*' & "
          search_command << "find #{dir} -name '#{app_bundle}.*' & "
          search_command << "find #{dir} -type d -name '#{app_basename}' & "
          search_command << "find #{dir} -type d -name '#{app_bundle}'"
          search_command << " & " unless dir.eql? search_dirs.last
        end
        say_superverbose "#{search_command}"

        preloader = OsxCleanAppDelete.simple_preloader

        time = Benchmark.measure {
          # search for appname & bundle name
          app_locations = `#{search_command}`.split("\n")

          app_locations.each do |loc|
            files_to_delete << loc
          end

        }
        OsxCleanAppDelete.simple_preloader_stop(preloader)
        say_superverbose "Benchmark: #{time}"

        present_files files_to_delete
      else
        fail
      end
    end
    map "-G" => :get
    map "-g" => :get

    no_tasks {
      def present_files(files)
      say "These are the file(s) we found:", :white
        puts " "
        files.each do |file|
        say "  File: #{file}", :white
        end 
        puts " "
        puts "Run again with flag --delete (-d) to erase file(s)" unless options[:delete]
        delete_files files if options[:delete] or ( ask( set_color "Continue to delete? [yes]:", :red, :on_white).eql? "yes")
      end

      def delete_files(files)
        
        delete_all_files = ask( set_color "Delete all file(s) [yes]:", :red, :on_white) if options[:force]

        files.each do |file|
          delete = delete_all_files || ask( set_color "Delete #{file} ? [yes]:", :red, :on_white)
          case delete
          when "yes"
            say_executing "Deleting... '#{file}'"
            tell_delete file
            `rm -r "#{file}"`
          else
            say_executing "Cancelled deleting... '#{file}'"
          end
        end
        say "[Done]", :green if options[:verbose] || options[:superverbose]

      end

      def say_executing(s)
        say "[Executing: #{s}]", :yellow if options[:verbose] || options[:superverbose]
      end

      def say_superverbose(s)
        say "#{s}", :magenta if options[:superverbose]
      end

      def say_success(s)
        say "[Success: #{s}]", :green if options[:verbose] || options[:superverbose]
      end

      def fail
        say "[Aborting: Something went wrong]", :red
        say "Please make sure to pass a valid path and bundle as argument.", :white
        abort
      end

      def tell_delete(file)
        `say i am deleting this #{file} now...` if options[:tell]
      end
    }

  end
end
