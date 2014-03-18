require 'erb'
require_relative 'template_processor'

module Compiler
  class MustacheProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{{{ afterHeader }}}",
      body_classes: "{{{ bodyClasses }}}",
      body_end: "{{{ bodyEnd }}}",
      before_content: "{{{ beforeContent }}}",
      content: "{{{ content }}}",
      cookie_message: "{{{ cookieMessage }}}",
      footer_support_links: "{{{ footerSupportLinks }}}",
      footer_top: "{{{ footerTop }}}",
      head: "{{{ head }}}",
      header_class: "{{{ headerClass }}}",
      inside_header: "{{{ insideHeader }}}",
      page_title: "{{ pageTitle }}",
      top_of_page: "{{{ topOfPage }}}",
      stylesheets: "{{{ stylesheets }}}",
      javascripts: "{{{ javascripts }}}"
    }

    def handle_yield(section)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      query_string = MojTemplate::VERSION
      return "#{file}?#{query_string}" if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{{ assetPath }}}stylesheets/#{file}?#{query_string}"
      when '.js'
        "{{{ assetPath }}}javascripts/#{file}?#{query_string}"
      else
        "{{{ assetPath }}}images/#{file}?#{query_string}"
      end
    end

    def config_item(key)
      "{{{ #{key.to_s.downcase} }}}"
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
