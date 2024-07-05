class Worker < ApplicationRecord
  belongs_to :user
  has_one :print_maker, inverse_of: :worker
  has_one :customer, inverse_of: :worker

  after_create :create_print_maker, if: -> { !user.print_maker.present? }

  def roles
    [].tap do |roles|
      roles.push(print_maker) if print_maker.present?
      roles.push(customer) if customer.present?
    end
  end
end
