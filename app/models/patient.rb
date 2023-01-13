class Patient < ApplicationRecord
  belongs_to :hospital 
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients

  def self.patients_over_age(age)
    # to_a is the only solution I could find to make this actually testable... It is a rails method, though.
    Patient.where("age > ?", age).order("name ASC").to_a
  end
end
