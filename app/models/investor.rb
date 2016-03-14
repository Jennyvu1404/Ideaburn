class Investor < ActiveRecord::Base
  belongs_to :user

  mount_uploader :startup_logo, InvestorUploader

  def self.year_options
    [["- Select Founded Year -", nil]].concat((2010..2016).collect{|y| "#{y}" })
  end

  def self.designation_options
    [["- Select Designation -", nil], ["Director", 1], ["Partner", 2], ["Investment analyst", 3], ["Investment advisor", 4], ["Finance professional", 5], ["Others", 6]]
  end

  def self.type_of_funding_options
    [["- Select Type of Funding -", nil], [" No Funding", 1], ["Bootstrap", 2], ["CrowdFunding", 3], [" Series A", 4], ["Series B", 5], ["Series C", 6], ["Series D", 7], ["Series E", 8], ["Bridge /Loan", 9], ["Friends/Family", 10], ["Others", 11]]
  end

  def self.type_options
    [["- Select Invester Type -", nil], ["Individual", 1], ["Angel Invester", 2], ["Accerlator ", 3], ["Angel Group", 4], ["Government Organizations", 5], ["Non-Profit Organisation ", 6], ["Startup Incubator", 7], ["Venture Capital", 8], ["Others", 9]]
  end

end
