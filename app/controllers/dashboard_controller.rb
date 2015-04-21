class DashboardController < ApplicationController
  def home

    #  @posts = Post.all
    #  @posts = Post.group(:city).count #city,  #count_all
    #  @posts1 = Post.group(:year).count #year, #count_all
     @posts = Post.where("city like ?", "Anaheim").group(:year).count.to_a
     @posts1 = Post.group(:year).count.to_a #year, #count_all
     @posts2 = Post.group(:city).count.to_a
     @posts3 = Post.group(:make_vehicle).count.to_json
  end
end
