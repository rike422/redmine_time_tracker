module ChronosUi
  module TimeBookings
    extend ActiveSupport::Concern

    included do
      menu_item :chronos_time_bookings, only: :time_bookings
    end

    def time_bookings
      retrieve_query
      init_sort
      @list_arguments = list_arguments
      build_chart_query
    end

    def edit_time_bookings
      time_booking = get_time_booking
      authorize_foreign
      render 'chronos_ui/time_bookings/edit', locals: {time_booking: time_booking}, layout: false unless performed?
    end

    def report
      @query_identifier = :time_bookings
      retrieve_query
      init_sort
      @list_arguments = list_arguments
      @list_arguments[:entries] = @list_arguments[:entries].offset(nil).limit(nil)
      build_chart_query
      render layout: false
    end

    private
    def get_time_booking
      time_booking = Chronos::TimeBooking.find_by id: params[:id]
      render_404 unless time_booking.present?
      @request_resource = time_booking
    end
  end
end