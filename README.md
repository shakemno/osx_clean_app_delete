# OsxCleanAppDelete

###TODO: Write a gem description

[http://www.cultofmac.com/90060/how-to-completely-uninstall-software-under-mac-os-x-macrx/](http://www.cultofmac.com/90060/how-to-completely-uninstall-software-under-mac-os-x-macrx/)

[http://lifehacker.com/5828738/the-best-app-uninstaller-for-mac](http://lifehacker.com/5828738/the-best-app-uninstaller-for-mac)

try this, maybe faster...

```
require 'find'

total_size = 0

Find.find(ENV["HOME"]) do |path|
  if FileTest.directory?(path)
    if File.basename(path)[0] == ?.
      Find.prune       # Don't look any further into this directory.
    else
      next
    end
  else
    total_size += FileTest.size(path) if File.file?(path)
  end
end

puts total_size;
```

Gem finds osx app bundle releated files and opts to delete them

## Installation

Add this line to your application's Gemfile:

    gem 'osx_clean_app_delete'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osx_clean_app_delete

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
