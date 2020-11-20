class Api::V1::MemosController < ApplicationController
  before_action :authenticate_user

  def create
    begin
      user = Memo.create!(memo_params)
      message = "メモを作成しました。"
      render :json => message, status: 200
    rescue ActiveRecord::RecordInvalid
      message = "カテゴリーとメモは必ず入力してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  def memo_params
    params.require(:memo).permit(:user_id, :category, :content)
  end
end