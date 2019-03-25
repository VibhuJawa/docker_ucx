FROM cudf

ENV CONDA_ENV=cudf

RUN apt install -y autoconf

RUN source activate ${CONDA_ENV} && conda install jupyterlab bokeh
RUN source activate ${CONDA_ENV} && pip install cupy-cuda92

ADD dask-cudf /dask-cudf
#RUN git clone https://github.com/rapidsai/dask-cudf /dask-cudf
WORKDIR /dask-cudf
RUN source activate ${CONDA_ENV} && python setup.py install

#RUN git clone https://github.com/rapidsai/dask-cuda /dask-cuda
ADD dask-cudf /dask-cuda
WORKDIR /dask-cuda
RUN source activate ${CONDA_ENV} && python setup.py install

#ADD gdrcopy /gdrcopy
#WORKDIR /gdrcopy
#RUN make PREFIX=. CUDA=/usr/local/cuda all install

# setup ucx
# ucx-py cloned into ucx-dev-env locally
ADD ucx-dev-env /ucx-dev-env
WORKDIR /ucx-dev-env
RUN make repos
RUN source activate ${CONDA_ENV} && make env
RUN source activate ${CONDA_ENV} && make deps
RUN source activate ${CONDA_ENV} && . activate_ && make ucx/install
RUN source activate ${CONDA_ENV} && . activate_ && make build

WORKDIR /notebooks
CMD source activate ${CONDA_ENV} && . /ucx-dev-env/activate_ && \
    jupyter-lab --allow-root --ip='0.0.0.0' --NotebookApp.token=''