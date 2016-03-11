class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  layout :layout_by_action

  # GET /resource/sign_up
   def new
     super
     @user = User.new
   end

  # POST /resource
  #def create
  #  super
  #end

  # GET /resource/edit
  def edit
    @user = User.find(current_user.id)
    @user.build_entrepreneur if @user.entrepreneur.nil?
   end

  # PUT /resource
  def update
    super
    if current_user.present?
      if current_user.entrepreneur?
        entrepreneur_update_params = params[:user][:entrepreneur_attributes].permit(:first_name, :last_name, :age, :dob, :entrepreneur_type, :gender, :profession_type, :profession_company, :profession_skill, :profession_experience, :graduation, :university, :mobile, :address, :website, :email_second, :about, :inspire_quote, :linkedin )
        entrepreneur = Entrepreneur.new(entrepreneur_update_params)
        current_user.entrepreneur = entrepreneur
      end
      current_user.save!
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.for(:sign_up) << [:user_type, :username]
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    #devise_parameter_sanitizer.for(:account_update) << [:county, :city, :home_town]
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:country, :city, :home_town, :photo, entrepreneur_attributes: [:first_name, :last_name])
    end
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
   super(resource)
   edit_user_registration_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def layout_by_action
    action_name == "edit" || action_name == "update" ?  "user" : "application"
  end

  def startup_params
    params[:user][:startup].permit(:name, :founded, :business_category, :website, :strength, :mission, :work, :register_under)
  end

  def entrepreneur_params
    params[:user][:entrepreneur].permit(:first_name, :last_name, :age, :dob, :gender, :entrepreneur_type)
  end

  def investor_params
    params[:user][:investor].permit(:name, :founded, :category, :website, :mission, :work, :register_under)
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
     edit_user_registration_path
  end
end
