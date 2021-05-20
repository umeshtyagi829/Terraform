resource "google_compute_instance" "default" {
  name         = "os1"
  machine_type = var.machine_type
  zone         = "asia-south1-c"
  count        = var.isprod ? 0 : 1

boot_disk {
  initialize_params {
    image = "debian-cloud/debian-9"
   }
  }

network_interface {
  network = "default"
  }
}