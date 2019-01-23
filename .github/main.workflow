workflow "Deploy on push to master" {
  on = "push"
  resolves = ["new-action"]
}

action "filter" {
  uses = "actions/bin/filter@707718ee26483624de00bd146e073d915139a3d8"
  args = "branch master"
}

action "mortar" {
  uses = "docker://quay.io/kontena/mortar:0.3.1"
  needs = ["filter"]
  runs = "mortar deploy manifests/ my-app"
}
