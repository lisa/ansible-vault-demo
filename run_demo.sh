#!/bin/bash

set -x
echo "Running demo"

ansible-playbook -i hosts site.yaml

if [[ $? == 0 ]]; then
  echo "Demo completed successfully!"
  echo "Contents of the rendered full-sample.ini:"
  cat output/full-sample.ini
  echo
  echo
  
  echo "Contents of the rendered partial-sample.ini"
  cat output/partial-sample.ini
  echo
  echo
  
  echo "Contents of the book.txt"
  cat output/book.txt
  echo
  echo
else
  echo "Uh oh! There was a problem running the playbook :("
fi