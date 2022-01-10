# bundle exec ruby 5.repository.rb
# でないと実行できない。
# （単に　ruby 5.repository.rb　ではエラーになる。）

require 'mysql2'

class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end
end

class UserService
  def exists?(user:)
    connection = Mysql2::Client.new(host: '127.0.0.1', username: '', password: '', encoding: 'utf8',
      database: 'sample')
    sql = "SELECT * FROM users WHERE name = #{user.name}"
    result = connection.query(sql)
    connection.close

    # 以下、重複を確認するコード (略)
  end
end

# main
user = User.new(name: "山田")
user_service = UserService.new

raise StandardError.new("#{user.name}は既に存在しています。") if user_service.exists?(user: user)

# 以降、DBへの保存処理
connection = Mysql2::Client.new(host: '127.0.0.1', username: '', password: '', encoding: 'utf8',
                                database: 'sample')
sql = "INSERT INTO users (name) VALUES (#{name});"
connection.query(sql)
connection.close

# ---------------------------------------------------------------

require 'mysql2'

class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end
end

class UserService
  def exists?(user:)
    user_repository = UserRepository.new
    user_repository.find(user.name)
  end
end

class UserRepository
  def save(object)
    # 保存処理
  end

  def find(name)
    # 重複確認処理
  end
end

# main
user = User.new(name: "山田")
user_service = UserService.new

raise StandardError.new("#{user.name}は既に存在しています。") if user_service.exists?(user: user)

# 以降、DBへの保存処理
user_repository = UserRepository.new
user_repository.save(user)
