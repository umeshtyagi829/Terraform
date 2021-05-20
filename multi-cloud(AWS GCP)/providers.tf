provider "aws"{

region              = "ap-south-1"
profile             = "user1"
}

provider "google"{
    project = "arthfirstproject1"
    region = "asia-south1" 
    credentials = "arthfirstproject1.json"
}