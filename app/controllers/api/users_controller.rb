class Api::UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    #api/users/id is the url:
    user = User.find(params[:id])
    user.name = params[:name]
    user.email = params[:email]
    user.gamertag = params[:gamertag]
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    #gets back string of whatever bucket is named
    s3_bucket = ENV['BUCKET']
    file = params[:file]


    begin
      #my-s3-bucket/avatars/1.jpg
      ext = File.extname(file.tempfile)
      obj = s3.bucket(s3_bucket).object("avatars/#{user.id}#{ext}")
      obj.upload_file(file.template, acl: 'public-read' )
      #acl is access type,
      user.image = obj.public_url
      if user.save
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: 422
      end
    rescue => e
      render json: { errors: e }, status: 422
    end
  end
end
