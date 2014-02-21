require 'open3'
require 'moj_template/version'
require_relative 'tar_packager'
require_relative '../compiler/mustache_processor'

module Packager
  class MustachePackager < TarPackager
    def initialize
      super
      @base_name = "moj_template-#{MojTemplate::VERSION}.mustache"
    end

    def build
      Dir.mktmpdir("moj_template") do |dir|
        @target_dir = Pathname.new(dir).join(@base_name)
        @target_dir.mkpath
        generate_package_json
        prepare_contents
        create_tarball
      end
    end

    def generate_package_json
      contents = ERB.new(File.read(File.join(@repo_root, "source/package.json.erb"))).result(binding)
      File.open(File.join(@target_dir, "package.json"), "w") do |f|
        f.write contents
      end
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      File.open(target_dir.join(generated_file_name(file)), 'wb') do |f|
        f.write Compiler::MustacheProcessor.new(file).process
      end
    end

    private

    def generated_file_name(file_path)
      File.basename(file_path, File.extname(file_path))
    end
  end
end
