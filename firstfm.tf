provider "google" {
  credentials = "${file("freevmproject.json")}"
  project     = "freevmproject"
  region      = "us-central1"
}


resource "google_compute_instance" "default" {
  name         = "firstvm"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "centos-7-v20191014"
    }
  }

  network_interface {
     network = "default"

     access_config {
   }
 }
  metadata_startup_script = "yum -y update; yum -y install epel-repo; yum -y update; yum -y install ansible"
}

resource "google_compute_firewall" "default" {
 name    = "firewall-8080"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["8080"]
 }
}
