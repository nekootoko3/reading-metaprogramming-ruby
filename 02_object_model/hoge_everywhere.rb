# 次に挙げるクラスのいかなるインスタンスからも、hogeメソッドが呼び出せる
# それらのhogeメソッドは、全て"hoge"という文字列を返す
# - String
# - Integer
# - Numeric
# - Class
# - Hash
# - TrueClass

#[String, Integer, Numeric, Class, Hash, TrueClass].each do |klass|
#  klass.class_eval("def hoge; 'hoge' end")
#end

module Kernel
  def hoge
    "hoge"
  end
end
