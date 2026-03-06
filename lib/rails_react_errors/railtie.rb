# frozen_string_literal: true

require "rails/railtie"

module RailsReactErrors
  class Railtie < Rails::Railtie
    initializer "rails_react_errors.configure_controller" do
      ActiveSupport.on_load(:action_controller_api) do
        include RailsReactErrors::Renderer
      end

      ActiveSupport.on_load(:action_controller) do
        include RailsReactErrors::Renderer
      end
    end
  end
end
