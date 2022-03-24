{
    "Statement": [
        {
            "Action": [
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "eks:DescribeCluster",
                "eks:ListClusters",
                "eks:AccessKubernetesApi",
                "ssm:GetParameter",
                "eks:ListUpdates",
                "eks:ListFargateProfiles"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:eks:eu-west-1:848481299679:cluster/eks-${environment}-env"
        }
    ],
    "Version": "2012-10-17"
}