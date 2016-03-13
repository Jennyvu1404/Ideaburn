class Category < StaticModel::Base
  has_many :ideas
  has_many :users
  set_data_file "#{Rails.root}/db/statics/category.yml"
end
