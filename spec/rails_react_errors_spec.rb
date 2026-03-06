# frozen_string_literal: true

require 'rails_react_errors'

RSpec.describe RailsReactErrors do
  it 'has a version number' do
    expect(RailsReactErrors::VERSION).not_to be_nil
  end

  it 'yields configuration' do
    RailsReactErrors.configure do |config|
      config.include_full_messages = false
    end

    expect(RailsReactErrors.configuration.include_full_messages).to eq(false)
  end
end
