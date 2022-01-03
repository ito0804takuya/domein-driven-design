fullname = "山田 太郎"
lastname = fullname.split(' ')[0] # 姓
p lastname # 山田

fullname = "john smith"
# 姓
lastname = fullname.split(' ')[0]
p lastname # 姓はsmithなのに、johnと出力されてしまう

# ---------------------------------------------------------------

class Fullname
  attr_accessor :firstname, :lastname

  def initialize(firstname:, lastname:)
    @firstname, @lastname = firstname, lastname
  end
end

fullname = Fullname.new(firstname: "太郎", lastname: "山田")
p fullname.lastname # 山田

fullname = Fullname.new(firstname: "john", lastname: "smith")
p fullname.lastname # smith

# ---------------------------------------------------------------
# ---------------------------------------------------------------

class User
  attr_accessor :id

  def self.create_user(name)
    user = User.new()
    user.id = name # 正しい代入?
    user
  end
end

user = User.create_user("田中")
p user