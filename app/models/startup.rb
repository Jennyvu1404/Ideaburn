class Startup < ActiveRecord::Base
  belongs_to :user

  def self.options
    [["- Select Founded Year -", nil]].concat((2010..2020).collect{|y| "#{y}" })
  end
end
