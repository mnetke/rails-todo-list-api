class TodoSerializer < ActiveModel::Serializer
    attributes :id, :title, :created_by, :description, :created_at, :updated_at
  
    has_many :items
end