namespace :users do
  desc "Remove all uploaded profile pictures"
  task remove_profile_pictures: :environment do
    User.find_each do |user|
      if user.photo.attached?
        user.photo.purge
      end
    end
    puts "All profile pictures have been removed."
  end
end
