#create aws_key_pair
resource "aws_key_pair" "mykeypair" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCu7c3JTMzOEhfLsNj4MfUWjgaxr6a+6JJV/TisAtLz2jBeH3p12FOcTGOa+pScfeWQZz0VmTGzlpV4+EjzsUuhXf5dlPUjX0O42+Ta21VLFcW0mZBZhfVlcvl+dw04KjnlXq2M5fAD9IgGaMiAkz/aufgELTt7+/RTe+dtElRf4hxwb/Yryn79JyTRe2AQ1Hhv8eLN/SLdb4RCOw4s/aFs3KqnAqjOg/NLJ9Dw1cyiWDHGMENmP30GPEPV5mWsGWWBeuCa6XdQFSbDViwE3MlNCM1vjsUK1mBPFF8EjvOdc6ZXCbp1+p37+CG4sb9O9D3n1y09bAxkhmeDh1e0+c2H mykeypair"
}

output "key_name" {
  value = aws_key_pair.mykeypair.id
}
