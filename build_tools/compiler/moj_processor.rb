require 'erb'
require_relative 'template_processor'

module Compiler
  class MojProcessor < TemplateProcessor

    def handle_yield(section)
      file_path = @source_root + "views/layouts/partials/_#{section}.html.erb"
      s = ""
      if File.exist?(file_path)
        s << File.read(file_path)
      else
        s << "<%= yield :#{section} %>"
      end
    end

    def asset_path(file, options={})
      "<%= asset_path \"#{file}\" %>"
    end

    def content_for?(*args)
      File.exist?(@source_root + "views/layouts/partials/_#{args[0]}.html.erb")
    end
  end
end
