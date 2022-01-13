terraform {
  cloud {
    organization = "GitAction"

    workspaces {
      name = "github-action-pipeline"
    }
  }
}