# Troubleshooting Guide

1. Pod is in CrashLoopBackOff. What do you check?
Answer:
- Check the pod logs using 'kubectl logs'.
- Run 'kubectl describe pod' to view events.
- Verify ConfigMaps, Secrets, and environment variables.
- Ensure the application starts correctly and is not crashing.

2. Deployment is successful, but the application is not reachable. What do you check?
Answer:
- Verify the pod is running and ready.
- Check the Service configuration and ports.
- Verify the Ingress configuration.
- Confirm the Load Balancer and DNS are working correctly.

3. Difference between readiness and liveness probe?
Answer:
- Readiness Probe checks if the application is ready to receive traffic.
- Liveness Probe checks if the application is healthy. If it fails, Kubernetes restarts the container.

4. Docker build works locally but fails in the pipeline. Why?
Answer:
- Check for missing files.
- Verify Dockerfile paths.
- Ensure all environment variables and secrets are available.
- Check dependency or Docker version differences.

5. Pipeline fails during Docker build. What do you check?
Answer:
- Review the pipeline logs to identify the exact error.
- Check the Dockerfile syntax and build commands.
- Verify the build context and required files are present.
- Ensure the base image can be pulled successfully.
- Verify environment variables or secrets required during the build.

6. Certificate renewal failed. What do you check?
Answer:
- Check the certificate expiration date.
- Verify DNS records.
- Review cert-manager..
- Confirm the Ingress configuration.

7. Ingress returns 502 or 504. What do you check?
Answer:*
- Check if backend pods are healthy.
- Verify the Service name and target port.
- Ensure the application is listening on the correct port.
- Review Ingress controller logs.

8. Vendor SFTP connection to port 22 times out. What do you check?
Answer:
- Verify Security Group and firewall rules.
- Ensure port 22 is open for vendor.
- Check if the SSH service is running.
- Confirm the server IP address is correct.

9. Terraform plan wants to recreate the cluster. What do you check?
Answer:
- Review the 'terraform plan' output carefully.
- Check for changes to immutable resources.
- Verify the Terraform state file.
- Ensure no manual infrastructure changes were made.

10. How would you upgrade AKS/EKS safely?
Answer:
- Upgrade the control plane first.
- Upgrade the worker nodes or node groups.
- Use rolling updates.
- Verify the application after the upgrade.

11. Frontend loads, but backend API calls fail. What do you check?
Answer:
- Verify the backend Service and Ingress.
- Check the backend pod logs.
- Confirm the API URL is correct.

12. Backend pod is running, but database connection times out. What do you check?
Answer:
- Verify the database endpoint and port.
- Check Security Group rules.
- Verify database credentials.
- Ensure the database is running and reachable.

13. Private DNS is not resolving the database hostname. What do you check?
Answer:
- Verify that VPC DNS support and DNS hostnames are enabled.
- Check that the private hosted zone is associated with the correct VPC.
- Verify the database endpoint is correct.
- Test DNS resolution from an EKS worker node or pod using 'nslookup' or 'dig'.

14. How would you rotate database credentials safely?
Answer:
- Create new database credentials.
- Update Kubernetes Secrets or AWS Secrets Manager or Server Env .
- Restart the backend deployment/service.
- Verify the application connects successfully before removing the old credentials.

15. Secrets were accidentally committed to GitHub. What do you do?
Answer:
- Revoke the exposed credentials immediately.
- Generate new credentials or keys.
- Update the application to use the new credentials.
- Remove the secrets from the Git history using tools such as git filter-repo or BFG Repo-Cleaner.
- Force push the cleaned repository if appropriate.
- Store secrets securely in GitHub Secrets, AWS Secrets Manager, or Kubernetes Secrets instead of the repository.
- Verify that the old credentials are no longer valid and monitor for any unauthorized access.