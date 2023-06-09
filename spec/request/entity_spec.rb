require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/groups/:group_id/entities', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # entity. As you add validations to entity, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) do
  #   skip('Add a hash of attributes valid for your model')
  # end
  # let(:invalid_attributes) do
  #   skip('Add a hash of attributes invalid for your model')
  # end

  before :each do
    @user = User.create(name: 'User', email: '123@gmail.com', password: '123456', password_confirmation: '123456')
    @group = Group.create(name: 'Food', icon: 'https://www.sliderrevolution.com/wp-content/uploads/2020/02/srlogo.png',
                          user: @user)
    @entity = Entity.create(name: 'Veggies', amount: 50, author_id: @user.id)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get group_entities_url(@group)
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get group_entity_url(@group, @entity)
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_group_entity_url(@group)
      expect(response).to have_http_status(:found)
    end
  end
end
