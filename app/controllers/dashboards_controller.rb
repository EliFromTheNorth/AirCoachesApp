class DashboardsController < ApplicationController
  def dashboard
    @coachee_bookings = current_user.bookings
    @coach_bookings = current_user.coaching_offers.extract_associated(:bookings).flatten
    @your_offers = current_user.coaching_offers
  end
end
