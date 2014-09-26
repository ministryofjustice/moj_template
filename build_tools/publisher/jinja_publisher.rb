require 'moj_template/version'
require 'tmpdir'
require 'open3'

module Publisher
  class JinjaPublisher
    def initialize(version = MojTemplate::VERSION)
      @version = version
      @repo_root = Pathname.new(File.expand_path('../../..', __FILE__))
      @source_dir = @repo_root.join('pkg', "jinja_moj_template-#{@version}")
    end

    def publish
      Dir.chdir(@source_dir) do
        run "python setup.py register"
        run "python setup.py sdist upload"
      end
    end

    def version_released?
      output = run('curl "https://pypi.python.org/simple/jinja-moj-template/"')
      return !! output.match(/jinja-moj-template-#{@version}/)
    end

    private

    def run(command)
      output, status = Open3.capture2e(command)
      abort "Error running #{command}: exit #{status.exitstatus}\n#{output}" if status.exitstatus > 0
      output
    end
  end
end
