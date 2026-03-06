# frozen_string_literal: true

require "spec_helper"
require "active_model"
require "rails_react_errors"

RSpec.describe RailsReactErrors::Serializer do
  class DummyUser
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :email

    validates :email, presence: true
  end

  describe ".validation" do
    it "returns validation error payload" do
      user = DummyUser.new(email: nil)
      user.valid?

      result = described_class.validation(user)

      expect(result[:success]).to eq(false)
      expect(result[:message]).to eq("Validation failed")
      expect(result[:code]).to eq("VALIDATION_ERROR")
      expect(result[:errors]).to have_key(:email)
    end
  end

  describe ".not_found" do
    it "returns not found payload" do
      result = described_class.not_found("User not found")

      expect(result[:success]).to eq(false)
      expect(result[:message]).to eq("User not found")
      expect(result[:code]).to eq("NOT_FOUND")
    end
  end
end
