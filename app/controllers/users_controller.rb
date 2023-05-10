class UsersController < ApplicationController
  before_action only: %i[ edit update destroy ]

  # GET /users or /users.json
  def index
    @user = User.find(session[:user_id]) if session[:user_id].present?
  end

  # GET /users/1 or /users/1.json
  def show
    render :index
  end

  def search
    @search_term = params[:busca][:name]
    @users = User.where('name LIKE ? AND activated = true', "#{@search_term}%")

    render :index
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def activate
    @user = User.find_by(activation_code: params[:activation_code])

    if @user.present?
      @user.update(activated: true)
      redirect_to root_path, notice: I18n.t('users.notice.activate_success')
    else
      flash.now[:alert] = I18n.t('users.notice.activate_error')
      render :activate
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      send_activation_code(@user)
      SendSmsService.new(@user).call

      render :activate
    else
      render :edit
      flash[:error] = 'As senhas não conferem'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def send_activation_code(user)
      code = SecureRandom.hex(3)
      @user.update(activation_code: code)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :telephone, :email, :biography, :birthdate, :password, :password_confirmation)
    end
end
