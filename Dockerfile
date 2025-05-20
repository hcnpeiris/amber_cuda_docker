FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

# Set environment to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install essential system dependencies
RUN apt update && apt install -y \
    tcsh make \
    gcc gfortran g++ \
    flex bison patch bc \
    libbz2-dev libzip-dev \
    xorg-dev wget \
    mpich openssh-client \
    cmake \
    python3 python3-pip \
    git bzip2 csh \
    && apt clean

# Create working directory
WORKDIR /opt/amber
ENV AMBERHOME=/opt/amber

# Copy Amber source tarballs into container (required files)
COPY ambertools25_src ./ambertools25_src
COPY pmemd24_src ./pmemd24_src


# Create build directory and configure with CUDA support
WORKDIR $AMBERHOME/ambertools25_src/build
RUN ./run_cmake && make -j$(nproc) install

WORKDIR $AMBERHOME/pmemd24_src/build
RUN ./run_cmake && make -j$(nproc) install

# Set up environment on container start
RUN echo "source $AMBERHOME/ambertools25/amber.sh" >> /root/.bashrc
RUN echo "source $AMBERHOME/pmemd24/amber.sh" >> /root/.bashrc

# Default command
CMD ["/bin/bash"]

