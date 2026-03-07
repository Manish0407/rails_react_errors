# frozen_string_literal: true

module RailsReactErrors
  module Controller
    def self.included(base)
      base.include RailsReactErrors::Renderer

      if defined?(ActiveRecord::RecordNotFound)
        base.rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
      end

      if defined?(ActiveRecord::RecordInvalid)
        base.rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
      end

      if defined?(ActionController::ParameterMissing)
        base.rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      end

      base.rescue_from ActiveRecord::RecordNotUnique, with: :handle_conflict if defined?(ActiveRecord::RecordNotUnique)

      base.rescue_from JSON::ParserError, with: :handle_invalid_json if defined?(JSON::ParserError)

      RailsReactErrors.configuration.custom_exceptions.each do |klass, config|
        exception_class = Object.const_get(klass)
        base.rescue_from exception_class do |exception|
          render_error(
            message: exception.message,
            code: config[:code],
            status: config[:status]
          )
        end
      rescue NameError
        next
      end

      return unless RailsReactErrors.configuration.rescue_standard_error

      base.rescue_from StandardError, with: :handle_internal_server_error
    end

    private

    def handle_record_not_found(exception)
      render_not_found_error(exception.message)
    end

    def handle_record_invalid(exception)
      render_validation_error(exception.record)
    end

    def handle_parameter_missing(exception)
      render_parameter_missing_error(exception.message)
    end

    def handle_conflict(exception)
      render_conflict_error(exception.message)
    end

    def handle_invalid_json(_exception)
      render_invalid_json_error('Invalid JSON payload')
    end

    def handle_internal_server_error(exception)
      log_exception(exception) if RailsReactErrors.configuration.log_errors
      render_server_error('Something went wrong')
    end

    def log_exception(exception)
      return unless defined?(Rails) && Rails.respond_to?(:logger) && Rails.logger

      Rails.logger.error("[RailsReactErrors] #{exception.class}: #{exception.message}")
    end
  end
end
