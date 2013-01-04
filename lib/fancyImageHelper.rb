module FancyImageHelper
  def fancyImage(item)
    fancyString = "<a class=\"fancybox\" href=\"" + @item.identifier + "images/jamoma-frameworks.png\" data-fancybox-group=\"fancybox\" title=\"YAML project format\"> <img alt=\"YAML project format\" class=\"myCell\" src=\"" + @item.identifier + "images/jamoma-frameworks.png\"/></a>"
  end
end