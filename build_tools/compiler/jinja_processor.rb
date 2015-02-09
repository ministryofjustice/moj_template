require 'erb'
require_relative 'template_processor'

module Compiler
  class JinjaProcessor < TemplateProcessor

    @@yield_hash = {
      after_header: "{% block after_header %}{% endblock %}",
      body_classes: "{% block body_classes %}{{ product_type }} {{ phase }}{% endblock %}",
      body_end: "{% block body_end %}{% endblock %}",
      before_content: "{% block before_content %}{% endblock %}",
      content: "{% block content %}{% endblock %}",
      footer_support_links: "{% block footer_support_links %}{% endblock %}",
      footer_top: "{% block footer_top %}{% endblock %}",
      head: "{% block head %}{% endblock %}",
      header_class: "{% block header_class %}{% endblock %}",
      inside_header: "{% block inside_header %}{% endblock %}",
      page_title: "{% block page_title %}{% endblock %}",
      top_of_page: "{% block top_of_page %}{% endblock %}",
      stylesheets: "{% block stylesheets %}{% endblock %}",
      javascripts: "{% block javascripts %}{% endblock %}",
      js_gt_ie: "{% block js_gt_ie %}5{% endblock %}"
    }

    def handle_yield(section = :layout)
      @@yield_hash[section]
    end

    def asset_path(file, options={})
      return file if @is_stylesheet
      case File.extname(file)
      when '.css'
        "{{ static('stylesheets/#{file}') }}"
      when '.js'
        "{{ static('javascripts/#{file}') }}"
      else
        "{{ static('images/#{file}') }}"
      end
    end

    def config_item(key)
      "{{ #{key.to_s.downcase} }}"
    end

    def content_for?(*args)
      @@yield_hash.include? args[0]
    end
  end
end
