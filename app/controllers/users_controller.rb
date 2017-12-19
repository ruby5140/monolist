class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  private
  
  #Strong Parameter
  def user_params
    #Userモデルのフォームから得られるデータに関するものだと明示し、必要なカラムを許可
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
