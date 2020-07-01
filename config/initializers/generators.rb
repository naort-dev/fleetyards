# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
  g.orm :active_record, foreign_key_type: :uuid
  g.orm :active_record, force_foreign_key_type: :uuid
end
