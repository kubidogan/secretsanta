class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: params[:group][:name], budget: params[:group][:budget])
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
    @user = User.create
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
        Invitation.create(user_id: find_user.id, group_id: @group.id, accepted: true)
        redirect_to group_path(@group.id)
      end
    else
      @user = User.new(name: params[:user][:name], email: params[:user][:email], password: "password", password_confirmation: "password")
      if @user.valid?
        @user.save
        Invitation.create(user_id: @user.id, group_id: @group.id, accepted: true)
        redirect_to group_path(@group.id)
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to add_user_path
      end
    end
  end

  def show
    @matched = []
    @group = Group.find(params[:id])
  end

  def make_draw
    @group = Group.find(params[:id])
    if @group.users.length > 4
      @draws = @group.draw_order
      @matched = []
      @matched << @draws
      render :show
    else
      flash[:errors] = ["You need at least 5 participants. Please add #{5 - @group.users.length} more participants."]
      redirect_to group_path(@group)
    end
  end

  def edit
    @gift = Gift.new
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
end
