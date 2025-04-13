class HomeController < ApplicationController
  def index
    @announcements = Announcement.where("published_at <= ?", Time.current).order(published_at: :desc)
    @fanclubs = Fanclub.limit(6).order(created_at: :asc)
    @users = User.limit(6).order(created_at: :asc)
    @contents = @fanclubs.map { |fanclub| fanclub.contents.first }.compact
  end
end
