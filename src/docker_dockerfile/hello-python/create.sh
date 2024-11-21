#!/bin/bash

### DESCRIPTION: Creates static resources such as Dockerfiles

# Writing a Dockerfile
content="
FROM ubuntu\n
LABEL name="learning-docker"\n
RUN apt-get update\n
RUN apt-get install -y python3\n
ADD hello.py /home/hello.py\n
ADD a.py /home/a.py\n
CMD [\"/home/hello.py\"]\n
ENTRYPOINT [\"python3\"]\n
"

echo -en "" $content | sed 's/ //' > Dockerfile

# Writing python files
echo -e "print (\"Hello World\")" > hello.py
echo -e "print (\"Overriden World\")" > a.py
