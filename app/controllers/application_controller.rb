class ApplicationController < ActionController::API
    before_action :authenticate_user!

    def check_admin
        render json: { error: 'Not authorized' }, status: :forbidden unless current_user.admin?
    end
end