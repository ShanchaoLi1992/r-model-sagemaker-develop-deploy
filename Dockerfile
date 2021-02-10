FROM ubuntu:20.04

MAINTAINER ShanchaoLi
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

RUN apt-get -y update && apt-get install -y --no-install-recommends \
    wget \
    r-base \
    r-base-dev \
    apt-transport-https \
    ca-certificates

RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libsodium-dev

#RUN R -e "install.packages('plumber', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/mda/mda_0.4-10.tar.gz', repos = NULL, type='source')"
RUN R -e "install.packages('jsonlite', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('plumber')"

COPY mars.R /opt/ml/mars.R
COPY plumber.R /opt/ml/plumber.R

#ENTRYPOINT ["/usr/bin/Rscript", "/opt/ml/mars.R", "--no-save"]
