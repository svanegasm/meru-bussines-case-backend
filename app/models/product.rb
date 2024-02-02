class Product < ApplicationRecord
    # Associations
    has_many :order_products
    has_many :orders, through: :order_products

    #Scopes
    scope :availables, -> { where(deleted_at: nil) }

    #Validations
    validates :name, presence: { message: "El nombre es obligatorio" }
    validates :price, presence: { message: "El precio es obligatorio" }
    validates :stock, presence: { message: "Stock de Producto obligatorio" }
    validates :price, numericality: { greater_than_or_equal_to: 0, message: "El precio debe ser un valor positivo" }
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "El stock debe ser un número entero no negativo" }
    validates :percentage_discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "El porcentaje de descuento debe estar entre 0 y 100" }
    validates :percentage_tax, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: "El porcentaje de impuesto debe ser un valor entre 0 y 100" }

end
