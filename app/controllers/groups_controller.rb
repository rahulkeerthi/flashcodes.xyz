class GroupsController < ApplicationController
  include FlashHelper

  def show
    @group = Group.find(params[:id])
    @membership = current_user.group_memberships.select { |membership| membership.group.language == @group.language }.first
    @group_points = group_points
    @progress = ((@group_points - progress_points(@group)).to_f/(@group.target_points - progress_points(@group)))*550
    @members = @group.group_memberships.reject { |membership| membership.user == current_user }
  end
end


private

def group_points
  @group.group_memberships.calculate(:sum, :points)
end

def progress_points(group)
  BASE_LEVEL_PTS * (@group.level - 1)
end
