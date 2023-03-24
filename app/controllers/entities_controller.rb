class EntitiesController < ApplicationController
  # before_action :set_entity, only: %i[show edit create new update destroy]

  # GET /entities or /entities.json
  def index
    @group = Group.find(params[:group_id])
    @entities = Entity.joins(:groups).where(groups: {id: params[:group_id]}).order(created_at: :desc)
  end

  # GET /entities/1 or /entities/1.json
  def show; end

  # GET /entities/new
  def new
    @groups = Group.where(user_id: current_user.id)
    @entity = Entity.new
  end

  # GET /entities/1/edit
  def edit; end

  # POST /entities or /entities.json
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
  
  # def create
  #   @entity = Entity.new(entity_params)

  #   if @entity.save!
  #     redirect_to group_entities_path(params[:group_id])
  #   end

    # respond_to do |format|
    #   if @entity.save
    #     format.html { redirect_to entity_url(@entity), notice: 'Entity was successfully created.' }
    #     format.json { render :show, status: :created, location: @entity }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @entity.errors, status: :unprocessable_entity }
    #   end
    # end
  # end

  # PATCH/PUT /entities/1 or /entities/1.json
  def update
    respond_to do |format|
      if @entity.update(entity_params)
        format.html { redirect_to entity_url(@entity), notice: 'Entity was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: 'Entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entity
    @entity = Entity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  # def entity_params
  #   params.require(:entity).permit(:name, :amount).merge(author: current_user)
  # end

  def entity_params
    params.require(:entity).permit(:name, :amount, group_ids: [])
  end
end
