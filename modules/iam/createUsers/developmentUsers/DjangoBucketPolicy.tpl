{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                        "s3:GetBucketLocation",
                        "s3:ListAllMyBuckets"
                      ],
            "Resource": "arn:aws:s3:::${djangoBucketNamePublic}"
        },
        {
            "Effect": "Allow",
            "Action": [
                        "s3:GetBucketLocation",
                        "s3:ListAllMyBuckets"
                      ],
            "Resource": "arn:aws:s3:::${djangoBucketNamePrivate}"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${djangoBucketNamePublic}",
                "arn:aws:s3:::${djangoBucketNamePublic}/*",
                "arn:aws:s3:::${djangoBucketNamePrivate}",
                "arn:aws:s3:::${djangoBucketNamePrivate}/*"
            ]
        }
    ]
}