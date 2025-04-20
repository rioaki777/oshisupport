require 'faker'
require 'open-uri'

# 14枚の画像URLを配列に格納
image_urls = 14.times.map do |index|
    Faker::Avatar.image(slug: "random_image_#{index + 1}", size: "150x150", format: "png")
end

8.times do |i|
    user = User.find_by(email: "test#{i + 1}@example.com")
    fanclub = Fanclub.find_by(user_id: user.id)

    7.times do |j|
        puts "create content_#{j + 1}"

        # 画像URLをランダムに選択
        random_image_url = image_urls.sample

        content = fanclub.contents.find_or_create_by(title: Faker::Book.title) do |content|
            content.description = "Faker_投稿の概要_" + Faker::Lorem.sentence(word_count: 30)
            content.image.attach(
                io: URI.open(random_image_url),
                filename: "content_image_#{i + 1}_#{j + 1}.png"
            )
        end
    end
end
  