{
    "Statement": [
        {
            "Action": "eks:*",
            "Effect": "Allow",
            "Resource": [
                "arn:aws:eks:eu-west-1:848481299679:cluster/eks-${environment}-env",
                "arn:aws:eks:eu-west-1:848481299679:nodegroup/eks-${environment}-env/node-group-${environment}-env/*"
            ],
            "Sid": "eksadministrator"
        }
    ],
    "Version": "2012-10-17"
}