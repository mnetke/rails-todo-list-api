# frozen_string_literal: true

class Todo < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :created_by
  validates :title, presence: true, length: { minimum: 120 }
  validates :description, length: { minimum: 160 }, if: -> { description.present? }

  # It returns collection of todos with theire items.
  # params todos[Array], is_done[boolean].
  def self.load_todo_list(todos, is_done)
    todos = todos.collect do |td|
      if is_done == true
        if !completed_todo_items(td.items).empty?
          {
            id: td.id,
            title: td.title,
            description: td&.description,
            created_by: td.created_by,
            items: completed_todo_items(td.items)
          }
        else
          next
        end
      else
        if !not_completed_todo_items(td.items).empty?
          {
            id: td.id,
            title: td.title,
            description: td&.description,
            created_by: td.created_by,
            items: not_completed_todo_items(td.items)
          }
        else
          next
        end
      end
    end
    todos.reject!(&:nil?)
  end

  # it returns only items which are completed.
  def self.completed_todo_items(items)
    items.select { |item| item.is_completed == true }
  end

  # it returns only items which are not completed yet.
  def self.not_completed_todo_items(items)
    items.select { |item| item.is_completed == false }
  end
end
