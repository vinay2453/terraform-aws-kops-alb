## Environment specific values.

# Domain name for the external ALB.
kubernetes_ingress_domain=dev.example.com

# Kubernetes cluster name.
kubernetes_cluster_name=hello.k8s.local

# Bucket name for state store of kops and Terraform.
state_store_bucket_name="state.$kubernetes_cluster_name"

# AWS Profile.
export AWS_PROFILE=example

# AWS Region.
export AWS_DEFAULT_REGION=us-west-2

# AWS Availability Zones.
# Note: RDS and ALB requires multiple zones.
export KOPS_CLUSTER_ZONES="${AWS_DEFAULT_REGION}a,${AWS_DEFAULT_REGION}c"

# Load environment values excluded from VCS
if [ -f .env ]; then
  source .env
fi



## Environment variables for tools.

# kops
export KOPS_STATE_STORE="s3://$state_store_bucket_name"
export KOPS_CLUSTER_NAME="$kubernetes_cluster_name"

# Terraform
export TF_VAR_state_store_bucket_name="$state_store_bucket_name"
export TF_VAR_kubernetes_ingress_domain="$kubernetes_ingress_domain"
export TF_VAR_kubernetes_cluster_name="$kubernetes_cluster_name"

# kubectl
export KUBECONFIG="$(cd $(dirname -- "$0") && pwd)/.kubeconfig"

# Use binaries in .bin
export PATH="$(cd $(dirname -- "$0") && pwd)/.bin:$PATH"