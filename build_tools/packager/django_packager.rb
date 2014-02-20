require 'open3'
require 'moj_template/version'
require_relative 'tar_packager'
require_relative '../compiler/django_processor'

module Packager
  class DjangoPackager < TarPackager
    def initialize
      super
      @base_name = "django_moj_template-#{MojTemplate::VERSION}"
    end

    def build
      @target_dir = @repo_root.join('pkg', @base_name)
      @target_dir.rmtree if @target_dir.exist?
      @target_dir.mkpath
      Dir.chdir(@target_dir) do |dir|
        generate_setup_py
        prepare_contents
      end
      File.rename @target_dir.join('assets'), @target_dir.join('static')
      File.rename @target_dir.join('views'), @target_dir.join('templates')
      File.rename @target_dir.join('templates', 'layouts'), @target_dir.join('templates', 'moj_template')
    end

    def generate_setup_py
      contents = ERB.new(File.read(File.join(@repo_root, "source/setup.py.erb"))).result(binding)
      File.open(File.join(@target_dir, "setup.py"), "w") do |f|
        f.write contents
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      File.open(target_dir.join(generated_file_name(file)), 'wb') do |f|
        f.write Compiler::DjangoProcessor.new(file).process
      end
    end

    private

    def generated_file_name(file_path)
      if file_path.include? "moj_template"
        "base.html"
      else
        File.basename(file_path, File.extname(file_path))
      end
    end
  end
end
