class DoctorPatientsController < ApplicationController 
  def destroy 
    doctor = Doctor.find(DoctorPatient.find(doctor_patient_params[:id]).doctor_id)
    DoctorPatient.destroy(doctor_patient_params[:id])
    redirect_to "/doctors/#{doctor.id}"
  end

private 
  def doctor_patient_params
    params.require(:doctor_patient).permit(:id)
  end
end