docker run --net=host --privileged -p 8888:8888 -p 8787:8787 \
  -v /raid:/data -v /home/rgelhausen/projects/notebooks:/notebooks
  -it ucx bash
