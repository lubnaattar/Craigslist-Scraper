class DashboardController < ApplicationController
  def home

  #  @posts = Post.all
     @posts = Post.group(:city).count #city,  #count_all
     @posts1 = Post.group(:year).count #year, #count_all
  end
end
