require 'moj_template/version'
require 'tmpdir'
require 'open3'
require 'fileutils'

module Publisher
  class DjangoPublisher
    def initialize(version = MojTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "moj_template-#{@version}.django")
    end

    def publish
      Dir.chdir("pkg") do
        run "gzip -d < moj_template-#{@version}.django.tgz | tar xvf -"
        Dir.chdir("moj_template-#{@version}.django") do
          puts run "python setup.py register"
          puts run "python setup.py sdist upload"
        end
        FileUtils.rm_rf "moj_template-#{@version}.django"
      end
    end

    def version_released?
      output = run('curl "https://pypi.python.org/simple/django-moj-template/"')
      return !! output.match(/django-moj-template-#{@version}/)
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
