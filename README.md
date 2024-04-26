# hlog logging under Docker

The `hlog` program by Josef "Jeff" Sipek sparked my interest as a text-only 
(console) logging solution. It offers contesting definitions built in `lua` 
which is a potential path for a contesting specification that I have been
working on.

* [Josef "Jeff" Sipek](https://www.josefsipek.net/) home-page
* [Contesting Specification](https://github.com/vk6flab/amateur-contesting-standard)

This repository shows the steps I used to compile the application inside a
Docker container. Some of the documentation was not (quite) complete and there
were a few bugs to deal with. I spent about a day in total making this work, but
could not have achieved this without the assistance of Jeff who fixed a few
issues.

# Build
To use this tool, you can build it with docker after cloning this repo:

* `docker build -t local/hlog .`

# Usage
The container can launch either `hlog` or `hlog-contest`, depending on an
optional parameter.

## Parameters
You can supply one optional parameter after the name of the container.

If you supply no parameters, the executable launched is `hlog`. If you specify
precisely one parameter, the name of the contest, the executable launched is
`hlog-contest`.

### Command to launch `hlog`
* `docker run --rm -v"$(pwd)":"$(pwd)" -w"$(pwd)" -it local/hlog:latest`

### Command to launch `hlog-contest`
* `docker run --rm -v"$(pwd)":"$(pwd)" -w"$(pwd)" -it local/hlog:latest` contest-name 

# Data directory
`hlog` and `hlog-contest` require a data directory. If it does not exist in the
current directory, it is created before launch. You can edit this using the
instructions in the supplied `README` file. The syntax used is `lua`.

## First Run
On first run the `entry-point.sh` script checks to see if a directory called 
`./hlog` exists. If not, it populates it with the default settings from the 
`hlog` initialisation script. After downloading the `pota_parks.csv`, `cty.csv` 
and `sota_summits.csv`, it also copies the `hlog` supplied `README` file into 
the same directory. Then it launches `hlog`.

## Next Run
On second run, after detecting the directory called `./hlog`, it launches `hlog`.

# Note
It appears that to exit, you should use `Control-C`.

# Further reading
Use the information in the `README` file to configure your station.

# Sources
* https://www.josefsipek.net/projects/hlog/
* https://sr.ht/~jeffpc/libjeffpc/

# Author
Onno VK6FLAB <cq@vk6flab.com>
