# frozen_string_literal: true

require_relative "rails_react_errors/version"
require_relative "rails_react_errors/configuration"
require_relative "rails_react_errors/serializer"
require_relative "rails_react_errors/renderer"
require_relative "rails_react_errors/controller"

module RailsReactErrors
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

require_relative "rails_react_errors/railtie" if defined?(Rails::Railtie)
