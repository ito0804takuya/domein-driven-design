class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def exists?(user:)
    # 重複を確認するコード
  end
end

user = User.new(name: '山田')
is_duplicate = user.exists?(user) # 自分自身に問い合わせている

# ---------------------------------------------------------------

class User
  attr_accessor :name

  def initialize(name:)
    @name = name
  end
end

class UserService
  def exists?(user:)
    # 重複を確認するコード
  end

  # このメソッドはUserクラスにあるべき
  def change_user_name(name:)
    # ユーザの名前を変更するコード
  end
end

user = User.new(name: '山田')
user_service = UserService.new
is_duplicate = user_service.exists?(user) # UserServiceに問い合わせる

# ---------------------------------------------------------------
# ---------------------------------------------------------------

# 物流拠点
class PhysicalDistributionBase
  # 出庫
  def ship(baggage)
    # (略)
  end

  # 入庫
  def recieve(baggage)
    # (略)
  end

  # 輸送 (= 出庫 + 入庫)
  def transport(to, baggage)
    self.ship(baggage)
    to.recieve(baggage)
  end
  # → 出荷元の物流拠点が、出庫だけでなく、出荷先の物流拠点の入庫処理まで行うのは不自然。
end

# ---------------------------------------------------------------

# 物流拠点
class PhysicalDistributionBase
  # 出庫
  def ship(baggage)
    # (略)
  end

  # 入庫
  def recieve(baggage)
    # (略)
  end
end

# ドメインサービス
class TransportService
  # 輸送 (= 出庫 + 入庫)
  def transport(from, to, baggage)
    from.ship(baggage)
    to.recieve(baggage)
  end
end
# → サービスが、出荷元と出荷先の物流拠点のやり取りを代理して処理してくれている。