terraform {
  backend "remote" {
    organization = "devsecopslearning"

    workspaces {
      name = "devsecops-dev"
    }
  }
}
