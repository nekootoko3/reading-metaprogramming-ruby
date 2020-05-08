# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること
class A1
  define_method("//".to_sym) { "//" }
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
class A2
  def initialize(suffixex)
    suffixex.each do |suffix|
      define_singleton_method("hoge_#{suffix}".to_sym) do |cnt|
        return dev_team unless cnt

        "hoge_#{suffix}" * cnt
      end
    end
  end

  def dev_team
    "SmartHR Dev Team"
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def my_attr_accessor(attribute)
      attr_reader attribute

      define_method "#{attribute}=" do |value|
        instance_variable_set("@#{attribute}", value)

        if [TrueClass, FalseClass].include?(value.class) && !respond_to?("#{attribute}?")
          define_singleton_method("#{attribute}?") { instance_variable_get("@#{attribute}") }
        else
          self.class.undef_method("#{attribute}?") if respond_to?("#{attribute}?")
        end
      end
    end
  end
end
