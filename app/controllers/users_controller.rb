class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def new
    # @wishlist = Wishlist.new
    # @user = User.new(user_params)

  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to controller: 'users', action: 'show'
      flash[:success] = 'Account created'
    elsif @user.errors.full_messages.include?("Email has already been taken")
      flash[:errors] = ["Oups... it seams that you already have an account!"]
      redirect_to new_user_session_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_session_path
    end
  end

  def show
    #iterate over all groups
    @wishlist = current_user.wishlist if current_user.wishlist
    @groups = current_user.groups if current_user.groups
    if @gifts
      wishlist_gifts = []
      @wishlist.gifts.each do |gift|
        wishlist_gifts << gift.name
      end
    end
    flash[:notices] = wishlist_gifts
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
