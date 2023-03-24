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

  def edit; end

  def create
    @group = Group.new(group_params)
    @group.save

    if @group.save
      redirect_to '/'
    else
      render :new, alert: 'Error, Group not created'
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
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

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    # params.fetch(:group, {})
    params.require(:group).permit(:name, :icon).merge(user: current_user)
  end
end
