#!/bin/bash
# ----------------------------------------------------------------------------------
# SCRIPT: Compute Hardening & Centralized Logging Baseline
# AUTHOR: Vicky Castillo (Security Auditor & Cloud Security Engineer)
# OBJECTIVE: Secure Compute Provisioning & Telemetry Baseline (SIEM Readiness).
# ----------------------------------------------------------------------------------
# COMPLIANCE & GOVERNANCE MAPPING:
#   - ISO 27001:2022 Control A.8.2: Privileged Access Rights (Managed Identity).
#   - ISO 27001:2022 Control A.8.15: Logging & Monitoring (SIEM Basis).
#   - ISO 27001:2022 Control A.8.22: Network Segregation (Private-only Compute).
#   - GDPR Article 25: Data Protection by Design (EEE Sovereignty).
#   - NIS2 Directive: Security of Network and Information Systems.
# ----------------------------------------------------------------------------------

# 1. ENVIRONMENT VARIABLES
RG="RG-SecurityLab"
LOCATION_COMPUTE="denmarkeast"   # GDPR Compliance: Data Residency in EEE
LOCATION_LOGS="westeurope"      # Strategic Hub for Resilient Logging
VM_NAME="VM-Security-Prod"
VNET_NAME="VNet-Security-DK"
WORKSPACE_NAME="Log-Security-Central"

echo "--- [LAB 3] Initializing Compute Hardening & Centralized Logging ---"

# 2. SECURE NETWORK INFRASTRUCTURE (VNet in EEE)
# Implementing Data Sovereignty within the European Economic Area.
echo "Provisioning VNet: $VNET_NAME in $LOCATION_COMPUTE..."
az network vnet create --resource-group $RG --name $VNET_NAME \
    --location $LOCATION_COMPUTE \
    --address-prefix 10.3.0.0/16 --subnet-name "Subnet-FrontEnd" --subnet-prefix 10.3.1.0/24

# 3. COMPUTE HARDENING & IDENTITY PROTECTION (Zero Trust)
# ISO 27001 A.8.2: Assigning System-Managed Identity for secret-less access.
echo "Creating Private-Only VM: $VM_NAME..."
az vm create --resource-group $RG --name $VM_NAME \
    --location $LOCATION_COMPUTE --image Ubuntu2204 --size Standard_B1s \
    --vnet-name $VNET_NAME --subnet "Subnet-FrontEnd" \
    --admin-username vickyadmin --generate-ssh-keys \
    --assign-identity \
    --public-ip-address "" --nsg ""

# 4. CENTRALIZED LOGGING REPOSITORY (Audit Trail)
# ISO 27001 A.8.15: Establishing the Single Pane of Glass for monitoring.
echo "Deploying Log Analytics Workspace in $LOCATION_LOGS..."
az monitor log-analytics workspace create --resource-group $RG \
    --workspace-name $WORKSPACE_NAME --location $LOCATION_LOGS

# 5. POST-DEPLOYMENT AUDIT
echo "Generating Compute & Identity Audit Report..."
az vm show -g $RG -n $VM_NAME --query "{Name:name, IdentityID:identity.principalId, PrivateIP:privateIpAddress, Status:provisioningState}" -o table

echo "--- [LAB 3] Compute & Logging Infrastructure Successfully Deployed ---"
