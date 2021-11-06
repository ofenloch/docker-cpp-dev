# C++ Development Container base on Debian 11.1

## Build the Image and run a Container

To build the image run

`docker build -t cpp-dev:0.0.1 .`


To test / use the image (i.e. run a container) do something like this

`docker run --rm -it -v $(pwd):/project cpp-dev:0.0.1 "ls -hal /project"`


## Example Use Case

This project contains a copy of of [Jim Kirkbride](https://github.com/jameskbride)'s project 
[cmake-hello-world](https://github.com/jameskbride/cmake-hello-world.git) at 
(GitHub)[https://github.com/] as an example for developing a CMake project.

Call

`docker run --rm -v $(pwd):/project cpp-dev:0.0.1 "cd /project/cmake-hello-world && cmake -S . -B build && cmake --build build"`

to build [Jim Kirkbride](https://github.com/jameskbride)'s project inside the container.
