# Black Thursday

## Project Overview

## Data Access Layer

The DAL is built using the SalesEngine class which loads and parses the raw data from CSV files.

### `SalesEngine`

```ruby
se = SalesEngine.from_csv({
  :items         => './data/items.csv',
  :merchants     => './data/merchants.csv',
  :invoices      => './data/invoices.csv',
  :transactions  => './data/transactions.csv',
  :invoice_items => './data/invoice_items.csv',
  :customers     => './data/customers.csv'
})
```

The `SalesEngine` instantiated using the CSV files as written above. The below repositories and `SalesAnalyst` are instantiated with the SalesEngine with the following methods:

`merchants`
`items`
`invoices`
`invoice_items`
`transactions`
`customers`
`analyst`


### `MerchantRepository`

The `MerchantRepository` is responsible for holding and searching our `Merchant` instances. It offers the following methods:

* `all` - returns an array of all known `Merchant` instances
* `find_by_id` - returns either `nil` or an instance of `Merchant` with a matching ID
* `find_by_name` - returns either `nil` or an instance of `Merchant` having done a *case insensitive* search
* `find_all_by_name` - returns either `[]` or one or more matches which contain the supplied name fragment, *case insensitive*

### `Merchant`



### `ItemRepository`

### `Item`

```ruby
i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
})
```

### Key Concepts

From a technical perspective, this project emphasizes:

* File I/O
* Relationships between objects
* Encapsulating Responsibilities
* Light data / analytics

### Learning Goals

* Use tests to drive both the design and implementation of code
* Decompose a large application into components
* Use test fixtures instead of actual data when testing
* Connect related objects together through references
* Learn an agile approach to building software

## Built With

* [Ruby](https://www.ruby-lang.org/en/) (version 2.3)
