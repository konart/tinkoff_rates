class Rate < ApplicationRecord
  def get_pair_by_action(from, to, action)
    rates = Rate.select(action, :created_at).where(from: from, to: to).where('created_at >= ?', 1.day.ago)
    rates.reduce({}) { |acc, hash| acc.merge(hash[:created_at] => hash[action]) }
  end

  def avg_pairs
    sql = 'SELECT t."from", t."to", AVG(sell) as sell, AVG(buy) as buy
            FROM rates t where (created_at >= ?)
            GROUP BY t."from", t."to"'
    avg = Rate.execute_sql(sql, 1.day.ago)
    avg.reduce({}) do |acc, hash|
      acc.merge([hash['from'], hash['to']] => {sell: hash['sell'].round(2), buy: hash['buy'].round(2)})
    end
  end

  def self.execute_sql(*sql_array)
    connection.execute(send(:sanitize_sql_array, sql_array))
  end
end
