require 'spec_helper'
require File.join(PROJECT_ROOT, 'build_tools/compiler/asset_compiler.rb')
require File.join(PROJECT_ROOT, 'build_tools/packager/mustache_packager.rb')

describe Packager::MustachePackager do
  let(:generated_directory_path) {File.join(PROJECT_ROOT, "pkg/mustache_moj_template-#{MojTemplate::VERSION}")}
  let(:generated_template_path) {File.join(generated_directory_path, "views/layouts/moj_template.html")}
  let(:generated_package_json_path) {File.join(generated_directory_path, "package.json")}
  subject {described_class.new}

  after do
    FileUtils.rm_rf(generated_directory_path)
  end

  context "functional" do
    describe "build" do

      let(:example_package_json) {ERB.new(File.read(File.join(PROJECT_ROOT, 'source/package.json.erb'))).result(binding)}
      it "should output the correct template" do
        subject.build

        generated_template = File.read(generated_template_path)
        generated_template.should =~ %r[\A{{{ topOfPage }}}]
        generated_template.should =~ %r[href="{{{ assetPath }}}stylesheets/moj-template\.css\?#{Regexp.escape(MojTemplate::VERSION)}"]

        File.read(generated_package_json_path).should == example_package_json
      end

    end
  end

end
