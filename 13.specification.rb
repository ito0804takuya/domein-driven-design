class Circle
  # 略

  # サークル内のユーザ数は30人が上限 (単純な評価)
  def isFull()
    count_members >= 30
  end
end

class CircleApplicationService
  # 略

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