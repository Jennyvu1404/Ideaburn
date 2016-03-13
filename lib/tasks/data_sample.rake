namespace :data do
  desc 'Create sample data'
  task sample: :environment do
    user_sample
  end

  def user_sample
    User.where.not(user_type: 1).delete_all

    puts 'Creating users...'
    20.times do |index|
      entrepreneur = User.create!({
        username: "entrepreneur#{index}",
        user_type: :entrepreneur,
        email: "entrepreneur#{index}@ideaburn.com",
        password: '12345678',
        remote_photo_url: Faker::Avatar.image
        })
      10.times do
        idea = entrepreneur.ideas.build({
          title: Faker::Lorem.sentence,
          category_id: Category.all.sample.id,
          description: Faker::Lorem.paragraph
          })
      end
      idea.save

      startup = User.create!({
        username: "startup#{index}",
        user_type: :startup,
        email: "startup#{index}@ideaburn.com",
        password: '12345678',
        remote_photo_url: Faker::Avatar.image
        })
      investor = User.create!({
        username: "investor#{index}",
        user_type: :investor,
        email: "investor#{index}@ideaburn.com",
        password: '12345678',
        remote_photo_url: Faker::Avatar.image
        })
    end

    puts 'Done! Created sample users'
  end
end