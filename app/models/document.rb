class Document < ApplicationRecord
  has_rich_text :content
  belongs_to :list
end
