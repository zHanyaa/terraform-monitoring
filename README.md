# Terraform Monitoring Infrastructure

Infraestrutura de monitoramento completa para AWS usando Terraform, incluindo instâncias EC2, alarmes CloudWatch e notificações SNS.

## Visão Geral

Este projeto demonstra como criar uma infraestrutura de monitoramento automatizada na AWS usando Terraform, incluindo:

- **EC2 Instance** com perfil IAM para monitoramento
- **CloudWatch Alarms** para monitoramento de CPU
- **SNS Topic** para notificações por email
- **IAM Roles e Policies** para permissões adequadas

## Arquitetura

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   EC2 Instance  │    │  CloudWatch      │    │   SNS Topic     │
│                 │    │  Alarm           │    │                 │
│ • t3.micro      │◄──►│ • CPU > 80%      │───►│ • Email         │
│ • IAM Profile   │    │ • 2 periods      │    │ • Notifications │
│ • Monitoring    │    │ • 120s period    │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Estrutura do Projeto

```
terraform-monitoring/
├── main.tf                 # Configuração principal
├── variables.tf            # Variáveis globais
├── outputs.tf              # Outputs globais
├── providers.tf            # Configuração de providers
├── README.md               # Este arquivo
└── Modules/
    ├── ec2/
    │   ├── main.tf         # Recursos EC2 e IAM
    │   ├── variables.tf    # Variáveis do módulo EC2
    │   └── outputs.tf      # Outputs do módulo EC2
    ├── cloudwatch/
    │   ├── main.tf         # Alarmes CloudWatch
    │   ├── variables.tf    # Variáveis do módulo CloudWatch
    │   └── outputs.tf      # Outputs do módulo CloudWatch
    └── sns/
        ├── main.tf         # Tópico e subscription SNS
        ├── variables.tf    # Variáveis do módulo SNS
        └── outputs.tf      # Outputs do módulo SNS
```

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado
- Conta AWS com permissões adequadas
- Email válido para receber notificações

## Como Usar

### 1. Clone o Repositório

```bash
git clone https://github.com/zHanyaa/terraform-monitoring.git
cd terraform-monitoring
```

### 2. Configure as Variáveis

Edite o arquivo `terraform.tfvars` (crie se não existir):

```hcl
# Configurações da instância EC2
instance_type = "t3.micro"
tags = {
  Name        = "Monitoring-Instance"
  Environment = "Production"
  Project     = "Terraform-Monitoring"
}

# Email para notificações
email = "seu-email@exemplo.com"

# Região AWS
aws_region = "us-east-1"
```

### 3. Inicialize o Terraform

```bash
terraform init
```

### 4. Planeje a Infraestrutura

```bash
terraform plan
```

### 5. Aplique a Infraestrutura

```bash
terraform apply
```

### 6. Confirme a Aplicação

Digite `yes` quando solicitado.

## Monitoramento

Após a aplicação, você terá:

- **EC2 Instance**: Instância t3.micro com perfil de monitoramento
- **CloudWatch Alarm**: Alarme configurado para CPU > 80%
- **SNS Topic**: Tópico para notificações por email
- **IAM Role**: Role com permissões CloudWatch

### Verificando os Recursos

```bash
# Listar recursos criados
terraform show

# Ver outputs específicos
terraform output instance_id
terraform output topic_arn
```

## Limpeza

Para destruir a infraestrutura:

```bash
terraform destroy
```

## Personalização

### Modificando Alarmes

Edite `Modules/cloudwatch/main.tf` para alterar:

- Threshold (atualmente 80%)
- Período de avaliação (atualmente 120s)
- Número de períodos (atualmente 2)

### Adicionando Novos Alarmes

```hcl
resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  alarm_name          = "HighMemoryUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = 120
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "Alarme quando memória > 85%"
  alarm_actions       = [var.sns_topic_arn]
  dimensions = {
    InstanceId = var.instance_id
  }
}
```

### Modificando Tipo de Instância

Altere a variável `instance_type` no `terraform.tfvars`:

```hcl
instance_type = "t3.small"  # ou t3.medium, t3.large, etc.
```

## Segurança

- **IAM Roles**: Permissões mínimas necessárias
- **Security Groups**: Configurados para acesso seguro
- **Tags**: Recursos adequadamente marcados
- **Encryption**: Dados criptografados em repouso

## Autor

**zHanyaa** - [GitHub](https://github.com/zHanyaa)

!!ALERTA!! - Projeto criado para fins de aprendizado e exposição de experiência prática em Terraform e AWS Cloud