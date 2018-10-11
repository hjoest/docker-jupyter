FROM ubuntu:16.04
MAINTAINER Holger Joest <holger@joest.org>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu xenial main" \
    > /etc/apt/sources.list.d/deadsnakes.list \
    && echo "deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu xenial main" \
    > /etc/apt/sources.list.d/brightbox-ruby-ng-xenial.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C F5DA5F09C3173AA6

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
           automake build-essential ca-certificates etoolbox gcc gfortran git gnumeric \
           gsl-bin libblas-dev libfreetype6-dev libgsl0-dev libjpeg-dev liblapack-dev \
           libpng-dev libpq-dev libtool make mercurial pandoc pandoc-citeproc pkg-config \
           python3.6 python3.6-dev ruby2.5 ruby2.5-dev ssh \
           texlive-latex-recommended texlive-luatex texlive-xetex unzip wget wkhtmltopdf \
    && ln -s python3.6 /usr/bin/python3 \
    && apt-get autoremove \
    && apt-get clean


RUN cd /tmp \
    && wget --quiet https://bootstrap.pypa.io/get-pip.py \
    && python3 ./get-pip.py \
    && rm -f ./get-pip.py

RUN pip3 install -U numpy==1.15
RUN pip3 install -U scipy==1.1.0
RUN pip3 install -U scikit-learn==0.20.0
RUN pip3 install -U tensorflow==1.11
RUN pip3 install -U keras==2.2.4
RUN pip3 install -U sympy==1.3
RUN pip3 install -U pandas==0.23.2
RUN pip3 install -U nltk==3.3
RUN pip3 install -U matplotlib==3.0.0
RUN pip3 install -U statsmodels==0.8
RUN pip3 install -U scikit-image==0.14.1
RUN pip3 install -U pexpect==4.6
RUN pip3 install -U pyqtgraph==0.10.0
RUN pip3 install -U docutils==0.14
RUN pip3 install -U xlrd==1.1.0
RUN pip3 install -U joblib==0.11
RUN pip3 install -U chardet==3.0.4
RUN pip3 install -U Bottlechest==0.7.1
RUN pip3 install -U ipython==7.0.1
RUN pip3 install -U notebook==5.7.0
RUN pip3 install jupyter_client==5.2.3
RUN pip3 install -U pyyaml==3.13
RUN pip3 install -U h5py==2.8.0

RUN pip3 install -U thrift==0.11.0
RUN pip3 install -U happybase==1.1.0

RUN pip3 install -U xlsxwriter==1.1.1
RUN pip3 install bash_kernel==0.7.1
RUN python3 -m bash_kernel.install

# TODO: spark mllib

ENV LD_LIBRARY_PATH /var/lib/gems/2.5.0/gems/rbczmq-1.7.9/ext/rbczmq/dst/lib/
RUN ln -s /usr/bin/libtoolize /usr/bin/libtool \
    && gem install rbczmq -v 1.7.9 \
    && gem install iruby -v 0.2.9

RUN cd /usr/local/lib/python3.6/dist-packages/notebook/static/components \
    && wget --quiet https://github.com/mathjax/MathJax/archive/2.7.5.zip \
    && rm -rf MathJax && unzip MathJax-2.7.5.zip && mv -f MathJax-2.7.5 MathJax

RUN cd /tmp && wget --quiet https://github.com/damianavila/RISE-5.4.1.zip \
    && unzio RISE-5.4.1.zip && cd RISE-5.4.1/ && python3 setup.py install

RUN useradd notebook && mkdir /home/notebook /notebook \
    && chown notebook /home/notebook /notebook
USER notebook
WORKDIR /notebook
RUN iruby register

EXPOSE 8888
VOLUME [ "/notebook" ]

CMD [ "sh", "-c", "jupyter notebook --no-browser --ip=0.0.0.0 --port=8888 --notebook-dir=/notebook" ]
