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
    if current_user.entrepreneur?
      @user.build_entrepreneur if @user.entrepreneur.nil?
    elsif current_user.startup?
      @user.build_startup if @user.startup.nil?
    elsif current_user.investor?
      @user.build_investor if @user.investor.nil?
      @business_lines = @user.investor.business_line.present? ? @user.investor.business_line.gsub(/(\[\"|\"\])/, '').split('", "') : nil
      @investor_type = @user.investor.investor_type
    end
  end

  # PUT /resource
  def update
    super
    if current_user.present?
      if current_user.entrepreneur?
        entrepreneur_update_params = params[:user][:entrepreneur_attributes].permit(:first_name, :last_name, :age, :dob, :entrepreneur_type, :gender, :profession_type, :profession_company, :profession_skill, :profession_experience, :graduation, :university, :mobile, :address, :website, :email_second, :about, :inspire_quote, :linkedin, :skype )
        entrepreneur = Entrepreneur.new(entrepreneur_update_params)
        current_user.entrepreneur = entrepreneur
      elsif current_user.startup?
        startup_update_params = params[:user][:startup_attributes].permit(:name, :founded, :category, :website, :strength, :mission, :work, :register_under, :reg_company_name, :facebook, :twitter, :linkedin, :ios_app, :adroid_app, :window_app, :address_line_1, :address_line_2, :funding_type, :funding_amout, :funding_date, :funding_by_investor, :about, teams_attributes: [:id, :name, :designation, :joined_date, :email, :mobile, :linkedin, :skype, :_destroy])

        if current_user.startup.nil?
          current_user.startup = Startup.new(startup_update_params)
        elsif
          if current_user.startup.teams.nil?
            current_user.startup = Startup.new(startup_update_params)
          else
            current_user.startup.update_attributes(startup_update_params)
          end
        end
      elsif current_user.investor?
        investor_update_params = params[:user][:investor_attributes].permit(:name, :founded, :category, :website, :mission, :work, :register_under, :description, :team_name, :team_designation, :team_joined_date, :team_email_id, :team_mobile, :team_linkedin, :team_skype, :address_line_1, :address_line_2, :startup_name, :startup_logo, :funding_round, :funding_amount, :facebook, :twitter, :linkedin, :ios_app, :adroid_app, :windows_app, :investor_type, :portfolio_website, {:business_line => []}, :linkedin, :first_name, :last_name, :gender, :dob, :website_secondary, :skype)
        investor = Investor.new(investor_update_params)
        current_user.investor = investor
      end
      current_user.save!
    end
  end

  def edit_password
    @user = User.find(current_user.id)
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(update_pwd_params)
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit_password"
    end
  end

  def notification
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
      u.permit(:country, :city, :region, :photo, entrepreneur_attributes: [:first_name, :last_name])
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
    actions = ['edit', 'update', 'edit_password', 'update_password', 'notification']
    if actions.include? action_name
      "user"
    else
      "application"
    end
  end

  def startup_params
    params[:user][:startup].permit(:name, :founded, :category, :website, :strength, :mission, :work, :register_under)
  end

  def entrepreneur_params
    params[:user][:entrepreneur].permit(:first_name, :last_name, :age, :dob, :gender, :entrepreneur_type)
  end

  def investor_params
    params[:user][:investor].permit(:name, :founded, :category, :website, :mission, :work, :register_under)
  end

  def update_pwd_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
     edit_user_registration_path
  end

end
