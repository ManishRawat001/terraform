provider "aws" {
    region = "eu-north-1"
}

variable "cidr_blocks" {
    description = "cidr block for VPC and Subnet"
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        Name = var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "eu-north-1a"
    tags = {
        Name = var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}
/*
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz
./config.sh --url https://github.com/LS-CO/leviLMA-levis.rn --token BHROUEH3VKSBHNA2METXABTGT3AAY
./run.sh
*/
