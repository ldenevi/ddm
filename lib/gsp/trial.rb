module GSP::Trial
  class Application < Rails::Application
    # Conflict-Free Sourcing Initiative
    config.trial = ActiveSupport::OrderedOptions.new
    config.trial.max_users = 1
    config.trial.max_organizations = 1
  end
end
