class Api::V1::UserController < ApplicationController

  def index
    user = User.all
    render :json => user
  end

  def create
    begin
      user = User.create!(user_params)
      user_id = User.find_by(email: params[:user][:email]).id
      render :json => user_id, status: 200
    rescue ActiveRecord::RecordInvalid
      message = "メールアドレスまたはパスワードが不正な値です。もう一度入力し直してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end