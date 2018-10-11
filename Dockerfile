FROM ubuntu:20.04
MAINTAINER Holger Joest <holger@joest.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
           automake build-essential ca-certificates gcc gfortran git gnumeric \
           gsl-bin libblas-dev libfreetype6-dev libgsl0-dev libjpeg-dev liblapack-dev \
           libpng-dev libpq-dev libtool make mercurial pandoc pandoc-citeproc pkg-config \
           python3.8 python3.8-dev python3-pip ruby2.7 ruby2.7-dev ssh \
           texlive-latex-recommended texlive-luatex texlive-xetex unzip wget wkhtmltopdf \
    && apt-get autoremove \
    && apt-get clean

RUN pip3 install -U numpy==1.19
RUN pip3 install -U scipy==1.4.1
RUN pip3 install -U scikit-learn==0.23.1
RUN pip3 install -U tensorflow==2.2
RUN pip3 install -U keras==2.4.0
RUN pip3 install -U sympy==1.6
RUN pip3 install -U pandas==1.0.5
RUN pip3 install -U nltk==3.5
RUN pip3 install -U matplotlib==3.2.2
RUN pip3 install -U scikit-image==0.17.2
RUN pip3 install -U pexpect==4.8
RUN pip3 install -U pyqtgraph==0.11.0
RUN pip3 install -U docutils==0.16
RUN pip3 install -U xlrd==1.2.0
RUN pip3 install -U joblib==0.14.1
RUN pip3 install -U chardet==3.0.4
RUN pip3 install -U bottleneck==1.3.2
RUN pip3 install -U protobuf==3.12.2
RUN pip3 install -U ipython==7.12.0
RUN pip3 install -U notebook==6.0.3
RUN pip3 install -U jupyter_client==6.1.3
RUN pip3 install -U pyyaml==5.3.1
RUN pip3 install -U h5py==2.10.0
RUN pip3 install -U thrift==0.13.0
RUN pip3 install -U happybase==1.2.0
RUN pip3 install -U xlsxwriter==1.1.4
RUN pip3 install -U RISE==5.6.1
RUN pip3 install -U Cython==0.29.20
RUN pip3 install -U qutip==4.5.1
RUN pip3 install -U statsmodels==0.9
RUN pip3 install -U cirq==0.8.1
RUN pip3 install -U qiskit-terra==0.14.2
RUN pip3 install -U qiskit-aer==0.5.2
RUN pip3 install -U qiskit-ignis==0.3.3
RUN pip3 install -U qiskit-aqua==0.7.3

RUN useradd notebook && mkdir /home/notebook /notebook \
    && chown notebook /home/notebook /notebook
USER notebook
WORKDIR /notebook

EXPOSE 8888
VOLUME [ "/notebook" ]

CMD [ "sh", "-c", "jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --notebook-dir=/notebook" ]
