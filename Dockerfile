From rapidsai/rapidsai-nightly:0.6-cuda9.2-base-ubuntu16.04-gcc5-py3.7
ENV CONDA_ENV=rapids

RUN apt-get update
RUN apt install -y autoconf

RUN source activate ${CONDA_ENV} && conda install jupyterlab bokeh
RUN source activate ${CONDA_ENV} && pip install cupy-cuda92

ADD ucx-dev-env /ucx-dev-env

WORKDIR /ucx-dev-env
RUN make repos
RUN source activate ${CONDA_ENV} && make env
RUN source activate ${CONDA_ENV} && make deps
RUN source activate ${CONDA_ENV} && . activate_ && make ucx/install
RUN source activate ${CONDA_ENV} && . activate_ && make build

WORKDIR /notebooks
CMD source activate ${CONDA_ENV} && . /ucx-dev-env/activate_ && \
    jupyter-lab --allow-root --ip='0.0.0.0' --port=9888 --NotebookApp.token=''
