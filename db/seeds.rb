require 'faker'
require 'open-uri'

User.find_or_create_by(email: "test@example.com") do |user|
    user.name = "ファン太郎"
    user.password = "password"
end

USER_IMAGES = Dir[Rails.root.join('app/assets/images/users/*.jpg')]

8.times do |i|
    puts "create test#{i + 1}@example.com"

    user = User.find_or_create_by(email: "test#{i + 1}@example.com") do |user|
        user.email = "test#{i + 1}@example.com"
        user.password = 'password'
        user.password_confirmation = 'password'
        user.name = Faker::Name.unique.name
    end

    user.profile_image.attach(
        io: File.open(USER_IMAGES[i % USER_IMAGES.size]), # インデックスを画像数で循環
        filename: File.basename(USER_IMAGES[i % USER_IMAGES.size])
      )

    fanclub = Fanclub.find_or_create_by(user_id: user.id) do |fanclub|
        fanclub.title = "#{user.name}のファンクラブ"
        fanclub.description = "Faker_ファンクラブの概要_" + Faker::Lorem.sentence(word_count: 40)
    end
end

Announcement.find_or_create_by(published_at: Time.zone.parse("2025.04.04")) do |announcement|
    announcement.title = "【お知らせ】メンテナンスについて：4/10(木) 00:00 ～ 06:00"
    announcement.description = \
        "この度、下記の日時でシステムメンテナンスを実施いたします。\n" \
        "ご迷惑をおかけいたしますが、ご理解とご協力のほどよろしくお願いいたします。\n\n" \
        "メンテナンス日時:\n" \
        "・2025年4月10日(木) 00:00 ～ 06:00\n\n" \
        "※メンテナンス中はサービスをご利用いただけません。"
    announcement.published_at = Time.zone.parse("2025.04.04")
end
