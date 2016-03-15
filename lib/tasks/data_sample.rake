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
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/avatar_sample.png').open
        })
      10.times do
        idea = entrepreneur.ideas.build({
          title: Faker::Lorem.sentence,
          category_id: Category.all.sample.id,
          description: Faker::Lorem.paragraph(50),
          views: Faker::Number.number(2)
          })
        idea.save
      end

      startup = User.create!({
        username: "startup#{index}",
        user_type: :startup,
        email: "startup#{index}@ideaburn.com",
        password: '12345678',
        photo: Rails.root.join('app/assets/images/avatar_sample.png').open
        })
      investor = User.create!({
        username: "investor#{index}",
        user_type: :investor,
        email: "investor#{index}@ideaburn.com",
        password: '12345678',
        photo: Rails.root.join('app/assets/images/avatar_sample.png').open
        })
    end

    puts 'Done! Created sample users'
  end
end