class RegistrationsController < Devise::RegistrationsController

 	def update
    @user = current_user
    updated = if github?(@user, params)
    	params[:user].delete(:current_password)
    	@user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def delete_avatar
  	current_user.avatar = nil
		current_user.save
		redirect_to edit_user_registration_path
  end

  private

  def github?(user, params)
    !user.uid.blank? || !user.provider.blank?
  end
end