#!/bin/bash

# This script creates a custom dump of the PostgreSQL database and uploads it to S3.
dump_name="dump_$(date +%Y%m%d%H%M%S).custom"

# generate custom dump
docker exec -i "$PGCONTAINERNAME" /bin/bash -c "pg_dump -Fc --username $PGUSERNAME $PGDBNAME" > "$dump_name"

# compress and send to S3
gzip "$dump_name"
aws s3 cp "$dump_name.gz" "s3://$S3BUCKETNAME/$dump_name.gz"

# remove local dump file
rm "$dump_name.gz"
