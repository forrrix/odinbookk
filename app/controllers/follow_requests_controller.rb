class FollowRequestsController < ApplicationController
  before_action :authenticate_user!

def create
  followee = User.find(params[:followee_id])
  @follow_request = current_user.follow_requests_as_follower.build(followee: followee, status: 'pending')

  if @follow_request.save
    redirect_to users_path, notice: 'Follow request sent.'
  else
    redirect_to users_path, alert: 'Unable to send follow request.'
  end
end


def destroy
  follow_request = FollowRequest.find_by(follower_id: current_user.id, followee_id: params[:id])
  if follow_request&.destroy
    redirect_to users_path, notice: 'Successfully unfollowed.'
  else
    redirect_to users_path, alert: 'Unable to unfollow.'
  end
end

end
