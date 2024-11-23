resource "aws_eks_cluster" "eks-cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subntes[0].id, aws_subnet.subntes[1].id, aws_subnet.subntes[2].id]
    security_group_ids = [ aws_security_group.eks_cluster_sg.id ]

  }

  tags = {
    "Name" = "myEksCluster"
  }
  depends_on = [aws_iam_role.eks_role, aws_subnet.subntes]
}


# create a node group
resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.subntes[0].id, aws_subnet.subntes[1].id, aws_subnet.subntes[2].id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }
  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = var.ssh_key_name
    source_security_group_ids = [aws_security_group.eks_node_sg.id]
  }


  tags = {
    "Name" = "node-group"
  }



}
