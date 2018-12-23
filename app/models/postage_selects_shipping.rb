class PostageSelectsShipping < ApplicationRecord
  belongs_to :postage_select
  belongs_to :shipping
end
