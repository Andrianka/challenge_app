class UsersController < ApplicationController
  before_action :set_user, :only=> [:show]

  def show
  end


  def leaderboard
  	@users = User.page(params[:page]).per(10).order('email DESC')

  end

  private

    def set_user
      @user = User.find(params[:id])
    end
    

    
end
