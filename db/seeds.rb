puts "seedデータを生成します"

puts "ユーザーデータのseedを作成"
User.create!(name: "developer", email: "developer@gmail.com", password: "developer")
User.create!(name: "test1", email: "test1@gmail.com", password: "testtest")
User.create!(name: "test2", email: "test2@gmail.com", password: "testtest")
User.create!(name: "test3", email: "test3@gmail.com", password: "testtest")
User.create!(name: "test4", email: "test4@gmail.com", password: "testtest")
User.create!(name: "test5", email: "test5@gmail.com", password: "testtest")

puts "メモのseedを作成"
Pokotarou.execute("./db/seed_data/memo.yml")

puts "ToDoのseedを作成"
Pokotarou.execute("./db/seed_data/todo.yml")

puts "seedデータの生成完了しました"
