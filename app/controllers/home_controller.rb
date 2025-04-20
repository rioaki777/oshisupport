class HomeController < ApplicationController
  def index
    @announcements = Announcement.where("published_at <= ?", Time.current).order(published_at: :desc)
    @fanclubs = Fanclub.limit(10).order(created_at: :asc)
    @users = User.limit(10).order(created_at: :asc)
    @contents = @fanclubs.map { |fanclub| fanclub.contents.first }.compact
  end
end
