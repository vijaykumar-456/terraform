data "aws_ami" "learndevopskills" {
    most_recent = true
    owners = ["973714476881"]

    filter {
        name = "name"
        values = ["Redhat-9-DevOps-Practice"]
    }

}

output "fetched_ami_id" {
    value       = data.aws_ami.learndevopskills.id
    description = "The ID of the dynamically queried AMI."
    }
