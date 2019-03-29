git clone https://github.com/VibhuJawa/ucx-dev-env.git
cd ucx-dev-env
git clone https://github.com/Akshay-Venkatesh/ucx-py  --branch /topic/tcpcm
cd ..
docker build -t docker_ucx .
