#!/usr/bin/env bash
aws ec2 describe-images \
  --owners aws-marketplace \
  --filters Name=product-code,Values=aw0evgk8e5c1q413zgy5pjce \
  --query 'Images[*].[CreationDate,Name,ImageID]' \
  --filters "Name=name,Values=$1*" \
  --region eu-west-1 \
  --output table \
  | sort -r
