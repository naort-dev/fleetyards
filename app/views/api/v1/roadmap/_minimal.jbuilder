# frozen_string_literal: true

json.cache! ['v1', item] do
  json.partial! 'api/v1/roadmap/base', item: item
  json.model do
    if item.model.blank?
      json.null!
    else
      json.partial! 'api/v1/models/base', model: item.model
    end
  end
  json.last_version_changed_at item.last_version_changed_at.iso8601
  json.last_version_changed_at_display I18n.l(item.last_version_changed_at.utc, format: :display)
  json.last_version do
    if item.versions.count.zero?
      json.null!
    else
      json.merge! item.versions.last.changeset
    end
  end
  json.partial! 'api/shared/dates', record: item
end
