output "name"{
   value = aws_launch_configuration.lc.name
}

output "arn"{
  value =  aws_launch_configuration.lc.arn
}

output "id"{
   value = aws_launch_configuration.lc.id
}

output "userdata" {
value =   aws_launch_configuration.lc.user_data
}