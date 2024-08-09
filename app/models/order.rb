class Order < ApplicationRecord
  has_many_attached :images, dependent: :purge
  has_many_attached :models, dependent: :purge
  has_many :print_maker_orders, dependent: :destroy
  has_many :print_makers, through: :print_maker_orders
  has_many :order_invitations, dependent: :destroy
  has_many :order_filaments, dependent: :destroy
  has_many :filaments, through: :order_filaments
  belongs_to :orderable, polymorphic: true

  # after_create :send_order_invitations

  scope :available_orders, -> { where(status: ['approved', 'in_progress']) } 

  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected', in_progress: 'in_progress', completed: 'completed', canceled: 'canceled' }

  def complition_percentage
    (total_completed_quantity.to_f / quantity.to_f * 100).round(2).to_i
  end

  def reserved_percentage
    (total_reserved_quantity.to_f / quantity.to_f * 100).round(2).to_i
  end

  def total_completed_quantity
    print_maker_orders.sum(:completed_quantity)
  end

  def total_reserved_quantity
    print_maker_orders.sum(:reserved_quantity)
  end

  def status_value
    self.class.statuses.key(self.status)
  end

  def available_quantity
    quantity - total_completed_quantity
  end

  private

  # def send_order_invitations
  #   SendInvitation.perform_async(id)
  # end
end
