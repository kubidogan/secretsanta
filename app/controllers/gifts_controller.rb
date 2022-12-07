# class GiftsController < ApplicationController
#   before_action :set_gift, only: %i[ show edit update destroy ]

#   # GET /gifts or /gifts.json
#   def index
#     @gifts = Gift.all
#   end

#   # GET /gifts/1 or /gifts/1.json
#   def show
#   end

#   # GET /gifts/new
#   def new
#     @gift = Gift.new
#   end

#   # GET /gifts/1/edit
#   def edit
#   end

#   # POST /gifts or /gifts.json
#   def create
#     @gift = Gift.new(gift_params)

#     respond_to do |format|
#       if @gift.save
#         format.html { redirect_to gift_url(@gift), notice: "Gift was successfully created." }
#         format.json { render :show, status: :created, location: @gift }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @gift.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /gifts/1 or /gifts/1.json
#   def update
#     respond_to do |format|
#       if @gift.update(gift_params)
#         format.html { redirect_to gift_url(@gift), notice: "Gift was successfully updated." }
#         format.json { render :show, status: :ok, location: @gift }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @gift.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /gifts/1 or /gifts/1.json
#   def destroy
#     @gift.destroy

#     respond_to do |format|
#       format.html { redirect_to gifts_url, notice: "Gift was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_gift
#       @gift = Gift.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def gift_params
#       params.require(:gift).permit(:name, :price, :description)
#     end
# end

class GiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @gifts = Gift.all
  end

  def show
    @wishlist = current_user.wishlist
  end

  def new
    @gift = Gift.new
  end

  def create
    @wishlist = Wishlist.find_or_create_by(user: current_user)
    @gift = Gift.new(name: params[:gift][:name], price: params[:gift][:price], description: params[:gift][:description], wishlist_id: @wishlist.id)
    if @gift.valid?
      @gift.save
      redirect_to gift_path(@gift)
    else
      flash[:errors] = @gift.errors.full_messages
      redirect_to new_gift_path
    end
  end

  def edit
  end

  def update
    @gift.update(name: params[:gift][:name], price: params[:gift][:price], description: params[:gift][:description])
    redirect_to gift_path(@gift)
  end

  def destroy
    @gift.destroy
    redirect_to new_gift_path
  end

  private

  def set_gift
    @gift = Gift.find(params[:id])
  end

  def gift_params
    params.require(:gift).permit(:name, :price, :description)
  end

end
