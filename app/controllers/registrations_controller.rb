class RegistrationsController < Devise::RegistrationsController
 
  def delete_avatar
  	current_user.avatar = nil
		current_user.save
		redirect_to edit_user_registration_path
  end
end