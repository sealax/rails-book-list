class AddOpenLibraryKeyToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :open_library_key, :string
  end
end
