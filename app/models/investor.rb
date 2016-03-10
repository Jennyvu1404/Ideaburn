class Investor < ActiveRecord::Base
  belongs_to :user

  def self.year_options
    [["- Select Founded Year -", nil]].concat((1980..Time.now.year).collect{|y| "#{y}" })
  end
end
