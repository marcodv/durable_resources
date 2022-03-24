{
    "Statement": [
        {
            "Action": "eks:UpdateClusterVersion",
            "Effect": "Allow",
            "Resource": "arn:aws:eks:*:848481299679:cluster/eks-${environment}-env"
        }
    ],
    "Version": "2012-10-17"
}