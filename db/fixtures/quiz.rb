require 'csv'

users = User.seed do |s|
  s.id = 1
  s.email = 'test@example.com'
  s.password = 'password'
end

CSV.foreach('db/fixtures/anime.csv', headers: true) do |row|
  Anime.seed do |s|
    s.id = row['id']
    s.title = row['title']
  end
end

CSV.foreach('db/fixtures/quiz.csv', headers: true) do |row|
  Quiz.seed do |s|
    s.id = row['id']
    s.question = row['question']
    s.anime_id = row['anime_id']
    s.user = users.sample
    s.status = :published
    s.published_at = Time.zone.now
  end
end

CSV.foreach('db/fixtures/choice.csv', headers: true) do |row|
  Choice.seed do |s|
    s.id = row['id']
    s.body = row['body']
    s.is_correct = !row['is_correct'].nil?
    s.quiz_id = row['quiz_id']
  end
end
