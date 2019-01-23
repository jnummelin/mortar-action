workflow "Deploy on push to master" {
  on = "push"
  resolves = ["docker"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@707718ee26483624de00bd146e073d915139a3d8"
  args = "branch master"
}

action "Mortar deploy" {
  uses = "docker://quay.io/kontena/mortar:0.3.1"
  needs = ["Filters for GitHub Actions"]
  runs = "mortar deploy manifests/ my-app"
}