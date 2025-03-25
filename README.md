# CI/CD Automated Pipeline

## Project Overview

This project implements a CI/CD pipeline using Jenkins, SonarQube, and Docker to automate the software development lifecycle. The infrastructure is hosted on AWS EC2 instances, where virtual machines (VMs) are launched to support the pipeline.   
Credit: I did not write the HTML/CSS code for the website, credit goes to https://www.free-css.com/free-css-templates :)

## Technologies Used

1. **Jenkins** – Automates the CI/CD pipeline

1. **SonarQube** – Code quality analysis

1. **Docker** – Containerization for application deployment

1. **Terraform** – Infrastructure as Code (IaC) for AWS provisioning

1. **AWS EC2** – Virtual machines to run Jenkins, SonarQube, and other components

1. **Git** – Version control for source code

## Jenkins Pipeline Workflow

### The Jenkins pipeline follows these steps:

1. Trigger on Git Push – The pipeline starts when a commit is pushed to the repository.

1. Code Check – The pipeline verifies the code for errors and best practices.

1. SonarQube Analysis – Runs SonarQube to analyze HTML, CSS, and Terraform (.tf) files.

1. Docker Image Creation – If the code passes checks, it is packaged into a Docker image.

1. Build & Deployment – The Docker image is built and deployed, making the application accessible to users.

## SonarQube Analysis

- Analyzes HTML, CSS, and Terraform (.tf) files for quality and security vulnerabilities.

- Additional checks can be configured in SonarQube as needed.

Infrastructure Setup

The project requires the following AWS setup:

- EC2 instances to run Jenkins, SonarQube, and other services.

- SSH Keys to securely access VMs.

- AWS SDK and CLI for managing AWS resources.

### Deployment Steps

  ```
  # Provision AWS Resources
  terraform apply

  # Install and Configure Jenkins
  sudo apt update && sudo apt install jenkins -y

  # Install and Configure SonarQube
  sudo apt update && sudo apt install sonarqube -y

  # Configure Jenkins Pipeline
  # Define pipeline stages in Jenkinsfile
  ```
1. **Provision AWS Resources**  
- Use Terraform to create EC2 instances.  
- Configure security groups and networking.  
- Install and Configure Jenkins  

2. **Install Jenkins on an EC2 instance.**
- Set up the necessary plugins (Git, Docker, SonarQube Scanner).  

3. **Set Up SonarQube**
- Install SonarQube on another EC2 instance.  
- Configure Jenkins to connect to SonarQube for code analysis.   

4. **Create and Configure the Jenkins Pipeline**   
- Define the pipeline stages in Jenkinsfile.   
- Integrate Git, Docker, and SonarQube.

5. **Push Code to Git**   
- Trigger the Jenkins pipeline with a commit.   

6. **Monitor Pipeline Execution**
- Ensure successful builds, SonarQube scans, and Docker deployments.   

## Future Improvements   
- Add more SonarQube rules for advanced security and quality checks.   
- Implement automated testing within the pipeline.   
- Deploy the application using Kubernetes instead of standalone Docker containers.   
- Introduce AWS CodePipeline for further automation and scalability.   
