# class Api::UsersController < ApplicationController
#   before_action :authenticate_user!
#
#   def like
#     tags = currentMessage.tags.map { |tag| tag.name }
#     @users = Users.like_users(current_user.id, tags)
#     render 'user.jbuilder'
#   end
#
#
#   def update
#     #api/users/id is the url:
#     user = User.find(params[:id])
#     user.name = params[:name]
#     user.email = params[:email]
#     user.gamertag = params[:gamertag]
#     s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
#     #gets back string of whatever bucket is named
#     s3_bucket = ENV['BUCKET']
#     file = params[:file]
#
#
#     begin
#       #my-s3-bucket/avatars/1.jpg
#       ext = File.extname(file.tempfile)
#       obj = s3.bucket(s3_bucket).object("avatars/#{user.id}#{ext}")
#       obj.upload_file(file.template, acl: 'public-read' )
#       #acl is access type,
#       user.image = obj.public_url
#       if user.save
#         render json: user
#       else
#         render json: { errors: user.errors.full_messages }, status: 422
#       end
#     rescue => e
#       render json: { errors: e }, status: 422
#     end
#   end
# end
class Api::UsersController < Api::ApiController

  def tag
    @users = User
      .page(params[:page]).by_tag(current_user.id, params[:tag])
    @total_pages = @ users.total_pages
    render 'user.jbuilder'
  end

  def like
    tags = current_user.tags.map { |tag| tag.name }
    @users = User
      .page(params[:page])
      .like_users(current_user.id, tags)
    @total_pages = @users.total_pages
    render 'user.jbuilder'
  end

    def update
        user = User.find(params[:id])
        user.name = params[:name]
        user.email = params[:email]
        user.gamertag = params[:gamertag]
        s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
        s3_bucket = ENV['BUCKET']
        file = params[:file]
        begin
      if !file.blank?
              ext = File.extname(file.tempfile)
              obj = s3.bucket(s3_bucket).object("avatars/#{user.id}#{ext}")
              obj.upload_file(file.tempfile, acl: 'public-read')
              user.image = obj.public_url
      end

            if user.save
                render json: user
            else
                handle_error(user)
            end
        rescue => e
            render json: { errors: e }, status: 422
        end
    end

end
