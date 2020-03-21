locals {
  cluster_name                 = "tajuddinmunshi.com"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-eu-west-2a-masters-tajuddinmunshi-com.id]
  master_security_group_ids    = [aws_security_group.masters-tajuddinmunshi-com.id]
  masters_role_arn             = aws_iam_role.masters-tajuddinmunshi-com.arn
  masters_role_name            = aws_iam_role.masters-tajuddinmunshi-com.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-tajuddinmunshi-com.id]
  node_security_group_ids      = [aws_security_group.nodes-tajuddinmunshi-com.id]
  node_subnet_ids              = ["subnet-04fea41334cc65992", "subnet-0d0d06a790b4ee7a4", "subnet-0ff8a5f1ef972fb1c"]
  nodes_role_arn               = aws_iam_role.nodes-tajuddinmunshi-com.arn
  nodes_role_name              = aws_iam_role.nodes-tajuddinmunshi-com.name
  region                       = "eu-west-2"
  subnet_eu-west-2a_id         = "subnet-0ff8a5f1ef972fb1c"
  subnet_eu-west-2b_id         = "subnet-0d0d06a790b4ee7a4"
  subnet_eu-west-2c_id         = "subnet-04fea41334cc65992"
  subnet_ids                   = ["subnet-032a506f23b11947c", "subnet-038650217a19af8da", "subnet-04fea41334cc65992", "subnet-0d0d06a790b4ee7a4", "subnet-0f83aaa78093386f3", "subnet-0ff8a5f1ef972fb1c"]
  subnet_utility-eu-west-2a_id = "subnet-0f83aaa78093386f3"
  subnet_utility-eu-west-2b_id = "subnet-038650217a19af8da"
  subnet_utility-eu-west-2c_id = "subnet-032a506f23b11947c"
  vpc_id                       = "vpc-0446a3317146482f8"
}

output "cluster_name" {
  value = "tajuddinmunshi.com"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-eu-west-2a-masters-tajuddinmunshi-com.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-tajuddinmunshi-com.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-tajuddinmunshi-com.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-tajuddinmunshi-com.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-tajuddinmunshi-com.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-tajuddinmunshi-com.id]
}

output "node_subnet_ids" {
  value = ["subnet-04fea41334cc65992", "subnet-0d0d06a790b4ee7a4", "subnet-0ff8a5f1ef972fb1c"]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-tajuddinmunshi-com.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-tajuddinmunshi-com.name
}

output "region" {
  value = "eu-west-2"
}

output "subnet_eu-west-2a_id" {
  value = "subnet-0ff8a5f1ef972fb1c"
}

output "subnet_eu-west-2b_id" {
  value = "subnet-0d0d06a790b4ee7a4"
}

output "subnet_eu-west-2c_id" {
  value = "subnet-04fea41334cc65992"
}

output "subnet_ids" {
  value = ["subnet-032a506f23b11947c", "subnet-038650217a19af8da", "subnet-04fea41334cc65992", "subnet-0d0d06a790b4ee7a4", "subnet-0f83aaa78093386f3", "subnet-0ff8a5f1ef972fb1c"]
}

output "subnet_utility-eu-west-2a_id" {
  value = "subnet-0f83aaa78093386f3"
}

output "subnet_utility-eu-west-2b_id" {
  value = "subnet-038650217a19af8da"
}

output "subnet_utility-eu-west-2c_id" {
  value = "subnet-032a506f23b11947c"
}

output "vpc_id" {
  value = "vpc-0446a3317146482f8"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_autoscaling_attachment" "master-eu-west-2a-masters-tajuddinmunshi-com" {
  elb                    = aws_elb.api-tajuddinmunshi-com.id
  autoscaling_group_name = aws_autoscaling_group.master-eu-west-2a-masters-tajuddinmunshi-com.id
}

