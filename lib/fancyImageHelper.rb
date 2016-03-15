module FancyImageHelper
  def fancyImage(item, image, thumb="useImage", caption="useImageTitle", context="fancybox", effect="normal")
    
    if (thumb=="useImage")
      thumb = image
    end
    
    if (caption=="useImageTitle")
      caption = image
    end
    
    if (effect=="effect-a")
      effect = "fancybox-effects-a"
    elsif (effect=="effect-b")
      effect = "fancybox-effects-b"
    elsif (effect=="effect-c")
      effect = "fancybox-effects-c"
    elsif (effect=="effect-d")
      effect = "fancybox-effects-d"
    else
      effect = "fancybox"
    end
      
    fancyString = fancyString = "<p class=\"text-center\"><a class=\"" + effect + "\" href=\"" + @item.identifier + image + "\"data-fancybox-group=\"" + context +"\" title=\"" + caption + "\"> <img alt=\"" + caption + "\" class=\"img-rounded\" src=\"" + @item.identifier + thumb + "\"/></a></p>"
  end
end