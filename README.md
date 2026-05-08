# Terraform EC2 Deployment

This project provisions an EC2 instance using Terraform, downloads the `server.rb` application from an S3 bucket, and exposes the application on port `8080`.

## Deployment

The infrastructure was deployed locally using:

```bash
terraform apply -var-file=envs/dev/dev.tfvars
```

After validation and testing were completed, all infrastructure resources were destroyed using:

```bash
terraform destroy -var-file=envs/dev/dev.tfvars
```

## Evidence

### EC2 Instance Information

The EC2 instance details were captured using:

```bash
aws ec2 describe-instances \
 --filters Name=tag:Name,Values=<your-instance-name> \
 --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]' \
 --output table
```

Rendered evidence file:

```text
{{ contents of evidence/instance.txt }}
```

Screenshot evidence:

![Describe Instances](evidence/describe-instance.png)

---

### Health Endpoint Verification

The following command was executed to verify the application health endpoint:

```bash
curl http://<instance-ip>:8080/health
```

Expected response:

```json
{"compute":"ec2","status":"ok"}
```

Verification screenshot:

![Health Endpoint](evidence/health.png)

---

### Echo Endpoint Verification

The following command was executed to verify the echo endpoint:

```bash
curl -X POST http://<instance-ip>:8080/echo \
 -H 'Content-Type: application/json' \
 -d '{"msg":"hello"}'
```

Expected response:

```json
{"compute":"ec2","msg":"hello"}
```

Verification screenshot:

![Echo Endpoint](evidence/echo.png)