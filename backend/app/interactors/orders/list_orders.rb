module Orders
  class ListOrders
    PER_PAGE = 5

    def self.with(page:)
      new(page:).execute
    end

    def initialize(page:)
      @page = page || 1
    end

    def execute
      orders = Order.recent.page(@page).per(PER_PAGE)

      {
        orders: orders,
        meta: {
          current_page: orders.current_page,
          total_pages: orders.total_pages,
          total_count: orders.total_count
        }
      }
    end
  end
end
