STRIPE_CONFIG = YAML::load(File.open("config/config.yml"))[Rails.env == "production" ? "stripe_live" : "stripe_test"]

Rails.configuration.stripe = {
	:publishable_key	=>	STRIPE_CONFIG['publishable_key'],
	:secret_key			=>	STRIPE_CONFIG['secret_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]