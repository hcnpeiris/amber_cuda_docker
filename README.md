# Amber24 and AmberTools25 with CUDA - Docker Build

This repository contains a simple Dockerfile to build a containerized CUDA-accelerated version of Amber24 and AmberTools25.  
The container includes all necessary tools and dependencies required to compile and run Amber.

## Requirements

- Amber24 and AmberTools25 source code  
  [Download from official Amber website](https://ambermd.org/GetAmber.php)
- Docker installed  
  [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- NVIDIA GPU with drivers  
  [Install NVIDIA Drivers on Ubuntu](https://documentation.ubuntu.com/server/how-to/graphics/install-nvidia-drivers/index.html)
- NVIDIA Container Toolkit  
  [Install NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.htmlinstallation)

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/hcnpeiris/amber_cuda_docker.git
   cd amber_cuda_docker
   ```

2. Move the AmberTools25 and Amber24 source archives into this directory, then extract them.  
   This will create `ambertools25_src` and `pmemd24_src` directories:

   ```bash
   tar xvfj ambertools25.tar.bz2
   tar xvfj pmemd24.tar.bz2
   ```

3. Enable CUDA support in both build scripts:  
   - Open `ambertools25_src/build/run_cmake` and change `DCUDA=False` to `DCUDA=TRUE`  
   - Open `pmemd24_src/build/run_cmake` and change `DCUDA=False` to `DCUDA=TRUE`

## Build the Image

```bash
sudo docker build -t amber_cuda .
```

## Run the Container

```bash
sudo docker run --gpus all -it amber_cuda
```

## Notes

- No need to manually install any dependencies — everything is handled during the Docker image build process.
