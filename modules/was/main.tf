resource "aws_autoscaling_group" "bb-prd-was-asg" {
  name          = "bb-prd-was-ec2"
  launch_configuration = var.launch_configuration
  min_size             = 2
  max_size             = 30
  desired_capacity     = 2
  health_check_grace_period = 10
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = var.private_subnet_ids

  tag {
    key                 = "Name"
    value               = "bb-prd-was-asg"
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "bb-prd-was-cpu-alarm-01" {
  alarm_name          = "bb-prd-was-cpu-alarm-01"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30" # 30초 평가
  statistic           = "Average"
  threshold           = "50"  # CPU 사용률 임계값
  alarm_description  = "Alarm when CPU exceeds 60%"
  alarm_actions      = [aws_autoscaling_policy.bb-prd-step-autoscaling-01.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.bb-prd-was-asg.name
  }
}


resource "aws_autoscaling_policy" "bb-prd-step-autoscaling-01" {
  autoscaling_group_name = aws_autoscaling_group.bb-prd-was-asg.name
  name                   = "bb-prd-was-stepscaling-policy-01"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    scaling_adjustment          = 4
    metric_interval_lower_bound = 0.0
    metric_interval_upper_bound = 25.0
  }

  step_adjustment {
    scaling_adjustment          = 8
    metric_interval_lower_bound = 25.0
    metric_interval_upper_bound = 40.0
  }

  step_adjustment {
    scaling_adjustment          = 16
    metric_interval_lower_bound = 40.0
  }
}


resource "aws_cloudwatch_metric_alarm" "bb-prd-was-cpu-alarm-02" {
  alarm_name          = "bb-prd-was-cpu-alarm-02"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30" # 30초 평가
  statistic           = "Average"
  threshold           = "30"  # CPU 사용률 임계값
  alarm_description  = "Alarm when CPU exceeds 60%"
  alarm_actions      = [aws_autoscaling_policy.bb-prd-step-autoscaling-02.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.bb-prd-was-asg.name
  }
}

resource "aws_autoscaling_policy" "bb-prd-step-autoscaling-02" {
  autoscaling_group_name = aws_autoscaling_group.bb-prd-was-asg.name
  name                   = "bb-prd-was-stepscaling-policy-02"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    scaling_adjustment          = -2
    metric_interval_lower_bound = -15.0
    metric_interval_upper_bound = 0.0
  }

  step_adjustment {
    scaling_adjustment          = -2
    metric_interval_upper_bound = -15.0
  }
}

resource "aws_autoscaling_attachment" "bb-prd-was-att" {
  autoscaling_group_name = aws_autoscaling_group.bb-prd-was-asg.id
  lb_target_group_arn   = var.lb_target_group_arn
}
