module OsxCleanAppDelete

	# module methods
  def simple_preloader
  	Thread.new {
	  	glyphs = ["|","\\", "–", "/"]
	  	while true
	  		glyphs.each do | g |
	  			print "\rLooking for files... (might take a while) #{g} "
	  			sleep(0.1)
	  		end
	  	end
	  }
	end
	module_function :simple_preloader

	def simple_preloader_stop(preloader)
		Thread.kill(preloader)
		print "\r"
	end
	module_function :simple_preloader_stop

	def is_sudo?
		# puts ENV['USER']
		Process.uid == 0 ? true : false;
	end
	module_function :is_sudo?

end