#!/bin/bash
# ----------------------------------------------------------------------------------
# SCRIPT: Network Security Group (NSG) & VNet Hardening
# AUTHOR: Vicky Castillo (Security Auditor & Cloud Security Engineer)
# OBJECTIVE: Zero Trust Network Architecture & Micro-segmentation.
# ----------------------------------------------------------------------------------
# COMPLIANCE & GOVERNANCE MAPPING:
#   - ISO 27001:2022 Control A.8.20: Network Security Management.
#   - ISO 27001:2022 Control A.8.22: Network Segregation (Subnetting).
#   - ISO 27001:2022 Control A.8.24: Use of Cryptography (Enforcing HTTPS/TLS).
#   - GDPR Article 32: Security of Processing (Encryption in transit).
#   - NIST SP 800-53: SC-7 Boundary Protection.
# ----------------------------------------------------------------------------------

# 1. ENVIRONMENT VARIABLES
# Based on Asset Discovery Phase
RG="RG-SecurityLab"
LOCATION="eastus"
NSG_NAME="NSG-Vicky"
VNET_NAME="VNet-SecurityLab"

echo "--- [LAB 2] Initializing Network Security & Hardening ---"

# 2. NETWORK SECURITY GROUP (NSG) HARDENING
# Implementing the Principle of Least Privilege at the edge.
echo "Creating/Updating Rules for $NSG_NAME..."

# Rule 100: Administrative Access (SSH)
# ISO 27001 A.5.18: Access rights for system administration.
az network nsg rule create --resource-group $RG --nsg-name $NSG_NAME \
    --name "Allow-SSH-Vicky" --priority 100 --access Allow --direction Inbound \
    --protocol Tcp --destination-port-ranges 22 \
    --description "Management: Secure Shell access for administration."

# Rule 110: Secure Business Traffic (HTTPS)
# ISO 27001 A.8.24: Enforcing cryptographic controls by disabling port 80 and allowing 443.
az network nsg rule create --resource-group $RG --nsg-name $NSG_NAME \
    --name "Allow-HTTPS-Vicky" --priority 110 --access Allow --direction Inbound \
    --protocol Tcp --destination-port-ranges 443 \
    --description "Compliance: Forced TLS/SSL encrypted traffic only."

# 3. SECURE NETWORK INFRASTRUCTURE (VNet & Subnet)
# Implementing Micro-segmentation to isolate workloads.
echo "Provisioning Virtual Network: $VNET_NAME..."
az network vnet create --resource-group $RG --name $VNET_NAME \
    --address-prefix 10.0.0.0/16 --subnet-name "Subnet-FrontEnd" --subnet-prefix 10.0.1.0/24

# 4. SECURITY BINDING (Policy Enforcement)
# Associating the NSG to the Subnet ensures 'Security by Design'.
echo "Binding $NSG_NAME to Subnet-FrontEnd..."
az network vnet subnet update --resource-group $RG --vnet-name $VNET_NAME \
    --name "Subnet-FrontEnd" --network-security-group $NSG_NAME

# 5. POST-DEPLOYMENT AUDIT
# Generating the Security Control Matrix for audit logs.
echo "Generating Network Security Audit Report..."
az network nsg rule list --resource-group $RG --nsg-name $NSG_NAME -o table

echo "--- [LAB 2] Network Hardening Deployment Completed ---"
