require 'moj_template/version'
require 'tmpdir'
require 'open3'

module Publisher
  class DjangoPublisher
    def initialize(version = MojTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "django_moj_template-#{@version}")
    end

    def publish
      Dir.chdir(@source_dir) do
        puts run "python setup.py register"
      end
    end

    def version_released?
      output = run('curl "https://pypi.crate.io/simple/moj_template/"')
      return !! output.match(/moj_template-#{@version}/)
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
