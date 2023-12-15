class StaticPagesController < ApplicationController
  def home
    authenticate_user!
  end
end
