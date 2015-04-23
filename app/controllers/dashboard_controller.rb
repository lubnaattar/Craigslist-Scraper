class DashboardController < ApplicationController
  def home

    #  @posts = Post.all
    #  @posts = Post.group(:city).count #city,  #count_all;
    #  @posts1 = Post.group(:year).count #year, #count_all
     @posts = Post.where("city like ?", "Anaheim").group(:year).count.to_a
     @posts1 = Post.group(:year).count.to_a #year, #count_all
     @posts2 = Post.group(:city).count.to_a
     @posts3 = Post.group(:make_vehicle).count.to_json


     #count_all, year, make_vehicle : line bar chart
     @postsLine2011 = Post.where("year = ? and year is not null and make_vehicle is not null", "2011").group(:make_vehicle).count.to_a
     @postsLine2012 = Post.where("year = ? and year is not null and make_vehicle is not null", "2012").group(:make_vehicle).count.to_a
     @postsLine2013 = Post.where("year = ? and year is not null and make_vehicle is not null", "2013").group(:make_vehicle).count.to_a
     @postsLine2014 = Post.where("year = ? and year is not null and make_vehicle is not null", "2014").group(:make_vehicle).count.to_a
     @postsLine2015 = Post.where("year = ? and year is not null and make_vehicle is not null", "2015").group(:make_vehicle).count.to_a
     @postsLine = Post.select(:make_vehicle).where("year >= ? and  year is not null and make_vehicle is not null", "2011").uniq

     # clear, salvage , status , render with where params
     @postsHBarClean = Post.where("year = ? and title_status like ? and make_vehicle is not null","2015", "clean").group(:make_vehicle).count.to_a
     @postsHBarSalvage = Post.where("year = ? and title_status like ? and make_vehicle is not null","2015", "salvage").group(:make_vehicle).count.to_a
     @postsHBarPartsOnly = Post.where("year = ? and title_status like ? and make_vehicle is not null","2015", "parts only").group(:make_vehicle).count.to_a
     @postsHBarRebuilt = Post.where("year = ? and title_status like ? and make_vehicle is not null","2015", "rebuilt").group(:make_vehicle).count.to_a
     @postsHBarLien = Post.where("year = ? and title_status like ? and make_vehicle is not null","2015", "lien").group(:make_vehicle).count.to_a
     @postsHBar = Post.select(:make_vehicle).where("year >= ? and title_status is not null and make_vehicle is not null","2011" ).uniq

  #   sql = "select distinct make_vehicle from posts where year >= '2011' and year is not null and and make_vehicle is not null"
  ##   records_array = ActiveRecord::Base.connection.execute(sql);

  end
end
