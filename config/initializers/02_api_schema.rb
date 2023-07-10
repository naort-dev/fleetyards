# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  v1_components_loader = ComponentsLoader.new("v1")
  admin_v1_components_loader = ComponentsLoader.new("admin/v1")
  shared_v1_components_loader = ComponentsLoader.new("shared/v1")

  Rails.application.configure do
    api_servers = [
      {
        url: API_ENDPOINT,
        description: "Dev Server"
      },
      {
        url: "https://api.fleetyards.net/v1",
        description: "Production Server"
      }, {
        url: "https://api.fleetyards.dev/v1",
        description: "Staging Server"
      }
    ]

    admin_api_servers = [
      {
        url: ADMIN_API_ENDPOINT,
        description: "Dev Server"
      }, {
        url: "http://admin.fleetyards.test/api/v1",
        description: "Production Server"
      }, {
        url: "https://admin.fleetyards.dev/api/v1",
        description: "Staging Server"
      }
    ]

    config.api_schema.schemas = {
      "v1/schema.yaml" => {
        openapi: "3.0.1",
        info: {
          title: "FleetYards.net API",
          version: "v1"
        },
        servers: api_servers,
        paths: {},
        components: {
          schemas: shared_v1_components_loader.schemas.merge(v1_components_loader.schemas)
        }.compact
      },
      "admin/v1/schema.yaml" => {
        openapi: "3.0.1",
        info: {
          title: "FleetYards.net Command API",
          version: "v1"
        },
        servers: admin_api_servers,
        paths: {},
        components: {
          schemas: shared_v1_components_loader.schemas.merge(admin_v1_components_loader.schemas)
        }.compact
      }
    }
  end
end
