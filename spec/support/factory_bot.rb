require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:all) do
    DatabaseCleaner.clean_with :truncation, pre_count: true
  end

  config.before(:suite) do
  end

  config.after(:suite) do
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.append_after do
    DatabaseCleaner.clean
  end
end
