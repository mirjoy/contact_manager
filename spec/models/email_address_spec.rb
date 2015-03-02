require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email1) {EmailAddress.new(email: "email@email.com", contact_id:1, contact_type: 'Person')}

  it 'is valid' do
    expect(email1).to be_valid
  end

  it 'is invalid without an address' do
    email1.email = nil
    expect(email1).to_not be_valid
  end

  it 'must have a reference to a person' do
    email1.contact_id = nil
    expect(email1).not_to be_valid
  end

  it 'is associated with a person' do
    expect(email1).to respond_to(:contact)
  end

end
