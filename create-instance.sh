#!/bin/bash

LID="lt-0c74196d9abfd39e2"
LVER=1

aws ec2 run-instances --launch-template LaunchTemplateId=$LID,Version=$LVER | jq