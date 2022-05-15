provider "aws" {
    access_key = ""
    secret_key = ""
    region = "us-east-1"
}

resource "aws_instance" "terraform-example" {
    ami = "ami-0f9fc25dd2506cf6d"
    instance_type = "t2.micro"
    key_name = ""
    # Create keypair on AWS
    # Open up port 22 for SSH on security group if not done already

  user_data = <<EOF
            #!/bin/bash
            mkdir -p "./home/ec2-user/ryantest/ec2-user/apps/3.1.0" && touch "/home/ec2-user/ryantest/ec2-user/apps/3.1.0/3.1.0.txt"
            touch /home/ec2-user/fileClean.sh
            chmod +x /home/ec2-user/fileClean.sh
              
              
            cat << 'END' > /home/ec2-user/fileClean.sh

            VersionPath="/home/ec2-user/ryantest/ec2-user/apps/3.1.0/3.1.0.txt"

            if
            [ "$(find $VersionPath -mmin +1 )" ]; then 
            echo "File ** $VersionPath ** is older than 1 minute."
            echo "Removing ** $VersionPath ** "
            sudo rm -rf /home/ec2-user/ryantest/ec2-user/apps/3.1.0

            else
                echo "File ** $VersionPath ** is less than a minute. Will keep file."
            fi
            'END'
             
            EOF
}
