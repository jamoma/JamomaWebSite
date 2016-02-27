# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::LinkTo
include Categories
require 'fileutils'
#require 'redcarpet'

def blog_route(item)
  if not item.identifier.match(/\d{4}-\d{2}-\d{2}-/)
    raise "Ill-formed blog date."
  end
  year, name = item.identifier[0..11], item.identifier[12..-1]
  year.gsub('-', '/') + name.chop + '.html'
end

def item_url(item, site=@site.config[:base_url])
  [site,  blog_route(item)].join
end

def item_title(item)
  item.attributes[:title] || "(No title - man, that's odd)"
end

#############################################################
#
# Workaround preventing lots of hacking in order for 
# route and compile to work properly with fancyBox filenames
#
#############################################################
def copyFancyBox  
  puts "  Copying .htaccess"
  puts " "
  `cp -r "content/.htaccess" "output/.htaccess"`
  puts " "
  
  puts "  Copying fancyBox "
  puts " "
  `cp -r "preParsedContent/fancyBox" "output/fancyBox"`
  puts " "
  
  puts "  Copying module documentation "
  puts " "
  `cp -r "preParsedContent/modules" "output/tutorials/modules"`
end

copyFancyBox
