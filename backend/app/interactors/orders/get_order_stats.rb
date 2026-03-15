module Orders
  class GetOrderStats
    def self.get
      new.execute
    end

    def execute
      stats = Order.group(:status).select("status, COUNT(*) as orders_count, SUM(total_amount) as revenue").index_by(&:status)

      cancelled = stats["cancelled"]
      completed = stats["completed"]
      in_progress = stats["in_progress"]

      {
        total_orders: stats.values.sum { |s| s.orders_count },
        cancelled_orders: cancelled&.orders_count || 0,
        completed_orders: completed&.orders_count || 0,
        in_progress_orders: in_progress&.orders_count || 0,
        total_revenue: (in_progress&.revenue || 0) + (completed&.revenue || 0)
      }
    end
  end
end
