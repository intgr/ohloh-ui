class Account < ActiveRecord::Base
  DEFAULT_LEVEL = 0
  ADMIN_LEVEL   = 10
  DISABLE_LEVEL = -10
  SPAMMER_LEVEL = -20

  has_many :api_keys

  def admin?
    level == ADMIN_LEVEL
  end

  def disabled?
    level < DEFAULT_LEVEL
  end

  def activated?
    activated_at != nil
  end
end