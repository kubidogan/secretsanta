# class GroupsController < ApplicationController
#   before_action :set_group, only: %i[ show edit update destroy ]

#   # GET /groups or /groups.json
#   def index
#     @groups = Group.all
#   end

#   # GET /groups/1 or /groups/1.json
#   def show
#   end

#   # GET /groups/new
#   def new
#     @group = Group.new
#   end

#   # GET /groups/1/edit
#   def edit
#   end

#   # POST /groups or /groups.json
#   def create
#     @group = Group.new(group_params)

#     respond_to do |format|
#       if @group.save
#         format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
#         format.json { render :show, status: :created, location: @group }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @group.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /groups/1 or /groups/1.json
#   def update
#     respond_to do |format|
#       if @group.update(group_params)
#         format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
#         format.json { render :show, status: :ok, location: @group }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @group.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /groups/1 or /groups/1.json
#   def destroy
#     @group.destroy

#     respond_to do |format|
#       format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_group
#       @group = Group.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def group_params
#       params.require(:group).permit(:name, :budget)
#     end
# end

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @group.users << User.new
    # 7.times { @group.users.build}
  end

  def create
    # raise params.inspect
    @group = Group.new(group_params)
    # @user.groups.build(name: params[:group][:name], budget: params[:group][:budget])

    if @group.valid?
      @group.save
      Invitation.create(user_id: current_user.id, group_id: @group.id, accepted: false)
      redirect_to group_path(@group.id)
    else
      #When new page renders, the @error object with params is passed to the view
      flash[:errors] = @group.errors.full_messages
      redirect_to new_group_path
    end
  end

  def add_user
  end

  def create_user
    @group = Group.find(params[:id])
    find_user = User.find_by(email: params[:user][:email])
    if find_user
      if find_user.email == current_user.email
        flash[:errors] = ["You are already in the draw"]
        redirect_to add_user_path
      elsif @group.users.include?(find_user)
        flash[:errors] = ["This user is already in the draw"]
        redirect_to add_user_path
      else
        # @user = User.find(params[:id])
        Invitation.create(user_id: find_user.id, group_id: @group.id, accepted: false)
        redirect_to group_path(@group.id)
      end
    else
      @user = User.new(name: params[:user][:name], email: params[:user][:email], password: "password", password_confirmation: "password")
      if @user.valid?
        @user.save
        Invitation.create(user_id: @user.id, group_id: @group.id, accepted: false)
        redirect_to group_path(@group.id)
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to add_user_path
      end
    end
    # name: params[:group]["users_attributes"]["0"]["name"], email: params[:group]["users_attributes"]["0"]["email"]
  end

  def show
    # raise
    #Once we have created a group, we create a show page
    #before action redirect them to
    @group = Group.find(params[:id])
  end

  def make_draw
    @group = Group.find(params[:id])
    if @group.users.length > 4
      @draws = @group.draw_order
        # send_draw(@group)
      render :show
      # redirect_to group_path(@group.id)
      #call send draw
    else
      flash[:errors] = ["You need at least 5 participants. Please add #{5-@group.users.length} more participants."]
      redirect_to group_path(@group)
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @group.destroy
    redirect_to show_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :budget, users_attributes: [:name, :email])
  end

  def set_group
    @group = Group.find(params[:id])
  end

  # def send_draws(draws)
  #     draws.each do |draw|
  #       draw.each do |x, y|
  #         draw = Draw.new(giver: x, receiver: y)
  #         @groups.draws << draw
  #         draw.save
  #       end
  #     end
  #
  #     @group.draws.each do |draw|
  #       # draw.send_email #Take draw and send via email
  #     end
  #   end

end
