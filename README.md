# Terraform template for AWS EKS with Fargate profile

This terraform template can be used to setup the AWS infrastructure
for a dockerized application running on EKS with a Fargate profile.

Ingress is based on <https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html>
and <https://medium.com/@marcincuber/amazon-eks-with-oidc-provider-iam-roles-for-kubernetes-services-accounts-59015d15cb0c>.

Due to the fact that EKS with Fargate profiles is not yet supported in all regions
(<https://docs.aws.amazon.com/eks/latest/userguide/fargate.html>) this template uses
the `us-east-2`region.

## Known limitations

* Although the namespace `default` is set in the fargate profile (meaning
pods will be executed on managed nodes), CoreDNS can currently only run
on a fargate profile if the CoreDNS deployment is patched after the
cluster is created (see <https://github.com/terraform-providers/terraform-provider-aws/issues/11327>
or <https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html#fargate-gs-coredns>
for instructions). Therefore this template also creates a node-group for the `kube-system`
namespace, which is also used for the Ingress controller.

* By default the `config` file for `kubectl` is created in `~/.kube` directory. If any
configuration already exists there, it will be overwritten! To preserve any pre-existing
configuration, change the `kubeconfig_path` variable.

## Getting Started

1. fully configured vault cloud
2. setup terraform cloud
   1. TF Cloud must be set to local execution bc we wont be executing on tf cloud. If set to remote then only env vars set on tf cloud will be used, which is very annoying.
3. add secrets to github
