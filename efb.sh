#!/bin/bash
set -evx

BASEDIR=/
DIRS="Photos Videos"
GPGUSER=jrwren
S3BUCKET=jrwren-backups
PROFILE=efb

pushd $BASEDIR
for dir in $DIRS; do
find $dir -not -name .Parent -not -path 'iPod Photo Cache' -type f | while read file ; do
[[ -z `aws --profile $PROFILE s3 ls "s3://$S3BUCKET/$file.gpg"` ]] && (
gpg --encrypt-files -r "$GPGUSER" "$file"
aws --profile $PROFILE s3 cp "$file.gpg" "s3://$S3BUCKET/$file.gpg"
rm "$file.gpg"
) || echo "$file" exists
done
done
popd
