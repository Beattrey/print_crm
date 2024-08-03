class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :worker, dependent: :destroy
  has_one :customer, through: :worker
  has_one :print_maker, through: :worker
  has_one :print_maker_admin, through: :worker
  has_one :super_admin, through: :worker

  after_create :create_worker_for_user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  private

  def create_worker_for_user
    # Создаем Worker, если он еще не существует
    create_worker(name: name) unless worker
  end
end
