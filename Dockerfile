FROM beakerx/beakerx

MAINTAINER liudonghua123 <liudonghua123@gmail.com>

# not works
#RUN conda install xeus-cling notebook -c QuantStack -c conda-forge -y --quiet

USER root
# install gcc7
RUN add-apt-repository -y ppa:jonathonf/gcc-7.2
RUN apt-get update -y
RUN apt-get install -y gcc-7

# revert to beakerx user
USER beakerx
ARG CLING_FILENAME=cling_2018-09-04_ubuntu16
RUN echo "use ${CLING_FILENAME} for build"
# add the prebuild cling packages
ADD ${CLING_FILENAME}.tar.bz2 /home/beakerx
ENV PATH=/home/beakerx/${CLING_FILENAME}/bin:$PATH
USER root
RUN pip install --upgrade pip
# install steps, https://github.com/root-project/cling/tree/master/tools/Jupyter
RUN cd /home/beakerx/${CLING_FILENAME}/share/cling/Jupyter/kernel && pip install -e . && jupyter-kernelspec install --user cling-cpp17 && jupyter-kernelspec install --user cling-cpp1z && jupyter-kernelspec install --user cling-cpp14 && jupyter-kernelspec install --user cling-cpp11
RUN ln -s /usr/bin/gcc-7 /usr/bin/gcc

RUN echo "root:root" | chpasswd
RUN echo "beakerx:beakerx" | chpasswd
RUN usermod -aG sudo beakerx

RUN echo beakerx | sudo -S chown -R beakerx:beakerx /home/beakerx/
RUN echo beakerx | sudo -S find /home/beakerx/ -type d -exec chmod 755 {} \;
RUN echo beakerx | sudo -S find /home/beakerx/ -type f -exec chmod 644 {} \;

USER beakerx

RUN id
RUn ls -la /home/beakerx/.local
RUn ls -la /home/beakerx/.local/share

#COPY start-notebook.sh /usr/local/bin/start-notebook.sh
#RUN chmod a+x /usr/local/bin/start-notebook.sh

