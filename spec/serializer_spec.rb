# frozen_string_literal: true

require 'spec_helper'
require 'active_model'
require 'rails_react_errors'

class DummyUser
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, presence: true
end

RSpec.describe RailsReactErrors::Serializer do
  describe '.validation' do
    it 'returns validation error payload' do
      user = DummyUser.new(email: nil)
      user.valid?

      result = described_class.validation(user)

      expect(result[:success]).to eq(false)
      expect(result[:message]).to eq('Validation failed')
      expect(result[:code]).to eq('VALIDATION_ERROR')
      expect(result[:errors]).to have_key(:email)
    end
  end

  describe '.not_found' do
    it 'returns not found payload' do
      result = described_class.not_found('User not found')

      expect(result[:success]).to eq(false)
      expect(result[:message]).to eq('User not found')
      expect(result[:code]).to eq('NOT_FOUND')
    end
  end

  describe '.parameter_missing' do
    it 'returns parameter missing payload' do
      result = described_class.parameter_missing('param is missing or the value is empty: user')

      expect(result[:success]).to eq(false)
      expect(result[:message]).to eq('param is missing or the value is empty: user')
      expect(result[:code]).to eq('PARAMETER_MISSING')
      expect(result[:errors]).to eq({})
    end
  end
end
