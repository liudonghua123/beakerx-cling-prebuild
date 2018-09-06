# beakerx-cling

Docker files for a docker image which integrate beakerx and cling to provide almost all the popular language support to jupyter. 

This image is simply an installation of [cling](https://github.com/root-project/cling/tree/master/tools/Jupyter) based on [beakerx](https://github.com/twosigma/beakerx).

### How to build it

1. Clone the repo
    `git clone https://github.com/liudonghua123/beakerx-cling-prebuild`
2. Download prebuild cling on [https://root.cern.ch/download/cling/](https://root.cern.ch/download/cling/)
3. Run `docker-compose build`

### How to run it

1. Using docker command to run it
    `docker run -d -p 8888:8888 liudonghua123/beakerx-cling-prebuild`
2. Using docker-compose command to run it (prefered)
    write a docker-compose.yml which contains like
    ```
	version: '2'

	services:
	    beakerx-cling-prebuild:
	        image: liudonghua123/beakerx-cling-prebuild:latest
	        ports:
	            - "8888:8888"
	        restart: always
    ```

### License

MIT
