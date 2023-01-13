class Patient < ApplicationRecord
  belongs_to :hospital 
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
end
