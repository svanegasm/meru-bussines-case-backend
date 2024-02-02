class Client < ApplicationRecord
    # Associations
    has_many :orders

    #Scopes
    scope :availables, -> { where(deleted_at: nil) }

    # Validations
    validates :identification, presence: { message: "La identificación es obligatoria" }, uniqueness: { case_sensitive: false, message: "Ya tenemos un cliente con esa identificación" }
    validates :full_name, presence: { message: "El nombre completo es obligatorio" }
    validates :email, presence: { message: "El correo electrónico es obligatorio" }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "El formato del correo electrónico no es válido" }
    validates :phone, presence: { message: "El teléfono es obligatorio" }, format: { with: /\A\+?\d+\z/, message: "El teléfono debe ser numérico" }

end
