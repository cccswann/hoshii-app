class WishlistsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
        @user = User.find_by(params[:id])
        @user_wishlists = @user.wishlists
    end

    def new
        @user = User.find_by(params[:id])
        @wishlist = Wishlist.new    
    end

    def create
        @user = User.find_by(params[:id])
        @wishlist = Wishlist.new(wishlist_params)
        @wishlist.user = @user
        if @wishlist.save
          redirect_to user_wishlist_path(@user, @wishlist), notice: "Wishlist created successfully."
        else
          render :new
        end
    end

    def show
        @user = User.find_by(params[:id])
        @wishlist = Wishlist.find_by(params[:id])
    end

    def edit
        @wishlist = Wishlist.find_by(params[:id])
        @user = User.find_by_id(@wishlist.user_id)
    end


  def update
    @wishlist = Wishlist.find_by(params[:id])
    @user = User.find_by_id(@wishlist.user_id)
      if @wishlist.update(wishlist_params)
        redirect_to user_wishlist_path(@user, @wishlist)
      else
          render 'edit'
      end
  end

  def destroy
    Wishlist.find(params[:id]).destroy
    flash[:success] = "Wishlist deleted"
    redirect_to user_wishlists(@current_user)
  end

  def toggle_groupbuy
    @wishlist = Wishlist.find_by_id(params[:wishlist_id])
    @wishlist.toggle_groupbuy(Groupbuy.find_by_id(params[:groupbuy_id]))
    redirect_to groupbuys_path(:wishlist_id => @wishlist.id)
  end
  
  private

  def wishlist_params
    params.require(:wishlist).permit(:name, :note)
  end
end
