require 'fileutils'

Jekyll::Hooks.register :site, :post_write do |site|
  site.categories.each_key do |category|
    dir = File.join(site.source, "category")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    slugified_category = category.downcase.gsub(' ', '-')
    path = File.join(dir, "#{slugified_category}.html")
    unless File.exist?(path)
      File.open(path, 'w') do |file|
        file.write("---\nlayout: default\ntitle: #{category}\npermalink: /category-#{slugified_category}/\n---\n")
        file.write("{% for post in site.categories['#{category}'] %}\n")
        file.write("<div class=\"post\">\n")
        file.write("  <h2><a href=\"{{ post.url }}\">{{ post.title }}</a></h2>\n")
        file.write("</div>\n")
        file.write("{% endfor %}\n")
      end
    end
  end
end
