# Local preview only: GitHub Pages pins Liquid 4.0.3, which calls
# Object#tainted?/#taint. Those were removed in Ruby 3.2+. Restore no-ops.
class Object
  def tainted? = false unless method_defined?(:tainted?)
  def taint = self unless method_defined?(:taint)
  def untaint = self unless method_defined?(:untaint)
end
