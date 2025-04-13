class ContentsController < ApplicationController
    before_action :authenticate_user!, except: [ :show, :index ]
    before_action :set_content, only: [ :edit, :update, :destroy ]

    def index
      @contents = Content.order(created_at: :asc)
    end

    def my_contents
      @contents = current_user.contents

      if @contents.nil?
        flash[:alert] = "コンテンツが見つかりませんでした。"
        redirect_back(fallback_location: root_path) and return
        nil
      end
    end

    def show
      @content = Content.find_by(id: params[:id])
      unless @content
        redirect_to root_path, alert: "コンテンツが見つかりませんでした。"
      end

      @fanclub = @content.fanclub
      @contents = @fanclub.contents
    end

    def new
      unless current_user.fanclub.present?
        flash[:alert] = "ファンクラブが見つかりません。"
        redirect_back(fallback_location: root_path) and return
      end

      @fanclub = current_user.fanclub
      @content = @fanclub.contents.build
    end

    def create
      @fanclub = current_user.fanclub
      @content = @fanclub.contents.build(content_params)
      if @content.save
        redirect_to fanclub_path(@fanclub), notice: "コンテンツが投稿されました"
      else
        render :new
      end
    end

    def edit
      @content = Content.find_by(id: params[:id])
    end

    def update
      if @content.fanclub.user != current_user
        redirect_to root_path, alert: "自分のコンテンツだけ編集できます" and return
      end

      if @content.update(content_params)
        redirect_to content _path, notice: "更新しました。"
      else
        flash.now[:alert] = "更新に失敗しました。"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @content.fanclub.user == current_user
        @content.destroy
        redirect_to my_contents_path, notice: "コンテンツを削除しました"
      else
        redirect_to root_path, alert: "自分のコンテンツだけ削除できます"
      end
    end

    private

    def set_content
      @content = Content.find_by(id: params[:id])
      if @content.nil?
        redirect_to root_path, alert: "コンテンツが見つかりませんでした。" and return
      end
    end

    def content_params
      params.require(:content).permit(:title, :description, :image)
    end
end
