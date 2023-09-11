require 'rails_helper'

RSpec.describe 'Flats', type: :request do
  let(:user) { User.create(email: 'email@mail.com', password: 'password') }
  let(:another_user) { User.create(email: 'mail@email.nl', password: '1234') }
  let(:my_name) { 'My flat' }
  let(:my_description) { 'beautiful flat' }
  let(:number) { 2 }
  let(:my_address) { '2 Church Street' }
  let(:price) { 100 }
  let(:flat) do
    Flat.create(
      user:,
      name: my_name,
      description: my_description,
      number_of_guests: number,
      address: my_address,
      price_per_night: price
    )
  end

  describe 'GET /flats' do
    it 'returns 200' do
      sign_in user
      get flats_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /flat' do
    it 'returns 200' do
      sign_in user
      get flat_path(flat.id)
      expect(response.body).to include('beautiful flat')
      expect(response.body).to include('edit')
      expect(response).to have_http_status(200)
    end

    it 'does not give an edit option' do
      sign_in another_user
      get flat_path(flat.id)
      expect(response.body).not_to include('edit')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST flat#create' do
    it 'creates a flat' do
      sign_in user
      expect(Flat.all.count).to eq(0)

      flat_params = { flat: {
        name: my_name,
        description: my_description,
        number_of_guests: number,
        user:,
        address: my_address,
        price_per_night: price
      } }

      post '/flats', params: flat_params
      expect(Flat.all.count).to eq(1)
    end
  end

  describe 'PATCH flat#update' do
    let(:new_name) { 'new name' }
    it 'updates a flat' do
      sign_in user
      flat

      flat_params = { flat: {
        name: new_name,
        description: my_description,
        number_of_guests: number,
        user:,
        address: my_address,
        price_per_night: price
      } }

      patch "/flats/#{flat.id}", params: flat_params
      expect(flat.reload.name).to eq(new_name)
    end
  end

  describe 'DELETE /flats' do
    it 'does not let another user delete the flat' do
      sign_in another_user
      flat
      expect(Flat.all.count).to eq(1)
      expect { delete "/flats/#{flat.id}" }.to raise_error(Pundit::NotAuthorizedError)
      expect(Flat.all.count).to eq(1)
    end

    it 'deletes the flat' do
      sign_in user
      flat
      expect(Flat.all.count).to eq(1)
      delete "/flats/#{flat.id}"
      expect(Flat.all.count).to eq(0)
    end
  end
end
