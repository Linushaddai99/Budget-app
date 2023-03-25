require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @user = User.create(name: 'User', email: '123@gmail.com', password: '123456', password_confirmation: '123456')
    @group = Group.create(name: 'Food', icon: 'https://www.sliderrevolution.com/wp-content/uploads/2020/02/srlogo.png',
                          user: @user)
  end

  describe 'validations' do
    it 'should be valid with valid attributes' do
      expect(@group).to be_a(Group)
      expect(@group).to be_valid
    end

    it 'is valid with a name' do
      @group.name = 'Food'
      expect(@group).to be_valid
    end
  end
end
