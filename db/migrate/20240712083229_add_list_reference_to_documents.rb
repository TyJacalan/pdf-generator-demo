class AddListReferenceToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_reference :documents, :list, null: true, foreign_key: true
  end
end
