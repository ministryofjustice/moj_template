require 'open3'
require 'fileutils'
require 'moj_template/version'
require_relative 'tar_packager'
require_relative '../compiler/django_processor'

module Packager
  class DjangoPackager < TarPackager
    def initialize
      super
      @base_name = "moj_template-#{MojTemplate::VERSION}.django"
    end

    def build
      Dir.mktmpdir("moj_template") do |dir|
        @target_dir = Pathname.new(dir).join(@base_name)
        @target_dir.mkpath
        prepare_contents
        parse_folders
        generate_package_files
        create_tarball
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      File.open(target_dir.join(generated_file_name(file)), 'wb') do |f|
        f.write Compiler::DjangoProcessor.new(file).process
      end
    end

    def parse_folders
      package_dir = @target_dir.join('moj_template')
      package_dir.mkpath
      File.rename @target_dir.join('assets'), package_dir.join('static')
      File.rename @target_dir.join('views'), package_dir.join('templates')
      File.rename package_dir.join('templates', 'layouts'), package_dir.join('templates', 'moj_template')
    end

    def generate_package_files
      files = [@repo_root.join("source", "README.txt"), @repo_root.join("source", "MANIFEST.in"), @repo_root.join("LICENCE.txt")]
      files.each do |f|
        FileUtils.cp(f, @target_dir)
      end
      File.new(@target_dir.join("moj_template", "__init__.py"), "w").close
      File.open(File.join(@target_dir, "setup.py"), "w") do |f|
        f.write ERB.new(File.read(File.join(@repo_root, "source", "setup.py.erb"))).result(binding)
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
