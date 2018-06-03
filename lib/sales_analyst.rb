require 'pry'

class SalesAnalyst
  # attr_reader :engine

  def initialize(engine)
    @engine = engine
    @items = @engine.items
    @merchants = @engine.merchants
    @invoices = @engine.invoices
  end

  def average_items_per_merchant ###############################################
    mean(item_count_for_each_merchant_id.values)
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def items_grouped_by_merchant_id
    @items.group_by do |item|
      item.merchant_id
    end
  end

  def item_count_by_merchant_id
    items_grouped_by_merchant_id.map do |merchant_id,item_list|
      item_list.count
=======
=======
>>>>>>> ab611814bedda2e9da9c31adbf5293821dc5fc9b
  def average_items_per_merchant_standard_deviation ############################
    standard_deviation(item_count_for_each_merchant_id.values)
  end

  def merchants_with_high_item_count ###########################################
    one_std_dev =
      average_items_per_merchant + average_items_per_merchant_standard_deviation
    item_count_for_each_merchant_id.map do |merchant_id,item_count|
      @merchants.find_by_id(merchant_id) if item_count > one_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id) #############################
    prices = items_grouped_by_merchant_id[merchant_id].map do |item|
      item.unit_price
<<<<<<< HEAD
>>>>>>> 47b5c70e781a000340154dc660cee8c345b7e2fc
=======
>>>>>>> ab611814bedda2e9da9c31adbf5293821dc5fc9b
    end
    BigDecimal(mean(prices), 6)
  end

  def average_average_price_per_merchant #######################################
    avg_prices = items_grouped_by_merchant_id.map do |merchant_id, items|
      average_item_price_for_merchant(merchant_id)
    end
    BigDecimal(mean(avg_prices), 6)
  end

  def items_grouped_by_merchant_id
    @items.all.group_by(&:merchant_id)
  end

  def item_count_for_each_merchant_id
    items_grouped_by_merchant_id.merge(items_grouped_by_merchant_id) do |merchant_id,item_list|
      item_list.count
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    one_std_dev = mean + std_dev
    items_grouped_by_merchant_id.map do |id,item_list|
      @engine.merchants.find_by_id(id) if item_list.count > one_std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    prices = items_gropued_by_merchant_id[merchant_id].map do |item|
      item.unit_price
    end
    (prices.inject(:+)/prices.count).round(2)
  end

  def average_average_price_per_merchant
    avg_prices = items_gropued_by_merchant_id.keys.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (avg_prices.inject(:+)/avg_prices.count).round(2)
=======
=======
>>>>>>> ab611814bedda2e9da9c31adbf5293821dc5fc9b
  def mean(numbers_array)
    (numbers_array.inject(:+).to_f / numbers_array.count).round(2)
  end

  def summed_variance(numbers_array)
    avg = mean(numbers_array)
    numbers_array.map do |count|
      (count - avg) ** 2
    end.inject(:+)
  end

  def standard_deviation(numbers_array)
    result = (summed_variance(numbers_array) / (numbers_array.count - 1))
    Math.sqrt(result).round(2)
<<<<<<< HEAD
>>>>>>> 47b5c70e781a000340154dc660cee8c345b7e2fc
=======
>>>>>>> ab611814bedda2e9da9c31adbf5293821dc5fc9b
  end

  def all_item_unit_prices
    @items.all.map do |item|
      item.unit_price
    end
  end

  def average_item_unit_price
    mean(all_item_unit_prices)
  end

  def average_item_unit_price_standard_deviation
    standard_deviation(all_item_unit_prices)
  end

  def golden_items #############################################################
    two_std_dev =
      average_item_unit_price + (average_item_unit_price_standard_deviation * 2)
    @items.all.map do |item|
      item if item.unit_price > two_std_dev
    end.compact
  end

  def invoices_grouped_by_merchant_id
    @invoices.all.group_by(&:merchant_id)
  end

  def invoice_count_for_each_merchant_id
    invoices_grouped_by_merchant_id.merge(invoices_grouped_by_merchant_id) do |merchant_id,invoice_list|
      invoice_list.count
    end
  end

  def average_invoices_per_merchant ############################################
    mean(invoice_count_for_each_merchant_id.values)
  end

  def average_invoices_per_merchant_standard_deviation##########################
    standard_deviation(invoice_count_for_each_merchant_id.values)
  end

  def top_merchants_by_invoice_count
    two_std_dev =
      average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    invoice_count_for_each_merchant_id.map do |merchant_id,invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count > two_std_dev
    end.compact
  end

  def bottom_merchants_by_invoice_count
    two_std_dev =
      average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    invoice_count_for_each_merchant_id.map do |merchant_id,invoice_count|
      @merchants.find_by_id(merchant_id) if invoice_count < two_std_dev
    end.compact
  end

  def invoices_grouped_by_day
    @invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def invoice_count_by_weekday
    invoices_grouped_by_day.map do |key,invoices|
      if key == 0
        key, invoices = 'Sunday', invoices.count
      elsif key == 1
        key, invoices = 'Monday', invoices.count
      elsif key == 2
        key, invoices = 'Tuesday', invoices.count
      elsif key == 3
        key, invoices = 'Wednesday', invoices.count
      elsif key == 4
        key, invoices = 'Thursday', invoices.count
      elsif key == 5
        key, invoices = 'Friday', invoices.count
      elsif key == 6
        key, invoices = 'Saturday', invoices.count
      end
    end.to_h
  end

  def average_invoice_count_per_weekday
    mean(invoice_count_by_weekday.values)
  end

  def average_invoice_count_per_weekday_standard_deviation
    standard_deviation(invoice_count_by_weekday.values)
  end

  def top_days_by_invoice_count
    one_std_dev =
      average_invoice_count_per_weekday + average_invoice_count_per_weekday_standard_deviation
    invoice_count_by_weekday.map do |day,count|
      day if count > one_std_dev
    end.compact
  end

  def invoices_grouped_by_status
    @invoices.all.group_by do |invoice|
      invoice.status
    end
  end

  def percentage(numbers)
    (100*numbers.count/@invoices.all.count.to_f).round(2)
  end

  def invoice_count_by_status
    invoices_grouped_by_status.map do |status, invoices|
      status, invoices = status, percentage(invoices)
    end.to_h
  end

<<<<<<< HEAD
<<<<<<< HEAD
def average_invoices_per_merchant_standard_deviation
  # => 3.29
  # Who are our top performing merchants?
  # Which merchants are more than two standard deviations above the mean?
end

def top_merchants_by_invoice_count
  # => [merchant, merchant, merchant]
  # Who are our lowest performing merchants?
  # Which merchants are more than two standard deviations below the mean?
end

def bottom_merchants_by_invoice_count
  # => [merchant, merchant, merchant]
  # Which days of the week see the most sales?
  # On which days are invoices created at more than one standard deviation above the mean?
end

def top_days_by_invoice_count
  # => ["Sunday", "Saturday"]
  # What percentage of invoices are not shipped?
  # What percentage of invoices are shipped vs pending vs returned? (takes symbol as argument)
end
=======
  def invoice_status(status)
    invoice_count_by_status[status]
  end
>>>>>>> 47b5c70e781a000340154dc660cee8c345b7e2fc
=======
  def invoice_status(status)
    invoice_count_by_status[status]
  end
>>>>>>> ab611814bedda2e9da9c31adbf5293821dc5fc9b


end
