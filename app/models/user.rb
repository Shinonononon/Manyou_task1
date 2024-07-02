class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  #コールバック
  before_destroy :dont_delete_last_admin
  before_update :dont_edit_last_admin
  #バリデーション
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, confirmation: true
  validates :password,presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true
  before_validation { email.downcase! }
  has_secure_password

  def admin_status
    admin? ? I18n.t('users.admin_status.true') : I18n.t('users.admin_status.false')
  end

  def dont_delete_last_admin
    if User.where(admin: true).count == 1 && self.admin?
      errors.add(:base, '管理者が0人になるため削除できません')
      # flash[:notice] = t('common.admin_last_one')
      throw :abort
    end
  end

  def dont_edit_last_admin
    if User.where(admin: true).count == 1 && self.admin_was && !self.admin?
      errors.add(:base, '管理者が0人になるため権限を変更できません')
      # flash[:notice] = t('common.admin_last_one')
      throw :abort
    end
  end

end
