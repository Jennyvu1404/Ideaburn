class Entrepreneur < ActiveRecord::Base
  belongs_to :user

  def self.year_options
    [["- Select Age -", nil]].concat((1900..2009).collect{|y| "#{y}" })
  end
end
