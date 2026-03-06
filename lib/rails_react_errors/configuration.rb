# frozen_string_literal: true

module RailsReactErrors
  class Configuration
    attr_accessor :include_full_messages,
                  :rescue_standard_error,
                  :log_errors

    def initialize
      @include_full_messages = true
      @rescue_standard_error = false
      @log_errors = true
    end
  end
end
