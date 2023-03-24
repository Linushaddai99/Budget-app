class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @icons = [
      {
        'name' => 'Food icon',
        'source' => 'assets/images/food.png'
      },
      {
        'name' => 'Gadgets icon',
        'source' => '/assets/images/gadget.png'
      },
      {
        'name' => 'Clothing icon',
        'source' => '/assets/images/clothing.png'
      },
      {
        'name' => 'Accessories',
        'source' => '/assets/images/accessories.png'
      },
      {
        'name' => 'Skincare',
        'source' => '/assets/images/skincare.png'
      },
      {
        'name' => 'Finances',
        'source' => '/assets/images/finances.png'
      },
      {
        'name' => 'Education',
        'source' => '/assets/images/education.png'
      },
      {
        'name' => 'Other',
        'source' => '/assets/images/other.png'
      }
    ]
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save

    if @group.save
      redirect_to '/'
    else
      render :new, alert: 'Error, Group not created'
    end
  end

  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon).merge(user: current_user)
  end
end
