# Database Systems: Design and Implementation

Welcome to **my unofficial** Database Systems: Design and Implementation repository. This repository contains files and resources related to exercises and projects for the Database Systems course.

## Overview

The primary objective of this project is to run the SSB (Star Schema Benchmark) with modifications to various:

- Index structures
- Storage structures

To facilitate this, I provide two Dockerfiles:

1. **Default PostgreSQL**: A standard PostgreSQL setup.
2. **PostgreSQL with Citus Extension**: An enhanced PostgreSQL setup with the Citus extension for distributed database capabilities.

## Getting Started

### Prerequisites

Ensure you have the following installed on your system:

- Docker

### Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/h3nryc0ding/dbdi
   cd dbdi
   ```

2. **Build and Run the Docker Containers**

   Choose the appropriate Dockerfile based on your needs:

   - **Default PostgreSQL**

     ```bash
     docker build --build-arg SCALE=1 -t postgres-default -f Dockerfile.postgres .
     docker run -d --name postgres-default-container postgres-default
     ```

   - **PostgreSQL with Citus Extension**

     ```bash
     docker build --build-arg SCALE=1 -t postgres-citus -f Dockerfile.citus .
     docker run -d --name postgres-citus-container postgres-citus
     ```

    Make sure to replace `SCALE` with the desired scale factor for the SSB benchmark.

### Usage

- Connect to the running PostgreSQL instance:

  ```bash
  docker exec -it <container_name> psql -U postgres
  ```

- Replace `<container_name>` with `postgres-default-container` or `postgres-citus-container` depending on your setup.
