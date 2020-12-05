class Api::V1::TodosController < ApplicationController
  before_action :authenticate_user

  def create
    
    # 期日がstringで送られるので、型を変更する
    params[:todo][:deadline] = DateTime.parse(params[:todo][:deadline])
    puts "=" * 100
    puts params
    puts "=" * 100
    begin
      Todo.create!(todo_params)
      message = "ToDoリストに追加しました。"
      render :json => message, status: 200
    rescue ActiveRecord::RecordInvalid => e
      puts "=" * 100
      puts e
      puts "=" * 100
      message = "タスクは必ず入力してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:user_id, :completed, :task, :deadline, :priority, :note)
  end
end