class FanclubsController < ApplicationController
    before_action :authenticate_user!, except: [ :show, :index ]
    before_action :set_fanclub, only: [ :edit, :update ]

    def index
      @fanclubs = Fanclub.all
    end

    def my_fanclub
      @fanclub = current_user.fanclub
    end

    def show
      @fanclub = Fanclub.find_by(id: params[:id])

      if @fanclub.nil?
        flash[:alert] = "ファンクラブが見つかりませんでした。"
        redirect_back(fallback_location: root_path) and return
        return
      end

      @contents = @fanclub.contents
    end

    def new
      if current_user.fanclub.present?
        redirect_to edit_fanclub_path(current_user.fanclub), alert: "ファンクラブは1件のみ作成可能です。"
      else
        @fanclub = current_user.build_fanclub
      end
    end

    def create
      if current_user.fanclub.present?
        redirect_to edit_fanclub_path(current_user.fanclub), alert: "ファンクラブは1件のみ作成可能です。"
      end

      @fanclub = current_user.build_fanclub(fanclub_params)
      if @fanclub.save
        redirect_to fanclubs_path, notice: "ファンクラブが開設されました"
      else
        flash[:alert] = "開設に失敗しました"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    # ファンクラブの更新
    def update
      if @fanclub.update(fanclub_params)
        redirect_to root_path, notice: "ファンクラブ情報を更新しました。"
      else
        flash.now[:alert] = "ファンクラブ情報の更新に失敗しました。"
        render :edit, status: :unprocessable_entity
      end
    end

    def subscribers
      @fanclub = current_user.fanclub
      unless @fanclub
        redirect_to root_path, alert: "ファンクラブが見つかりませんでした。"
        return
      end

      @subscribers = @fanclub.subscriptions
                            .includes(:user)
                            .where(status: "active")
                            .map do |subscription|
                              {
                                user: subscription.user,
                                points: rand(100..1000), # ランダムな支援ポイント
                                message: "応援しています！"
                              }
                            end.sort_by { |subscriber| -subscriber[:points] } # 支援ポイントが高い順
    end

    private

    def set_fanclub
      @fanclub = current_user.fanclub
      redirect_to new_fanclub_path, alert: "ファンクラブを開設してください。" unless @fanclub
    end

    def fanclub_params
      params.require(:fanclub).permit(:title, :description)
    end
end
