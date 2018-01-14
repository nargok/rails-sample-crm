class ModelPresenter
  attr_reader :object, :view_context

  # view_contextには呼び出し元のすべてのヘルパーメソッドが含まれる
  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end
end