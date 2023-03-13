class CoachingOffersController < ApplicationController

  before_action :set_coaching_offer, only: [:show, :edit, :update, :destroy, :status]

  def index
    query = params[:query]
    if query.present?
      @coaching_offers = CoachingOffer.search_by_title_description_skill(query)
    else
      @coaching_offers = CoachingOffer.all
    end
  end

  def show
    @coaching_offer = CoachingOffer.find(params[:id])
    @coaching_offers = CoachingOffer.where(user: @coaching_offer.user).excluding(@coaching_offer)
    @booking = Booking.new
    @offer_reviews = @coaching_offer.reviews
  end

  def new
    @coaching_offer = CoachingOffer.new
  end

  def create
    @coaching_offer = CoachingOffer.new(coaching_offer_params)
    @coaching_offer.user = current_user
    if @coaching_offer.save
      redirect_to coaching_offer_path(@coaching_offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # ****
  #update
  def edit
  end

  def update
    @coaching_offer.update(coaching_offer_params)
    redirect_to dashboard_path(@coaching_offer)
  end

  #delete
  def destroy
    @coaching_offer.destroy
    redirect_to dashboard_url, notice: "The offer was deleted."
  end

  def status
    @coaching_offer.status = params[:status]
    @coaching_offer.save
    redirect_to dashboard_path
  end


  private

  def coaching_offer_params
    params.require(:coaching_offer).permit(:skill, :description, :price, :title, :rating)
  end

  def set_coaching_offer
    @coaching_offer = CoachingOffer.find(params[:id])
  end
end
