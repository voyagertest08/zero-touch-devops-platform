resource "aws_route53_record" "app" {
  zone_id = var.hosted_zone_id
  name    = "${var.app_name}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60
  records = [aws_eks_cluster.cluster.endpoint]
}
