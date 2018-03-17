class AllowedSource < ActiveRecord::Base
  validates :octet1, :octet2, :octet3, :octet4, presence: true,
            numericality: { only_integer: true, allow_bank: true },
            inclusion: { in: 0..255, allow_blank: true }
  # octed1 ~ octet4までの組み合わせが一意であること
  validates :octet4,
            uniqueness: { scope: [ :octet1, :octet2, :octet3 ], allow_blank: true }

  # ipアドレスを文字列でも指定できるようにする
  def ip_address=(ip_address)
    octets = ip_address.split('.')
    self.octet1 = octets[0]
    self.octet2 = octets[1]
    self.octet3 = octets[2]
    if octets[3] == '*'
      self.octet4 = 0
      self.wildcard = true
    else
      self.octet4 = octets[3]
    end
  end

  class << self
    def include?(namespace, ip_address)
      # IPアドレス機能制限を無効にしている場合は必ずtrueを返す
      !Rails.application.config.baukis[:restrict_ip_addresses] ||
          where(namespace: namespace).where(options_for(ip_address)).exists?
    end

    private
    def options_for(ip_address)
      octets = ip_address.split(".")
      condition = %Q{
        octet1 = ? AND octet2 = ? AND octet3 = ?
         AND ((octet4 = ? AND wildcard = ?) OR wildcard = ?)}
      # *octetsは配列の展開 → octets[0], octets[1], octets[2], octets[3]となる
      [ condition, *octets, false, true ]
    end

      # octets = ip_address.split(".")
      # condition = %Q{
      #   octet1 = ? AND octet2 = ? AND octet3 = ?
      #   AND ((octet4 = ? AND wildcard = ?) OR wildcard = ?)}
      # *octetsは配列の展開 → octets[0], octets[1], octets[2], octets[3]となる
      # opts = [ condition, *octets, false, true ]
      # where(namespace: namespace).where(opts).exists?
  end
end
