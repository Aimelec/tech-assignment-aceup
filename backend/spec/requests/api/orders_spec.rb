require "swagger_helper"

RSpec.describe "Orders API", type: :request do
  path "/api/orders" do
    post "Creates an order" do
      tags "Orders"
      consumes "application/json"
      produces "application/json"

      parameter name: :params, in: :body, schema: { "$ref": "#/components/schemas/order_input" }

      response "201", "order created" do
        schema object_response_schema(:order_output)

        let(:params) do
          {
            order: {
              customer_name: "John Doe",
              customer_email: "john@example.com",
              description: "Test order",
              total_amount: 99.99
            }
          }
        end

        run_test! do |response|
          order = Order.last
          expected = JSON.parse(OrderSerializer.new(order).serializable_hash.to_json)

          expect(JSON.parse(response.body)).to eq(expected)
        end
      end

      response "422", "validation error" do
        let(:params) { { order: { customer_email: "john@example.com", total_amount: 99.99 } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(
            "errors" => [
              {
                "status" => "422",
                "title" => "Validation Error",
                "detail" => "customer_name is missing",
                "source" => { "pointer" => "/data/attributes/customer_name" }
              }
            ]
          )
        end
      end
    end
  end

  path "/api/orders/{id}" do
    put "Updates an order" do
      tags "Orders"
      consumes "application/json"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer

      parameter name: :params, in: :body, schema: { "$ref": "#/components/schemas/order_update_input" }

      response "200", "order updated" do
        schema object_response_schema(:order_output)

        let(:id) { create(:order).id }
        let(:params) { { order: { customer_name: "Updated Name" } } }

        run_test! do |response|
          order = Order.find(id)
          expected = JSON.parse(OrderSerializer.new(order).serializable_hash.to_json)

          expect(JSON.parse(response.body)).to eq(expected)
        end
      end

      response "422", "validation error" do
        let(:id) { create(:order).id }
        let(:params) { { order: { customer_email: "invalid" } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(
            "errors" => [
              {
                "status" => "422",
                "title" => "Validation Error",
                "detail" => "customer_email must have email format",
                "source" => { "pointer" => "/data/attributes/customer_email" }
              }
            ]
          )
        end
      end

      response "404", "order not found" do
        let(:id) { 0 }
        let(:params) { { order: { customer_name: "Updated Name" } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(
            "errors" => [
              {
                "status" => "404",
                "title" => "Not Found",
                "detail" => "Couldn't find Order with 'id'=0"
              }
            ]
          )
        end
      end
    end

    delete "Deletes an order" do
      tags "Orders"
      produces "application/json"
      parameter name: :id, in: :path, type: :integer

      response "200", "order deleted" do
        schema object_response_schema(:order_output)

        let!(:order) { create(:order) }
        let(:id) { order.id }

        run_test! do |response|
          expected = JSON.parse(OrderSerializer.new(order).serializable_hash.to_json)

          expect(JSON.parse(response.body)).to eq(expected)
        end
      end

      response "404", "order not found" do
        let(:id) { 0 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq(
            "errors" => [
              {
                "status" => "404",
                "title" => "Not Found",
                "detail" => "Couldn't find Order with 'id'=0"
              }
            ]
          )
        end
      end
    end
  end
end
