class Api::V1::SessionsController < ApplicationController

  def create
    begin
      user = User.find_by(email: params[:user][:email])
      raise ActiveRecord::RecordInvalid if user == nil
      raise ActiveRecord::RecordInvalid unless user.authenticate(params[:user][:password])
      login(user)
      render :json => user, status: 200
    rescue ActiveRecord::RecordInvalid
      message = "メールアドレスまたはパスワードが一致しません。もう一度入力し直してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  def get_login_user
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      render :json => user, status: 200
    end
  end

  def destroy
    logout
    render :json => {}, status: 200
  end

end