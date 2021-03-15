terraform {
  required_version = "~> 0.14.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.21.0"
    }
  }
}

# Configure the New Relic provider
# Reference to a better approach
# https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/guides/provider_configuration#configuration-via-environment-variables

provider "newrelic" {
  account_id = 
  api_key = ""    # usually prefixed with 'NRAK'
  region = "US"                                 # Valid regions are US and EU
}

resource "newrelic_synthetics_monitor" "foo" {
  name = "foo"
  type = "SCRIPT_BROWSER"
  frequency = 5
  status = "ENABLED"
  locations = ["AWS_US_EAST_1"]
}

resource "newrelic_synthetics_monitor_script" "foo_script" {
  monitor_id = newrelic_synthetics_monitor.foo.id
  text = file("synthetic-scripts/riocan-prod-web-service-generic-search.js")
}