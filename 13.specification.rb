class Circle
  # 略

  # サークル内のユーザ数は30人が上限 (単純な評価)
  def isFull()
    count_members >= 30
  end
end

class CircleApplicationService
  # サークルにユーザを追加
  # (複雑な評価が混入されている)
  def join()
    circle_repository = CircleRepository.new
    circle = circle_repository.find(id)

    user_repository = UserRepository.new
    users = user_repository.find(circle.members)

    # サークル内のユーザ数は30人が上限なのだが、
    # プレミアムユーザというユーザ種別があり、
    # プレミアムユーザが10人所属しているサークルは、上限が50人
    premium_user_count = users.count(user.is_premium)
    circle_member_limit = premium_user_count > 10 ? 50 : 30

    raise StandardError.new("満員です") if circle.count_members >= circle_member_limit

    # 追加処理...(略)
  end
end

# -------------------------------------

class CircleFullSpecification
  def is_safisfied_by(circle)
    user_repository = UserRepository.new
    users = user_repository.find(circle.members)

    # サークル内のユーザ数は30人が上限なのだが、
    # プレミアムユーザというユーザ種別があり、
    # プレミアムユーザが10人所属しているサークルは、上限が50人
    premium_user_count = users.count(user.is_premium)
    circle_member_limit = premium_user_count > 10 ? 50 : 30

    circle.count_members >= circle_member_limit
  end
end

class CircleApplicationService
  # サークルにユーザを追加
  def join()
    circle_full_specification = CircleFullSpecification.new
    raise StandardError.new("満員です") if circle_full_specification.is_safisfied_by(circle)

    # 追加処理...(略)
  end
end

# -------------------------------------
# -------------------------------------
# 仕様とレポジトリを組み合わせる

class CircleApplicationService
  # オススメのサークルを取得
  def get_recommend_circle()
    circle_repository = CircleRepository.new
    # リポジトリに問い合わせる
    # ( つまり、[オススメ]に関する重要なルールはリポジトリに存在する )
    circle_repository.find_recommend_circle
  end
end

# -------------------------------------

class CircleApplicationService
  # オススメのサークルを取得
  def get_recommend_circle()
    circle_repository = CircleRepository.new
    circles = circle_repository.find_all

    circle_recommend_spec = CircleRecommendSpecification.new
    circles.select { |circle| circle_recommend_spec.is_safisfied_by(circle) }
  end
end

class CircleRecommendSpecification
  def is_safisfied_by(circle)
    circle.created_at > Date.today.months_ago(3) && circle.count_members > 10
  end
end