#!/bin/bash
# ----------------------------------------------------------------------------------
# SCRIPT: Workload Security & SIEM Integration
# AUTHOR: Vicky Castillo (Security Auditor & Cloud Security Engineer)
# OBJECTIVE: Isolated VM Provisioning & Automated Log Analytics Connection.
# ----------------------------------------------------------------------------------
# COMPLIANCE & GOVERNANCE MAPPING:
#   - ISO 27001:2022 Control A.8.15: Logging & Monitoring (SIEM Ingestion).
#   - ISO 27001:2022 Control A.8.22: Network Segregation (Private-only Compute).
#   - GDPR Article 25: Data Protection by Design (Zero Public Exposure).
# ----------------------------------------------------------------------------------

echo "🚀 Deploying Secure VM and connecting to the SOC Bunker..."

# 1. Crear la VM en la subred que ya existe (Subnet-FrontEnd)
# Sin IP pública = Seguridad Máxima
az vm create \
  --resource-group RG-SecurityLab \
  --name Security-Node-01 \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --vnet-name VNet-Security-DK \
  --subnet Subnet-FrontEnd \
  --admin-username azureuser \
  --generate-ssh-keys \
  --public-ip-address "" \
  --location denmarkeast

# 2. Conectar la VM al búnker (Log Analytics)
# Este proceso instala el agente para enviar telemetría al SIEM
az vm extension set \
  --resource-group RG-SecurityLab \
  --vm-name Security-Node-01 \
  --name OmsAgentForLinux \
  --publisher Microsoft.EnterpriseCloud.Monitoring \
  --settings "{\"workspaceId\": \"$(az monitor log-analytics workspace show -g RG-SecurityLab -n Log-Security-Central --query customerId -o tsv)\"}" \
  --protected-settings "{\"workspaceKey\": \"$(az monitor log-analytics workspace get-shared-keys -g RG-SecurityLab -n Log-Security-Central --query primarySharedKey -o tsv)\"}"

echo "✅ [SUCCESS] VM Security-Node-01 is running and monitored by the SOC."

