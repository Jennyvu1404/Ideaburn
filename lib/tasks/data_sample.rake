namespace :data do
  desc 'Create sample data'
  task sample: :environment do
    user_sample
  end

  def user_sample
    User.where.not(user_type: 1).destroy_all

    puts 'Creating users...'
    20.times do |index|
      user1 = User.create!({
        username: "entrepreneur#{index}",
        user_type: :entrepreneur,
        email: "entrepreneur#{index}@ideaburn.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/entrepreneur.png').open,
        })
      user1.entrepreneur = Entrepreneur.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
        })
      10.times do
        idea = user1.ideas.build({
          title: Faker::Lorem.sentence,
          category_id: Category.all.sample.id,
          description: Faker::Lorem.paragraph(50),
          views: Faker::Number.number(2)
          })
        idea.save
      end

      user2 = User.create!({
        username: "startup#{index}",
        user_type: :startup,
        email: "startup#{index}@ideaburn.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/startup.png').open
        })
      user2.startup = Startup.new({
        name: Faker::Name.name
        })

      user3 = User.create!({
        username: "investor#{index}",
        user_type: :investor,
        email: "investor#{index}@ideaburn.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/investor.jpg').open
        })
      user3.investor = Investor.new({
        name: Faker::Name.name
        })
    end

    puts 'Done! Created sample users'
  end
end