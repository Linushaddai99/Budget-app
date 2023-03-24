class EntitiesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @entities = Entity.joins(:groups).where(groups: { id: params[:group_id] }).order(created_at: :desc)
  end

  def new
    @groups = Group.where(user_id: current_user.id)
    @entity = Entity.new
  end

  def create
    params = entity_params
    @entity = Entity.new(name: params[:name], amount: params[:amount])
    @entity.author = current_user
    @groups_id = params[:group_ids]

    @groups_id.each do |id|
      group = Group.find(id) unless id == ''
      @entity.groups.push(group) unless group.nil?
    end

    return :new unless @entity.groups.any?

    if @entity.save
      redirect_to group_entities_path(@entity.groups.first.id), notice: 'Enitity added successfully'
    else
      render :new
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, group_ids: [])
  end
end
