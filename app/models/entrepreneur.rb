class Entrepreneur < ActiveRecord::Base
  belongs_to :user
  GRADUATION = [["- Select Graduation -", nil], ["UnderGraduate", 1], ["PostGraduate", 2], ["Phd", 3], ["Others", 4]]

  def self.year_options
    [["- Select Age -", nil]].concat((1900..2009).collect{|y| "#{y}" })
  end

  def self.gender_options
    [["- Select Gender -", nil], ["Male", true], ["Female", false]]
  end

  def self.graduation_options
    GRADUATION
  end

  def self.pro_skill_options
    [["- Select Skill -", nil]].concat(ProfessionalSkill.all.collect {|p| [ p.name, p.id ] })
  end

  def self.pro_exp_options
    [["- Startup Experience -", nil]].concat((0..9).collect{|y| ["#{y} years", y] })
  end

  def self.pro_type_options
    [["- Profession Type -", nil]].concat(EntrepreneurType.all.collect {|p| [ p.name, p.id ] })
  end

  def pro_type_name
    EntrepreneurType.find(self.profession_type).name rescue nil
  end

  def pro_skill_name
    ProfessionalSkill.find(self.profession_skill).name rescue nil
  end

  def graduation_name
    GRADUATION[self.graduation.to_i].first
  end

  def linkedin_name
    self.linkedin.split('/').last unless self.linkedin.nil?
  end

end
