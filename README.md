# Black Thursday

## Project Overview

This is a system that is able to load, parse, search, and execute business intelligence queries against the data from a typical e-commerce business.

The project has two parts; data and analysis.

* [Data Access Layer](#data-access-layer)
* [Analysis Layer](#analysis-layer)

## Data Access Layer

The DAL is built using the SalesEngine class which loads and parses the raw data from CSV files.

### `SalesEngine`

The `SalesEngine` is instantiated with the CSV files. The below repositories and `SalesAnalyst` are instantiated with the SalesEngine with the following repositories:

* [`merchants`](#merchantrepository)
* [`items`](#itemrepository)
* [`invoices`](#invoicerepository)
* [`invoice_items`](#invoiceitemrepository)
* [`transactions`](#transactionrepository)
* [`customers`](#customerrepository)

```ruby
SalesEngine.from_csv({
  :items         => './data/items.csv',
  :merchants     => './data/merchants.csv',
  :invoices      => './data/invoices.csv',
  :transactions  => './data/transactions.csv',
  :invoice_items => './data/invoice_items.csv',
  :customers     => './data/customers.csv'
})
```

### `MerchantRepository`

The `MerchantRepository` is responsible for holding and searching our `Merchant` instances. It offers the following methods:

* `all` - returns an array of all known `Merchant` instances
* `find_by_id` - returns either `nil` or an instance of `Merchant` with a matching ID
* `find_by_name` - returns either `nil` or an instance of `Merchant` having done a *case insensitive* search
* `find_all_by_name` - returns either `[]` or one or more matches which contain the supplied name fragment, *case insensitive*

#### The `Merchant` object

An example of a merchant instance:

```ruby
Merchant.new({
  :id => 5, 
  :name => "Turing School"
})
```

### `ItemRepository`

The `ItemRepository` is responsible for holding and searching our `Item` instances.  It offers the following methods:

* `all` - returns an array of all known `Item` instances
* `find_by_id` - returns either `nil` or an instance of `Item` with a matching ID
* `find_by_name` - returns either `nil` or an instance of `Item` having done a *case insensitive* search
* `find_all_with_description` - returns either `[]` or instances of `Item` where the supplied string appears in the item description (case insensitive)
* `find_all_by_price` - returns either `[]` or instances of `Item` where the supplied price exactly matches
* `find_all_by_price_in_range` - returns either `[]` or instances of `Item` where the supplied price is in the supplied range (a single Ruby `range` instance is passed in)
* `find_all_by_merchant_id` - returns either `[]` or instances of `Item` where the supplied merchant ID matches that supplied

#### The `Item` object

```ruby
Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4)
})
```

### `InvoiceRepository`

The `InvoiceRepository` is responsible for holding and searching our `Invoice` instances. It offers the following methods:

* `all` - returns an array of all known `Invoice` instances
* `find_by_id` - returns either `nil` or an instance of `Invoice` with a matching ID
* `find_all_by_customer_id` - returns either `[]` or one or more matches which have a matching customer ID
* `find_all_by_merchant_id` - returns either `[]` or one or more matches which have a matching merchant ID
* `find_all_by_status` - returns either `[]` or one or more matches which have a matching status

#### The `Invoice` object

```ruby
Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending"
})
```

### `InvoiceItemRepository`

Invoice items are how invoices are connected to items. A single invoice item connects a single item with a single invoice.

The `InvoiceItemRepository` is responsible for holding and searching our `InvoiceItem` instances. It offers the following methods:

* `all` - returns an array of all known `InvoiceItem` instances
* `find_by_id` - returns either `nil` or an instance of `InvoiceItem` with a matching ID
* `find_all_by_item_id` - returns either `[]` or one or more matches which have a matching item ID
* `find_all_by_invoice_id` - returns either `[]` or one or more matches which have a matching invoice ID

#### The `InvoiceItem` object

```ruby
InvoiceItem.new({
  :id         => 6,
  :item_id    => 7,
  :invoice_id => 8,
  :quantity   => 1,
  :unit_price => BigDecimal.new(10.99, 4)
})
```

It also offers the following method:

* `unit_price_to_dollars` - returns the price of the invoice item in dollars formatted as a `Float`

### `TransactionRepository`

Transactions are billing records for an invoice. An invoice can have multiple transactions, but should have at most one that is successful.

The `TransactionRepository` is responsible for holding and searching our `Transaction`
instances. It offers the following methods:

* `all` - returns an array of all known `Transaction` instances
* `find_by_id` - returns either `nil` or an instance of `Transaction` with a matching ID
* `find_all_by_invoice_id` - returns either `[]` or one or more matches which have a matching invoice ID
* `find_all_by_credit_card_number` - returns either `[]` or one or more matches which have a matching credit card number
* `find_all_by_result` - returns either `[]` or one or more matches which have a matching status

#### The `Transaction` object

```ruby
Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success"
})
```

### `CustomerRepository`

Customers represent a person who's made one or more purchases in our system.

The `CustomerRepository` is responsible for holding and searching our `Customers` instances. It offers the following methods:

* `all` - returns an array of all known `Customers` instances
* `find_by_id` - returns either `nil` or an instance of `Customer` with a matching ID
* `find_all_by_first_name` - returns either `[]` or one or more matches which have a first name matching the substring fragment supplied
* `find_all_by_last_name` - returns either `[]` or one or more matches which have a last name matching the substring fragment supplied

#### The `Customer` object

```ruby
Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke"
})
```

### Key Concepts

From a technical perspective, this project emphasizes:

* File I/O
* Relationships between objects
* Encapsulating Responsibilities
* Light data / analytics

## Analysis Layer

The Analysis Layer execute business intelligence queries against the data.  The SalesAnalyst class is instantiated with the SalesEngine which gives it access to the data repositories.

```ruby
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
```

```ruby
sa = SalesAnalyst.new(se)
```

### The following methods are available for data analysis

```ruby
sa.average_items_per_merchant # => 2.88
```

```ruby
sa.average_items_per_merchant_standard_deviation # => 3.26
```

```ruby
sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
```

```ruby
sa.average_item_price_for_merchant(6) # => BigDecimal
```

```ruby
sa.average_average_price_per_merchant # => BigDecimal
```

```ruby
sa.golden_items # => [<item>, <item>, <item>, <item>]
```

```ruby
sa.average_invoices_per_merchant # => 8.5
sa.average_invoices_per_merchant_standard_deviation # => 1.2
```

```ruby
sa.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

```ruby
sa.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
```

```ruby
sa.top_days_by_invoice_count # => ["Sunday", "Saturday"]
```

```ruby
sa.invoice_status(:pending) # => 5.25
sa.invoice_status(:shipped) # => 93.75
sa.invoice_status(:returned) # => 1.00
```

```ruby
# invoice.transactions.map(&:result) #=> ["failed", "success"]  
invoice.is_paid_in_full? #=> true

# invoice.transactions.map(&:result) #=> ["failed", "failed"]  
invoice.is_paid_in_full? #=> false
```

```ruby
sa.top_buyers(x) #=> [customer, customer, customer, customer, customer]
```

```ruby
sa.top_buyers #=> [customer * 20]
```

```ruby
sa.top_merchant_for_customer(customer_id) #=> merchant
```

```ruby
sa.one_time_buyers #=> [customer, customer, customer]
```

```ruby
sa.one_time_buyers_top_items #=> [item]
```

```rb
sa.items_bought_in_year(customer_id, year) #=> [item]
```

```rb
sa.highest_volume_items(customer_id) #=> [item, item, item]
```

```rb
sa.customers_with_unpaid_invoices #=> [customer, customer, customer]
```

```rb
sa.best_invoice_by_revenue #=> invoice
```

```rb
sa.best_invoice_by_quantity #=> invoice
```


## Built With

* [Ruby](https://www.ruby-lang.org/en/) (version 2.3)
