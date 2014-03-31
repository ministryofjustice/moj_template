module MojHelper

  # this fails unless the config key has been set
  def config_item(key)
    Rails.configuration.send(key) 
  end

  def add_google_analytics
    if config_item :ga_id

      ga_id = config_item :ga_id
      ga_domain = config_item(:ga_domain) || 'auto'

      <<-eojs
      <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', '#{ga_id}', '#{ga_domain}');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
      </script>
      eojs
    end
  end
end
