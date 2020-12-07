class Api::V1::TodosController < ApplicationController
  before_action :authenticate_user

  def index
    @current_user = current_user
    info = Todo.where(user_id: current_user.id)
    render :json => info, status: 200
  end

  def create
    # 期日がstringで送られるので、型を変更する
    params[:todo][:deadline] = DateTime.parse(params[:todo][:deadline])
    begin
      Todo.create!(todo_params)
      message = "ToDoリストに追加しました。"
      render :json => message, status: 200
    rescue ActiveRecord::RecordInvalid => e
      message = "タスクは必ず入力してください"
      render :json => message, status: 422
    rescue
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  def update
    begin
      todo = Todo.find_by(id: params[:todo][:id])
      todo.update!(todo_params)
      message = "ToDoを編集しました。"
      render :json => message, status: 200
    rescue ActiveRecord::RecordInvalid
      message = "タスクは必ず入力してください"
      render :json => message, status: 422
    rescue => e
      message = "原因不明のエラーが発生しました。開発者にお問い合わせください。"
      render :json => message, status: 500
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:user_id, :completed, :task, :deadline, :priority, :note)
  end
end