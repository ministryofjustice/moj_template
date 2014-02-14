module MojHelper
  def config_item(key)
    Rails.configuration.send(key)
  end

  def environment
    env = ENV['APP_PLATFORM'] || Rails.env
  end
end