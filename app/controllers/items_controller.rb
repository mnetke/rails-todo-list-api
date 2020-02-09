class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_item, only: %i[show update destroy]

  # POST /todos/:todo_id/items
  def create
    if @todo
      @todo&.items.create!(item_params)
      render json: { status: 200, message: 'Item created successfully', data: @todo.items.last }
    else
      render json: { status: 400, message: :unprocessable_entity, errors: ['todo not exist'] }
    end
  end

  # PUT /todos/:todo_id/items/:id
  def update
    todo = Todo.find_by(id: params[:todo_id], created_by: current_user.id)

    if todo && @item
      if @item&.update(item_params)
        render json: { status: 200, message: 'Item updated successfully', data: @item }
      else
        render json: { status: 400, message: :unprocessable_entity, errors: [@item.errors] }
      end
    else
      render json: { status: 400, message: 'This item not belongs this User/Todo' }
    end
  end

  # DELETE /todos/:todo_id/items/:id
  def destroy
    todo = Todo.find_by(id: params[:todo_id], created_by: current_user.id)
    if todo && @item
      @item.destroy
      render json: { status: 201, message: 'Todo item deleted successfully' }
    else
      render json: { status: 400, errors: ['You are not allowed to delete this/todo item not exist'] }, status: 400
    end
  end

  private

  attr_reader :current_user

  def item_params
    params.permit(:title, :is_completed)
  end

  def set_todo
    @todo = Todo.find_by(id: params[:todo_id])
  end

  def set_todo_item
    @item = @todo.items.find_by(id: params[:id]) if @todo
  end
end
