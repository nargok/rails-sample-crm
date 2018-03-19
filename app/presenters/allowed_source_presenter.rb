class AllowedSourcePresenter < ModelPresenter
  delegate :octet1, :octet2, :octet3, :octet4, :wildcard?, to: :object

  def ip_address
    # IPアドレス末尾の決定：wildcardがtrueなら*, falseならoctet4が入る
    [ octet1, octet2, octet3, wildcard? ? '*': octet4].join('.')
  end
end