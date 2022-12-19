"""
It uses diagrams lib to create infrastructure diagram.

Installation details: https://diagrams.mingrammer.com/docs/getting-started/installation
"""
from diagrams import Cluster, Diagram
from diagrams.aws.compute import Fargate
from diagrams.aws.database import ElastiCache, RDS
from diagrams.aws.network import ALB
from diagrams.aws.storage import S3
from diagrams.aws.security import SecretsManager
from diagrams.aws.compute import EC2Instance
from diagrams.aws.management import Cloudwatch
from diagrams.generic.network import Subnet
from diagrams.aws.compute import ECR


def main():
    with Diagram("Infrastructure Diagram", show=False):

        SecretsManager("Secrets Manager")
        ECR("Container registry")

        entry = Subnet("Entry")

        lb = ALB("ALB")

        Cloudwatch("CloudWatch")
        S3("S3")

        with Cluster("VPC"):
            bastion = EC2Instance("Bastion")

            with Cluster("Auto scaling groups"):
                svc_group = [Fargate("ap-southeash-1a"), Fargate("ap-southeash-1b")]

            db_primary = RDS("AZ RDS")
            cache = ElastiCache("AZ ElastiCache")

            entry >> lb >> svc_group
            entry >> bastion
            svc_group >> db_primary
            svc_group >> cache


if __name__ == "__main__":
    main()
