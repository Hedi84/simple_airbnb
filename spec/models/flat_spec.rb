# frozen_string_literal: true

require 'pry'

require 'rails_helper'
RSpec.describe Flat, type: :model do
  let(:my_user) { User.create(email: 'email@email.com', password: 'apassword') }
  let(:my_name) { 'My flat' }
  let(:my_description) { 'beautiful flat' }
  let(:number) { 2 }
  let(:my_address) { '2 Church Street' }
  let(:price) { 100 }
  let(:my_url) { 'https//www.photo.com' }

  describe 'validations' do
    context 'when attributes are missing' do
      it 'is invalid without a price per night' do
        expect(described_class.create(
                 user: my_user,
                 name: my_name,
                 description: my_description,
                 number_of_guests: number,
                 address: my_address,
                 url: my_url
               )).not_to be_valid
      end

      it 'is invalid without an address' do
        expect(described_class.create(
                 user: my_user,
                 name: my_name,
                 description: my_description,
                 number_of_guests: number,
                 price_per_night: price,
                 url: my_url
               )).not_to be_valid
      end

      it 'is invalid without a number of guests' do
        expect(described_class.create(
                 user: my_user,
                 name: my_name,
                 description: my_description,
                 address: my_address,
                 price_per_night: price,
                 url: my_url
               )).not_to be_valid
      end

      it 'is invalid without a description' do
        expect(described_class.create(
                 user: my_user,
                 name: my_name,
                 number_of_guests: number,
                 address: my_address,
                 price_per_night: price,
                 url: my_url
               )).not_to be_valid
      end

      it 'is invalid without a name' do
        expect(described_class.create(
                 user: my_user,
                 number_of_guests: number,
                 description: my_description,
                 address: my_address,
                 price_per_night: price,
                 url: my_url
               )).not_to be_valid
      end

      it 'is invalid without a user' do
        expect(described_class.create(
                 name: my_name,
                 number_of_guests: number,
                 description: my_description,
                 address: my_address,
                 price_per_night: price,
                 url: my_url
               )).not_to be_valid
      end
    end

    context 'when all required attributes are there' do
      let(:new_flat) do
        described_class.create(
          name: my_name,
          description: my_description,
          number_of_guests: number,
          address: my_address,
          price_per_night: price,
          user: my_user,
          url: my_url
        )
      end

      it 'is valid with all required attributes' do
        expect(new_flat).to be_valid
      end

      let(:new_flat_no_url) do
        described_class.create(
          name: my_name,
          description: my_description,
          number_of_guests: number,
          address: my_address,
          price_per_night: price,
          user: my_user,
          url: nil
        )
      end

      it 'is valid without a url' do
        expect(new_flat_no_url).to be_valid
      end
    end
  end

  describe '#property_image' do
    before do
      described_class.create(
        user: my_user,
        name: my_name,
        description: my_description,
        number_of_guests: number,
        address: my_address,
        price_per_night: price
      )
    end

    context 'when it has a url' do
      let(:property) { Flat.last }
      let(:website) { 'www.images.com/2' }
      let(:default_url) { 'https://static.vecteezy.com/system/resources/previews/000/322/151/original/realistic-house-vector.jpg' }

      it 'returns the default url' do
        allow(property).to receive(:property_image).and_return(default_url)
        expect(property.url).to be_nil
        expect(property.property_image).to eq(default_url)
      end

      it 'returns the custom url' do
        property.update(url: website)
        expect(property.url).to eq(website)
        expect(property.property_image).to eq(website)
      end
    end
  end
end
