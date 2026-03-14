module Orders
  class GetOrderStats
    def self.get
      new.execute
    end

    def execute
      stats = Order.group(:status).select("status, COUNT(*) as orders_count, SUM(total_amount) as revenue").index_by(&:status)

      cancelled = stats["cancelled"]
      completed = stats["completed"]
      pending = stats["pending"]
      confirmed = stats["confirmed"]

      {
        total_orders: stats.values.sum { |s| s.orders_count },
        cancelled_orders: cancelled&.orders_count || 0,
        completed_orders: completed&.orders_count || 0,
        in_progress_orders: (pending&.orders_count || 0) + (confirmed&.orders_count || 0),
        total_revenue: (pending&.revenue || 0) + (confirmed&.revenue || 0) + (completed&.revenue || 0)
      }
    end
  end
end
