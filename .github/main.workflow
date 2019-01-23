workflow "Deploy on push to master" {
  on = "push"
  resolves = [
    "filter",
    "mortar",
  ]
}

action "filter" {
  uses = "actions/bin/filter@707718ee26483624de00bd146e073d915139a3d8"
  args = "branch master"
}

action "mortar" {
  uses = "docker://quay.io/kontena/mortar:0.3.1"
  runs = "mortar fire -c manifests/shot.yml manifests/ my-app"
  needs = ["filter"]
  secrets = ["KUBE_SERVER", "KUBE_TOKEN", "KUBE_CA"]
}
