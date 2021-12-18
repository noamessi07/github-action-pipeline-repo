terraform {
  cloud {
    organization = "mizaorg"

    workspaces {
      name = "demo-miza-workspace"
    }
  }
}