class SubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def index
      @subscriptions = current_user.subscriptions.where(status: "active")
    end

    def create
        @fanclub = Fanclub.find(params[:fanclub_id])
        subscription = @fanclub.subscriptions.find_or_initialize_by(user: current_user)

        if subscription.new_record?
          # 新しいサブスクリプションの場合
          subscription.start_date = Date.today
          subscription.status = "active"
        elsif subscription.cancelled?
          # 既存のキャンセルされたサブスクリプションを再利用
          subscription.update(start_date: Date.today, status: "active", end_date: nil)
        end

        if subscription.save
          redirect_to fanclub_path(@fanclub), notice: "ファンクラブに加入しました！"
        else
          redirect_to fanclub_path(@fanclub), alert: "加入に失敗しました。"
        end
      end

    def destroy
        subscription = current_user.subscriptions.find_by(fanclub_id: params[:fanclub_id])

        if subscription&.active?
            subscription.update(status: "cancelled", end_date: Date.today)
            redirect_to fanclub_path(subscription.fanclub), notice: "ファンクラブを退会しました。"
        else
            redirect_to root_path, alert: "退会に失敗しました。"
        end
    end
end
