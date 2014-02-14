module MojTemplate
  class Engine < ::Rails::Engine
    initializer "moj_template.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        govuk-template*.css
        fonts*.css
        govuk-template.js
        ie.js
        vendor/goog/webfont-debug.js

        moj-template.css
        moj.js
        vendor/jquery/jquery-1.11.0.min.js
      )
    end
  end
end
