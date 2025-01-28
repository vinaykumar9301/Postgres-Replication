# PostgreSQL Primary and Read Replica with Automatic Failover

This project sets up a PostgreSQL Primary and Read Replica using Docker Compose, ensuring proper replication configuration and automatic failover. The project includes a failover manager that uses **Keepalived** to handle failover in case the primary database goes down. The application will automatically switch to the new primary without requiring manual intervention.

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Setup](#setup)
4. [Environment Variables](#environment-variables)
5. [Services](#services)
6. [Failover Configuration](#failover-configuration)
7. [Usage](#usage)
8. [Best Practices](#best-practices)

## Overview

This project provides a reliable and scalable PostgreSQL database setup with replication and automatic failover for high availability. It uses **Docker** for containerization and **Docker Compose** to manage the deployment of multiple containers including:

- **Primary Database**: The master PostgreSQL database that handles all write operations.
- **Replica Database**: A read-only copy of the primary database to scale read operations.
- **Failover Manager**: A **Keepalived** manager to automatically handle failover and switch to the replica in case of failure of the primary database.

## Architecture

- **PostgreSQL Primary**: Handles write operations and replication to the replica.
- **PostgreSQL Replica**: A read-only copy of the primary that replicates data from the primary in real-time.
- **Failover**: Uses **Keepalived** to monitor the health of the primary and manage the failover process.
- **Environment Variables**: Used to securely manage database credentials and replication configurations.

## Setup

### Prerequisites
- Install **Docker** and **Docker Compose** on your local machine or server.
- Ensure that Docker is running before starting the containers.

### Steps to Run the Project

1. Clone the repository:
    ```bash[
    git clone https://github.com/vinaykumar9301/Postgres-Replication
    cd postgres-replication
    ```

2. Configure the environment variables in the `.env` file:
    ```bash
    touch .env
    ```

    Add the following values:
    ```env
    POSTGRES_USER=your_username
    POSTGRES_PASSWORD=your_password
    POSTGRES_DB=your_database
    REPLICATION_USER=replication_user
    REPLICATION_PASSWORD=replication_password
    ```

3. Build and start the containers using Docker Compose:
    ```bash
    docker-compose up -d --build
    ```

4. Verify that all containers are up and running:
    ```bash
    docker ps
    ```

## Environment Variables

These environment variables are used in the `docker-compose.yml` file to configure the PostgreSQL databases and replication:

- `POSTGRES_USER`: The default PostgreSQL user for accessing the database.
- `POSTGRES_PASSWORD`: The password for the `POSTGRES_USER`.
- `POSTGRES_DB`: The name of the database to be created.
- `REPLICATION_USER`: The user used for database replication.
- `REPLICATION_PASSWORD`: The password for the replication user.

Ensure you add these variables in the `.env` file.

## Services

### 1. **Primary PostgreSQL Database**
   - **Service Name**: `primary`
   - **Port**: `5432`
   - **Role**: Handles write operations and replicates data to the replica.

### 2. **Replica PostgreSQL Database**
   - **Service Name**: `replica`
   - **Port**: `5432`
   - **Role**: Read-only replica of the primary database, handling read operations.

### 3. **Failover Manager**
   - **Service Name**: `failover`
   - **Role**: Monitors the health of the primary database and handles failover using **Keepalived**.

## Failover Configuration

The **Keepalived** service manages failover between the primary and replica databases. If the primary database goes down, **Keepalived** will automatically promote the replica to be the new primary, ensuring continuous availability. The failover configuration is defined in the `keepalived.conf` file.

### Failover Process:
1. **Primary goes down**: The failover manager detects the failure.
2. **Replica promotion**: The replica becomes the new primary database.
3. **Application connection**: The application reconnects to the new primary database seamlessly without manual intervention.

## Usage

1. Once the containers are up and running, you can connect to the databases via `psql` or any PostgreSQL client.
2. Test failover by stopping the primary container:
   ```bash
   docker-compose stop postgres-primary
