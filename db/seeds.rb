contra = Tag.create(name: 'contra')
marblemadness = Tag.create(name: 'marblemadness')
excitebike = Tag.create(name: 'excitebike')
tags = [contra, marblemadness, excitebike]

100.times do 
  name = Faker::Name.name
  u = User.create(
    name: name,
    email: Faker::Internet.unique.email,
    password: 'password'
  )
  tags.each do |tag|
    Tagging.create(user_id: u.id, tag_id: tag.id)
  end
end
