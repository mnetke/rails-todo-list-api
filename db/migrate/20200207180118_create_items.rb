# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.boolean :is_completed
      t.references :todo, foreign_key: true
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
