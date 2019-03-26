docker run --runtime=nvidia --rm -it -p 9888:9888 -p 9787:9787 -p 9786:9786  -p 9800:9800 \
-v /raid/walmart/vibhu:/rapids/vibhu \
-it docker_ucx
