# ドメインオブジェクト
class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def change_name(name:)
    @name = name
  end
end

# ドメインサービス
class UserService
  def exists?(user:)
    user_repository = UserRepository.new
    user_repository.find(user.name)
  end
end

# リポジトリ
class UserRepository
  def save(object)
    # 保存処理
  end

  def find(name)
    # 重複確認処理
  end
end

# アプリケーションサービス
class UserApplicationService
  def register(name:)
    user = User.new(name: name)
    user_repository = UserRepository.new
    user_repository.save(user)
  end
end

# -----------------------------------------
# ドメインオブジェクト
class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end
end

# リポジトリ
class UserRepository
  def save(object)
    # 保存処理
  end
end

# アプリケーションサービス
class UserApplicationService
  def register(name:)
    user = User.new(name: name)
    user_repository = UserRepository.new
    user_repository.save(user)
  end
end