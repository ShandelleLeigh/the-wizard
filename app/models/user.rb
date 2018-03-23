class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :taggings
  has_many :tags, through: :taggings

  def self.like_users(id, tags)
    tags = tags.any? ? tags : [' ']
    select('DISTINCT(users.id), users.name, image')
    .joins('INNER JOIN taggings ts
              ON ts.user_id = users.id
            INNER JOIN tags t
              ON t.id = ts.tag_id')
    .where('t.name in (?) AND users.id <> ?', tags, id)
  end

  def self.by_tag(id, tag)
    select('DISTINCT(users.id), users.name, image')
    .joins('INNER JOIN taggings ts
              ON ts.user_id = users.id
            INNER JOIN tags t
              ON t.id = ts.tag_id')
    .where('t.name = (?) AND users.id <> ?', tag, id)
  end
end
