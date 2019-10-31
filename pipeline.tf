resource "heroku_app" "ci" {
  name   = "${var.app_prefix}-app-ci"
  region = "eu"
}

resource "heroku_app" "staging" {
  name   = "${var.app_prefix}-app-staging"
  region = "eu"
}

resource "heroku_app" "production" {
  name   = "${var.app_prefix}-app-prod"
  region = "eu"
}

resource "heroku_pipeline" "heroku_pipeline" {
  name = "${var.pipeline_name}"
}

resource "heroku_pipeline_coupling" "ci" {
  app      = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.heroku_pipeline.id}"
  stage    = "development"
}

resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.heroku_pipeline.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.heroku_pipeline.id}"
  stage    = "production"
}

resource "heroku_app_config_association" "cienv" {
  app_id = "${heroku_app.ci.id}"
  sensitive_vars = {
    LOGZ_TOKEN = "${var.logztoken}"
    LOGZ_URL = "${var.logzurl}"
  }
}

resource "heroku_app_config_association" "stagingenv" {
  app_id = "${heroku_app.staging.id}"
  sensitive_vars = {
    LOGZ_TOKEN = "${var.logztoken}"
    LOGZ_URL = "${var.logzurl}"
  }
}

resource "heroku_app_config_association" "productionenv" {
  app_id = "${heroku_app.production.id}"
  sensitive_vars = {
    LOGZ_TOKEN = "${var.logztoken}"
    LOGZ_URL = "${var.logzurl}"
  }
}