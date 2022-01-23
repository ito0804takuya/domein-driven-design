class User
  attr_accessor :id, :name

  def initialize(name:)
    @name = name
    
    # 重複していないIDをDBから取得するためのコード
    # connection = Mysql2::Client.new(...)
    # id = ...

    @id = id
  end

  def rebuild_user(id:, name:)
    @id = id
    @name = name
  end
end

# ------------------------------------------------------

class UserFactoryInterface
  def create(name:)
    # サブクラスにcreateメソッドの実装を強制させるコード
  end

end

class UserFactory < UserFactoryInterface
  def create(name:)
    # 重複していないIDをDBから取得するためのコード
    # connection = Mysql2::Client.new(...)
    # id = ...
    User.new(id: id, name: name)
  end
end

class User
  attr_accessor :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  # 不要になった（コンストラクタが1つになった）
  # def rebuild_user(id:, name:)
  #   @id = id
  #   @name = name
  # end
end

class UserApplicationService
  def register
    user_factory = UserFactory.new
    user = user_factory.create(name: name)
    
    # 略 (UserRepositoryを使って保存)
  end
end

# ------------------------------------------------------

# 開発時の検証用にメモリ上で動かしたい場合、このファクトリに切り替えるだけでよい
class InMemoryUserFactory < UserFactoryInterface
  @@current_id = 0

  def create(name:)
    # テスト用にメモリ上で動かす
    current_id += 1
    User.new(id: current_id, name: name)
  end
end