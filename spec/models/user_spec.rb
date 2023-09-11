# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  it 'is invalid without an email' do
    expect(described_class.create(email: 'email@email.com')).to_not be_valid
  end

  it 'is invalid without a password' do
    expect(described_class.create(password: 'thisisapassword')).to_not be_valid
  end

  it 'is valid with all attributes' do
    expect(described_class.create(email: 'email@email.com', password: 'thisisapassword')).to be_valid
  end
end
