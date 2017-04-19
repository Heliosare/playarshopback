Rails.configuration.stripe = {
  :publishable_key => 'pk_test_YFUrNs3byh7cEoZiyM0L3qhO' ,
  :secret_key      => 'sk_test_TEB9mUTA9wL1LD2dR62gkGcy'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
