class Order < ApplicationRecord
  has_many_attached :images, dependent: :purge
  has_many_attached :models, dependent: :purge
  has_many :print_maker_orders, dependent: :destroy
  has_many :print_makers, through: :print_maker_orders
  has_many :order_invitations, dependent: :destroy
  belongs_to :customer

  before_create :set_initial_status
  after_create :send_order_invitations

  enum status: { pending: 'очікує', in_progress: 'в процесі', completed: 'завершено', canceled: 'скасовано' }

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

  private

  def send_order_invitations
    SendInvitation.perform_async(id)
  end

  def set_initial_status
    self.status ||= 'pending'
  end
end
