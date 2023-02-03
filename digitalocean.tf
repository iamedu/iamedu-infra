resource "digitalocean_container_registry" "iamedu_registry" {
  name                   = "iamedu-registry"
  subscription_tier_slug = "starter"
}