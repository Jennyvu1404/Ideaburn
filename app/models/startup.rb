class Startup < ActiveRecord::Base
  belongs_to :user
  has_many :teams
  accepts_nested_attributes_for :teams, reject_if: :all_blank, allow_destroy: true
  def self.options
    [["- Select Founded Year -", nil]].concat((2010..2020).collect{|y| "#{y}" })
  end

  def self.employee_strength_options
    [["- Select Employee Strength -", nil], ["0-9", 1], ["0-49", 2], ["0-99", 3], ["0-499", 4], ["0-999", 5]]
  end

  def self.designation_options
    [["- Select Designation -", nil], ["Founder", 1], ["CEO", 2], ["Co-Founder", 3], ["Founder/CEO", 4], ["Product Designer", 5], ["Marketing Exper", 6], ["Sales Expert", 7], ["CTO", 8], ["Software Engineer", 9], ["Media  Spokesperson", 10], ["Marketing", 11], ["Sales", 12], ["Othe", 13]]
  end

  def self.type_of_funding_options
    [["- Select Type of Funding -", nil], [" No Funding", 1], ["Bootstrap", 2], ["CrowdFunding", 3], [" Series A", 4], ["Series B", 5], ["Series C", 6], ["Series D", 7], ["Series E", 8], ["Bridge /Loan", 9], ["Friends/Family", 10], ["Others", 11]]
  end
end
