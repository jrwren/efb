# efb - encrypted file backup

Copyright (c) 2014 Jay R. Wren <jrwren@xmtp.net>
GPL3

# efb
---
efb uses your existing gpg keys to encrypt your files to gpg and then upload them to s3.
each file is encrypted individually so that recovery can be performed per file.

## Setup

The script uses the aws command line utility. Configure your ~/.aws/config file.

## IAM

1. Create an IAM user.
1. Write the IAM user credentials to a new profile in ~/.aws/config.
1. Update efb.sh with profile name.
1. Create an S3 bucket.
1. Create a custome IAM policy so that the new user can ONLY RW to that new bucket.
1. Add this IAM policy to the new IAM user's policies.


### Example IAM policy for RW to a bucket named jrwren-backups

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::jrwren-backups"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::jrwren-backups/*"
            ]
        }
    ]
}
```
