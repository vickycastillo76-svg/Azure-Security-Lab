#!/bin/bash
# ----------------------------------------------------------------------------------
# SCRIPT: Identity & Access Management (IAM) Automation
# OBJECTIVE: Bulk creation of security groups and users with membership assignment.
# COMPLIANCE MAPPING: 
#   - ISO 27001:2022 (Control A.5.15, A.5.18): Identity and Access Management.
#   - NIST SP 800-53: Identification and Authentication (IA) controls.
#   - GDPR: Implementing Role-Based Access Control (RBAC) and Data Minimization.
# ----------------------------------------------------------------------------------

echo "Starting Identity Infrastructure Deployment..."

# 1. Security Groups Creation (Segregation of Duties)
# Creating groups to segment access by department/role.
groups=("Group_Bash_1" "Group_Bash_2" "Group_Bash_3" "Group_Bash_4" "Group_Bash_5")
for g in "${groups[@]}"; do
    az ad group create --display-name "$g" --mail-nickname "${g,,}"
    echo "Group $g created successfully."
done

# 2. User Creation (Accountability & Individual Identification)
# Creating users with unique User Principal Names (UPN).
users=("Magda" "Nilda" "Marta" "Elena" "Jose")
domain="://onmicrosoft.com"
password="Pa55w0rd1234!"

for u in "${users[@]}"; do
    az ad user create --display-name "$u Bash" \
        --password "$password" \
        --user-principal-name "$u@$domain" \
        --mail-nickname "${u,,}"
    echo "User $u created and linked to domain $domain."
done

# 3. Membership Assignment (RBAC Automation)
# Mapping users to groups using direct IDs to ensure data integrity.
for i in {0..4}; do
    USER_ID=$(az ad user show --id "${users[$i]}@$domain" --query id -o tsv)
    az ad group member add --group "${groups[$i]}" --member-id "$USER_ID"
    echo "Assignment completed: ${users[$i]} -> ${groups[$i]}"
done

echo "Identity Management Lab: Deployment and Audit completed."
