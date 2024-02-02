class ClientBlueprint < Blueprinter::Base
    identifier :id

    view :basic do
        fields :identification,
               :full_name,
               :phone,
               :email
    end

    view :client_orders do
        include_view :basic

        association :orders, blueprint: OrderBlueprint, view: :basic
    end
end