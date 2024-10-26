#!/bin/bash
export AWS_DEFAULT_REGION="ap-south-1"

# AWS RDS Instance Identifier
RDS_INSTANCE_ID="dev"

# Scaling up - to 16 CPUs
scale_up() {
  echo "Scaling up to db.r5.4xlarge (16 CPUs)"
  aws rds modify-db-instance \
    --db-instance-identifier $RDS_INSTANCE_ID \
    --db-instance-class db.r5.4xlarge \
    --apply-immediately
}

# Scaling down - to 2 CPUs
scale_down() {
  echo "Scaling down to db.r5.large (2 CPUs)"
  aws rds modify-db-instance \
    --db-instance-identifier $RDS_INSTANCE_ID \
    --db-instance-class db.r5.large \
    --apply-immediately
}

# Schedule based on input arguments
if [ "$1" = "up" ]; then
  scale_up

elif [ "$1" = "down" ]; then
  scale_down

else
  echo "Usage: $0 {up|down}"
  exit 1
fi

