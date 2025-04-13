# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = current_user
    if @user.update_without_password(user_params)
      redirect_to home_path, notice: "プロフィールを更新しました。"
    else
      flash[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def update_resource(resource, params)
    # パスワードが提供されていない場合は、バリデーションをスキップ
    if params[:password].blank? && params[:current_password].blank?
      resource.update_without_password(params)
    else
      super
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image)
  end
end
