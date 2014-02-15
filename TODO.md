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

---

### resources

[http://www.cultofmac.com/90060/how-to-completely-uninstall-software-under-mac-os-x-macrx/](http://www.cultofmac.com/90060/how-to-completely-uninstall-software-under-mac-os-x-macrx/)

[http://lifehacker.com/5828738/the-best-app-uninstaller-for-mac](http://lifehacker.com/5828738/the-best-app-uninstaller-for-mac)