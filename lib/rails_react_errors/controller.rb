# frozen_string_literal: true

module RailsReactErrors
  module Controller
    def self.included(base)
      base.include RailsReactErrors::Renderer

      if defined?(ActiveRecord::RecordNotFound)
        base.rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
      end

      if defined?(ActionController::ParameterMissing)
        base.rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      end

      if RailsReactErrors.configuration.rescue_standard_error
        base.rescue_from StandardError, with: :handle_internal_server_error
      end
    end

    private

    def handle_record_not_found(exception)
      render_not_found_error(exception.message)
    end

    def handle_parameter_missing(exception)
      render json: {
        success: false,
        message: exception.message,
        code: "PARAMETER_MISSING",
        errors: {}
      }, status: :bad_request
    end

    def handle_internal_server_error(exception)
      log_exception(exception) if RailsReactErrors.configuration.log_errors
      render_server_error("Something went wrong")
    end

    def log_exception(exception)
      return unless defined?(Rails) && Rails.respond_to?(:logger) && Rails.logger

      Rails.logger.error("[RailsReactErrors] #{exception.class}: #{exception.message}")
    end
  end
end
