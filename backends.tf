terraform {
  backend "remote" {
    organization = "tfclouddfa"

    workspaces {
      name = "tf-eks-fargate-dev"
    }
  }
}