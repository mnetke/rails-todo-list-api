# frozen_string_literal: true

require 'will_paginate/array'
class TodosController < ApplicationController
  include ExceptionHandler
  # GET /todos
  def index
    todos = current_user.todos.paginate(page: params[:page], per_page: per_page)
    todo_list = if params[:is_completed].present?
                  ::Todo.load_todo_list(todos, completed?)
                else
                  todos.collect do |td|
                    {
                      id: td.id,
                      title: td.title,
                      description: td&.description,
                      created_by: td.created_by,
                      items: td.items
                    }
                  end
                end
    if todos
      render json: { status: 200, message: 'Todo list', data: todo_list }
    else
      render json: { errors: ['Todos record not found for this User'] }, status: 400
    end
  end

  # GET /todos/1
  def show
    todo = Todo.find_by(id: params[:id], created_by: current_user.id)

    if todo
      todo_json = todo.as_json(only: %i[id title description])
      todo_json[:items] = todo.items

      render json: { status: 200, message: 'Todo result', data: todo_json }
    else
      render json: { errors: ['Todo record not found for this User'] }, status: 400
    end
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created, location: todo
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    todo = Todo.find_by(id: params[:id], created_by: current_user.id)

    if todo
      if todo&.update(todo_update_params)
        render json: todo
      else
        render json: todo.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Todo record not found for this User'] }, status: 400
    end
  end

  # DELETE /todos/1
  def destroy
    todo = Todo.find_by(id: params[:id], created_by: current_user.id)
    if todo
      todo.destroy
      render json: { success: ['Todo deleted successfully'] }, status: 201
    else
      render json: { errors: ['You are not allowed to delete this/ todo not exist'] }, status: 400
    end
  end

  private

  attr_reader :current_user

  # Only allow a trusted parameter "white list" through.
  def todo_params
    params.require(:todo).permit(:title, :description, :created_by)
  end

  def todo_update_params
    params.require(:todo).permit(:title, :description)
  end

  def completed?
    params[:is_completed] == 'true'
  end
end
