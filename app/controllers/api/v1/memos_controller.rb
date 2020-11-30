class Api::V1::MemosController < ApplicationController
  before_action :authenticate_user

  def index
    @current_user = current_user
    info = Memo.where(user_id: current_user.id)
    render :json => info, status: 200
  end

  def create
    begin
      Memo.create!(memo_params)
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

  def update
    begin
      memo = Memo.find_by(id: params[:memo][:id])
      memo.update!(memo_params)
      message = "メモを編集しました。"
      render :json => message, status: 200
    rescue ActiveRecord::RecordInvalid
      message = "カテゴリーとメモは必ず入力してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  def destroy
    begin
      memo = Memo.find(params[:id])
      memo.destroy!
      message = "メモを削除しました。"
      render :json => message, status: 200
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:user_id, :category, :content)
  end
end