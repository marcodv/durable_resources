{
    "Statement": [
        {
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:eks:eu-west-1:848481299679:cluster/eks-${environment}-env"
        }
    ],
    "Version": "2012-10-17"
}