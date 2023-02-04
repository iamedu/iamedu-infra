resource "digitalocean_container_registry" "iamedu_registry" {
  name                   = "iamedu-registry"
  subscription_tier_slug = "starter"
}

resource "digitalocean_app" "website" {
  spec {
    name   = "iamedu-website"
    region = "sfo3"

    domain {
      name = "iamedu.io"
      type = "PRIMARY"
    }

    domain {
      name = "iamedu.dev"
      type = "ALIAS"
    }

    static_site {
      name = "iamedu-front"
      build_command = "npm run build"

      github {
        branch = "main"
        deploy_on_push = true
        repo = "iamedu/iamedu-front"
      }
    }

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

      routes {
        path = "/assets/graphiql"
        preserve_path_prefix = true
      }
    }


  }
}

data "digitalocean_domain" "iamedu_io" {
  name = "iamedu.io"
}

data "digitalocean_domain" "iamedu_dev" {
  name = "iamedu.dev"
}
