module Api::V1
  class UsersController < BaseController
    def index
      json_response(User.all)
    end
  end
end
