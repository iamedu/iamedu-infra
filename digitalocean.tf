resource "digitalocean_container_registry" "iamedu_registry" {
  name                   = "iamedu-registry"
  subscription_tier_slug = "starter"
}

resource "digitalocean_app" "website" {
  spec {
    name   = "iamedu-website"
    region = "sfo3"

    service {
      name      = "api"
      http_port = 8080

      image {
        registry_type = "DOCR"
        repository    = "website/backend"
        deploy_on_push {
          enabled = true
        }
      }

      routes {
        path = "/graphql"
        preserve_path_prefix = true
      }

      routes {
        path = "/ide"
        preserve_path_prefix = true
      }
    }
  }
}
