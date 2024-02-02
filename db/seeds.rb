User.create!(
  email: 'user@email.com',
  password: 'password'
)

User.create!(
  email: 'admin@email.com',
  password: 'password',
  role: 'admin'
)

# Dummy Clients
10.times do |i|
  Client.create!(
    identification: "ID#{i}",
    full_name: "Cliente #{i}",
    phone: "123456789#{i}",
    email: "cliente#{i}@ejemplo.com"
  )
end

# Dummy Products
10.times do |i|
  Product.create!(
    name: "Producto #{i}",
    description: "Descripción del Producto #{i}",
    price: (50 + i * 10),
    stock: (20 + i),
    percentage_discount: (i.even? ? 10.00 : 0.00),
    percentage_tax: 16.00
  )
end

# Dummy Orders con OrderProducts
10.times do |_i|
  client_id = Client.order("RANDOM()").first.id
  status = Order.statuses.keys.sample
  payment_method = Order.payment_methods.keys.sample

  order = Order.create!(
    client_id: client_id,
    status: status,
    payment_method: payment_method
  )

  2.times do |_j|
    product = Product.order("RANDOM()").first
    quantity = [1, 2, 3, 4, 5].sample

    pricing = PricingService.calculate_for_order_product(product)
    unit_price = pricing[:unit_price]
    tax_value = pricing[:tax_value]
    discount_value = pricing[:discount_value]
    total_products_price = unit_price * quantity

    order.order_products.create!(
      product_id: product.id,
      quantity: quantity,
      unit_price: unit_price,
      tax_value: tax_value,
      discount_value: discount_value,
      total_products_price: total_products_price
    )
  end
end