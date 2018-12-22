class AddIndexToSnsCredentialsProviderUid < ActiveRecord::Migration[5.2]
  def change
    add_index :sns_credentials, [:provider, :uid], unique: true
  end
end
