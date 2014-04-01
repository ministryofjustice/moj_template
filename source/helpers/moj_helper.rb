module MojHelper
  def config_item(key)
    Rails.configuration.send(key)
  end
end