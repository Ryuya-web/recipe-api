Rails.application.config.middleware.insert_before Rack::Head, Middleware::RescueJsonParseErrors