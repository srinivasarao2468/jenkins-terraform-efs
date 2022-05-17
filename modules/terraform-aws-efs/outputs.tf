output "arn"{
    value = aws_efs_file_system.efs_file_system.arn
}

output "id"{
    value = aws_efs_file_system.efs_file_system.id
}

output "dns_name"{
    value = aws_efs_file_system.efs_file_system.dns_name
}

output "mount_target_dns_names"{
    value = aws_efs_mount_target.efs_mount_target.*.mount_target_dns_name
}

