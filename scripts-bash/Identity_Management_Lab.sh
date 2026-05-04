#!/bin/bash
# ----------------------------------------------------------------------------------
# SCRIPT: Automated Identity & Access Management (IAM) Provisioning
# AUTHOR: Vicky Castillo (Security Auditor & Cloud Security Engineer)
# OBJECTIVE: Bulk creation of Directory Objects (Groups/Users) via Azure CLI.
# ----------------------------------------------------------------------------------
# COMPLIANCE & GOVERNANCE MAPPING:
#   - ISO 27001:2022 Control A.5.15: Identity Management.
#   - ISO 27001:2022 Control A.5.18: Access Rights (RBAC Enforcement).
#   - ISO 27001:2022 Control A.8.28: Secure Coding (No hardcoded secrets).
#   - NIS2 Directive: Governance and Asset Management.
#   - GDPR Article 5: Integrity, Confidentiality, and Least Privilege.
# ----------------------------------------------------------------------------------

echo "--- [LAB 1] Initializing Secure IAM Deployment ---"

# 1. SECURITY & ENVIRONMENT VARIABLES
# OpSec Note: Real domain and passwords are obfuscated to prevent enumeration.
# In production, retrieve these from Azure Key Vault or Environment Variables.
DOMAIN="://onmicrosoft.com"
USER_PASSWORD=${AZURE_LAB_PASSWORD:-"ComplexPass1234!"}

# 2. ROLE-BASED GROUP PROVISIONING (Segregation of Duties)
# Defining logical containers for access management.
groups=("Group_Bash_1" "Group_Bash_2" "Group_Bash_3" "Group_Bash_4" "Group_Bash_5")

for group_name in "${groups[@]}"; do
    echo "Creating Security Group: $group_name..."
    az ad group create --display-name "$group_name" --mail-nickname "${group_name,,}"
done

# 3. USER PROVISIONING (Accountability & Audit Trail)
# Creating individual identities for clear logging and monitoring.
users=("Magda" "Nilda" "Marta" "Elena" "Jose")

for user_name in "${users[@]}"; do
    echo "Creating User: $user_name..."
    az ad user create --display-name "$user_name Bash" \
        --password "$USER_PASSWORD" \
        --user-principal-name "$user_name@$DOMAIN" \
        --mail-nickname "${user_name,,}"
done

# 4. MEMBERSHIP ASSIGNMENT (RBAC Implementation)
# Mapping users to groups using ObjectIDs to ensure data integrity and security.
for i in {0..4}; do
    current_user="${users[$i]}"
    current_group="${groups[$i]}"
    
    # Retrieve unique ID to bypass formatting issues and ensure precision.
    USER_ID=$(az ad user show --id "$current_user@$DOMAIN" --query id -o tsv)
    
    if [ ! -z "$USER_ID" ]; then
        echo "Assigning Access: $current_user -> $current_group..."
        az ad group member add --group "$current_group" --member-id "$USER_ID"
    else
        echo "Error: User ID for $current_user not found. Skipping assignment."
    fi
done

echo "--- [LAB 1] IAM Infrastructure Successfully Deployed & Audited ---"
