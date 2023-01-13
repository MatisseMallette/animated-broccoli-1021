class Patient < ApplicationRecord
  belongs_to :hospital 
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.patients_over_age(age)
    Patient.select('*').where("age > ?", age).order("name ASC")
  end
end
