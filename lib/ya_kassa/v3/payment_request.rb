module YaKassa
  module V3
    class PaymentRequest < BaseRequest
      attributable :amount_value
      attributable :amount_currency, default: "RUB"
      attributable :capture, default: true
      attributable :confirmation_type, default: "redirect"
      attributable :return_url
      attributable :confirmation_url
      attributable :description
      attributable :metadata, default: {}

      validatable :amount_value, :is_a, class: 'Float'
      validatable :amount_currency, :present
      validatable :capture, :is_a_boolean
      validatable :confirmation_type, :present
      validatable :return_url, :is_a, class: 'String'
      validatable :metadata, :is_a, class: 'Hash'

      # amount_value and return_url are required
      def body
        {
          amount: {
            value: amount_value,
            currency: amount_currency
          },
          capture: capture,
          confirmation: {
            type: confirmation_type,
            return_url: return_url
          },
          description: description,
          metadata: metadata
        }
      end

      private

      def api_client
        api_client_post
      end

      def url
        router.payment_url
      end
    end
  end
end
