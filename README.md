# Azure Security Automation Portfolio
**Author:** Vicky Castillo - Security Auditor & Cloud Security Engineer

## 🛡️ Lab 1: Automated Identity & Access Management (IAM)
This project demonstrates the automation of identity lifecycle management in Azure Entra ID (formerly Azure AD) using Azure CLI.

### 📋 Compliance & Governance Mapping
- **ISO 27001:2022 Control A.5.15 & A.5.18:** Automated provisioning of identities and enforcement of Role-Based Access Control (RBAC).
- **ISO 27001:2022 Control A.8.28:** Secure coding practices by eliminating hardcoded secrets and using environment variables.
- **GDPR Article 5:** Implementation of the **Principle of Least Privilege (PoLP)** to ensure data confidentiality and integrity.
- **NIS2 Directive:** Strengthening supply chain security through automated asset governance.

### 🚀 Technical Implementation
- **Bulk Provisioning:** Automated creation of 10 security groups and 15 users.
- **Data Integrity:** Used ObjectIDs for membership assignment to prevent syntax errors and ensure precise mapping.
- **Security Best Practices:** Obfuscation of sensitive tenant information and credential management.
