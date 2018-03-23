class Api::TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.tags
  end

  def destroy
    Tagging.find_by(
      user_id: current_user.id,
      tag_id: params[:id]
    ).destroy
  end

  def create
    name = params[:tag][:name]
    tag = Tag.find_or_create_by(name: name)
    if !current_user.tags.find_by(id: tag.id)
      Tagging.create(
        user_id: current_user.id,
        tag_id: tag.id
      )
      render json: tag
    end
  end
end
