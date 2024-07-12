class AddListReferenceToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_reference :documents, :list, null: false, foreign_key: true
  end
end
