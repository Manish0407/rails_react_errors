# frozen_string_literal: true

module RailsReactErrors
  module Renderer
    def render_validation_error(record, status: :unprocessable_entity)
      render json: RailsReactErrors::Serializer.validation(record), status: status
    end

    def render_not_found_error(message = "Record not found", status: :not_found)
      render json: RailsReactErrors::Serializer.not_found(message), status: status
    end

    def render_unauthorized_error(message = "Unauthorized", status: :unauthorized)
      render json: RailsReactErrors::Serializer.unauthorized(message), status: status
    end

    def render_forbidden_error(message = "Forbidden", status: :forbidden)
      render json: RailsReactErrors::Serializer.forbidden(message), status: status
    end

    def render_server_error(message = "Something went wrong", status: :internal_server_error)
      render json: RailsReactErrors::Serializer.server_error(message), status: status
    end

    def render_error(message:, code:, errors: {}, status:)
      render json: {
        success: false,
        message: message,
        code: code,
        errors: errors
      }, status: status
    end
  end
end
