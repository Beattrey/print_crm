class Order < ApplicationRecord
  has_many_attached :images, dependent: :purge
  has_many_attached :models, dependent: :purge
  has_many :print_maker_orders, dependent: :destroy
  has_many :print_makers, through: :print_maker_orders
  has_many :order_invitations, dependent: :destroy
  belongs_to :customer

  after_create :send_order_invitations

  def complition_percentage
    return 7
    (total_completed_quantity.to_f / quantity.to_f * 100).round(2).to_i
  end

  def reserved_percentage
    return 31
    (total_reserved_quantity.to_f / quantity.to_f * 100).round(2).to_i
  end

  private

  def send_order_invitations
    SendInvitation.perform_async(id)
  end

  def total_completed_quantity
    print_maker_orders.sum(:completed_quantity)
  end

  def total_reserved_quantity
    print_maker_orders.sum(:reserved_quantity)
  end
end