resource "aws_autoscaling_group" "master-eu-west-2a-masters-tajuddinmunshi-com" {
  name                 = "master-eu-west-2a.masters.tajuddinmunshi.com"
  launch_configuration = aws_launch_configuration.master-eu-west-2a-masters-tajuddinmunshi-com.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["subnet-0ff8a5f1ef972fb1c"]

  tag {
    key                 = "KubernetesCluster"
    value               = "tajuddinmunshi.com"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "master-eu-west-2a.masters.tajuddinmunshi.com"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "master-eu-west-2a"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-tajuddinmunshi-com" {
  name                 = "nodes.tajuddinmunshi.com"
  launch_configuration = aws_launch_configuration.nodes-tajuddinmunshi-com.id
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["subnet-0ff8a5f1ef972fb1c", "subnet-0d0d06a790b4ee7a4", "subnet-04fea41334cc65992"]

  tag {
    key                 = "KubernetesCluster"
    value               = "tajuddinmunshi.com"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "nodes.tajuddinmunshi.com"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  tag {
    key                 = "kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-tajuddinmunshi-com" {
  availability_zone = "eu-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "a.etcd-events.tajuddinmunshi.com"
    "k8s.io/etcd/events"                       = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-tajuddinmunshi-com" {
  availability_zone = "eu-west-2a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "a.etcd-main.tajuddinmunshi.com"
    "k8s.io/etcd/main"                         = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_elb" "api-tajuddinmunshi-com" {
  name = "api-tajuddinmunshi-com-vvp16n"

  listener {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = [aws_security_group.api-elb-tajuddinmunshi-com.id, "sg-005cf78e464d96472"]
  subnets         = ["subnet-032a506f23b11947c", "subnet-038650217a19af8da", "subnet-0f83aaa78093386f3"]

  health_check {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  cross_zone_load_balancing = false
  idle_timeout              = 300

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "api.tajuddinmunshi.com"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-tajuddinmunshi-com" {
  name = "masters.tajuddinmunshi.com"
  role = aws_iam_role.masters-tajuddinmunshi-com.name
}

resource "aws_iam_instance_profile" "nodes-tajuddinmunshi-com" {
  name = "nodes.tajuddinmunshi.com"
  role = aws_iam_role.nodes-tajuddinmunshi-com.name
}

resource "aws_iam_role" "masters-tajuddinmunshi-com" {
  name = "masters.tajuddinmunshi.com"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_masters.tajuddinmunshi.com_policy",
  )
}

resource "aws_iam_role" "nodes-tajuddinmunshi-com" {
  name = "nodes.tajuddinmunshi.com"
  assume_role_policy = file(
    "${path.module}/data/aws_iam_role_nodes.tajuddinmunshi.com_policy",
  )
}

resource "aws_iam_role_policy" "masters-tajuddinmunshi-com" {
  name = "masters.tajuddinmunshi.com"
  role = aws_iam_role.masters-tajuddinmunshi-com.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_masters.tajuddinmunshi.com_policy",
  )
}

resource "aws_iam_role_policy" "nodes-tajuddinmunshi-com" {
  name = "nodes.tajuddinmunshi.com"
  role = aws_iam_role.nodes-tajuddinmunshi-com.name
  policy = file(
    "${path.module}/data/aws_iam_role_policy_nodes.tajuddinmunshi.com_policy",
  )
}

resource "aws_key_pair" "kubernetes-tajuddinmunshi-com-f20b409ea82b9c2fd7b1ee5a5bdc4bed" {
  key_name = "kubernetes.tajuddinmunshi.com-f2:0b:40:9e:a8:2b:9c:2f:d7:b1:ee:5a:5b:dc:4b:ed"
  public_key = file(
    "${path.module}/data/aws_key_pair_kubernetes.tajuddinmunshi.com-f20b409ea82b9c2fd7b1ee5a5bdc4bed_public_key",
  )
}

resource "aws_launch_configuration" "master-eu-west-2a-masters-tajuddinmunshi-com" {
  name_prefix                 = "master-eu-west-2a.masters.tajuddinmunshi.com-"
  image_id                    = "ami-006a0174c6c25ac06"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.kubernetes-tajuddinmunshi-com-f20b409ea82b9c2fd7b1ee5a5bdc4bed.id
  iam_instance_profile        = aws_iam_instance_profile.masters-tajuddinmunshi-com.id
  security_groups             = [aws_security_group.masters-tajuddinmunshi-com.id]
  associate_public_ip_address = false
  user_data = file(
    "${path.module}/data/aws_launch_configuration_master-eu-west-2a.masters.tajuddinmunshi.com_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-tajuddinmunshi-com" {
  name_prefix                 = "nodes.tajuddinmunshi.com-"
  image_id                    = "ami-006a0174c6c25ac06"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-tajuddinmunshi-com-f20b409ea82b9c2fd7b1ee5a5bdc4bed.id
  iam_instance_profile        = aws_iam_instance_profile.nodes-tajuddinmunshi-com.id
  security_groups             = [aws_security_group.nodes-tajuddinmunshi-com.id]
  associate_public_ip_address = false
  user_data = file(
    "${path.module}/data/aws_launch_configuration_nodes.tajuddinmunshi.com_user_data",
  )

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route53_record" "api-tajuddinmunshi-com" {
  name = "api.tajuddinmunshi.com"
  type = "A"

  alias {
    name                   = aws_elb.api-tajuddinmunshi-com.dns_name
    zone_id                = aws_elb.api-tajuddinmunshi-com.zone_id
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z08831011XUMC17OQTMWS"
}

resource "aws_security_group" "api-elb-tajuddinmunshi-com" {
  name        = "api-elb.tajuddinmunshi.com"
  vpc_id      = "vpc-0446a3317146482f8"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "api-elb.tajuddinmunshi.com"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_security_group" "masters-tajuddinmunshi-com" {
  name        = "masters.tajuddinmunshi.com"
  vpc_id      = "vpc-0446a3317146482f8"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "masters.tajuddinmunshi.com"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_security_group" "nodes-tajuddinmunshi-com" {
  name        = "nodes.tajuddinmunshi.com"
  vpc_id      = "vpc-0446a3317146482f8"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                          = "tajuddinmunshi.com"
    Name                                       = "nodes.tajuddinmunshi.com"
    "kubernetes.io/cluster/tajuddinmunshi.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.masters-tajuddinmunshi-com.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.masters-tajuddinmunshi-com.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = aws_security_group.nodes-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = aws_security_group.api-elb-tajuddinmunshi-com.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.api-elb-tajuddinmunshi-com.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = aws_security_group.masters-tajuddinmunshi-com.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = aws_security_group.masters-tajuddinmunshi-com.id
  source_security_group_id = aws_security_group.nodes-tajuddinmunshi-com.id
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

terraform {
  required_version = ">= 0.9.3"
}

