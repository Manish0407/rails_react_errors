# frozen_string_literal: true

module RailsReactErrors
  class Serializer
    def self.validation(record)
      new.validation(record)
    end

    def self.not_found(message = "Record not found")
      new.not_found(message)
    end

    def self.unauthorized(message = "Unauthorized")
      new.unauthorized(message)
    end

    def self.forbidden(message = "Forbidden")
      new.forbidden(message)
    end

    def self.server_error(message = "Something went wrong")
      new.server_error(message)
    end

    def validation(record)
      {
        success: false,
        message: "Validation failed",
        code: "VALIDATION_ERROR",
        errors: serialized_errors(record)
      }
    end

    def not_found(message)
      {
        success: false,
        message: message,
        code: "NOT_FOUND",
        errors: {}
      }
    end

    def unauthorized(message)
      {
        success: false,
        message: message,
        code: "UNAUTHORIZED",
        errors: {}
      }
    end

    def forbidden(message)
      {
        success: false,
        message: message,
        code: "FORBIDDEN",
        errors: {}
      }
    end

    def server_error(message)
      {
        success: false,
        message: message,
        code: "INTERNAL_SERVER_ERROR",
        errors: {}
      }
    end

    private

    def serialized_errors(record)
      return {} unless record.respond_to?(:errors)

      if RailsReactErrors.configuration.include_full_messages
        record.errors.to_hash(true)
      else
        record.errors.to_hash
      end
    end
  end
end
