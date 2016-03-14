class Entrepreneur < ActiveRecord::Base
  belongs_to :user

  def self.year_options
    [["- Select Age -", nil]].concat((1900..2009).collect{|y| "#{y}" })
  end

  def self.gender_options
    [["- Select Gender -", nil], ["Male", true], ["Female", false]]
  end

  def self.graduation_options
    [["- Select Graduation -", nil], ["UnderGraduate", 1], ["PostGraduate", 2], ["Phd", 3], ["Others", 4]]
  end

  def self.pro_skill_options
    [["- Select Skill -", nil]].concat(ProfessionalSkill.all.collect {|p| [ p.name, p.id ] })
  end

  def self.pro_exp_options
    [["- Startup Experience -", nil]].concat((0..9).collect{|y| "#{y} years" })
  end

  def self.pro_type_options
    [["- Profession Type -", nil]].concat(EntrepreneurType.all.collect {|p| [ p.name, p.id ] })
  end
end
