class SendInvitation
  include Sidekiq::Worker

  sidekiq_options :failures => true

  def perform(id)
    order = Order.find_by(id: id)

    return unless order

    matching_print_makers = PrintMaker.includes(:print_makers_filaments).where(
      status: 'ready',
      print_makers_filaments: { filament_id: order.filament_id }
    )

    binding.pry
    matching_print_makers.each do |print_maker|
      OrderInvitation.create(
        order_id: order.id,
        print_maker_id: print_maker.id
      )
    end
  end
end
