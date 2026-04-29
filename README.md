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

  -------------------------------------------------------------------------------------------------------------------------------

  ## 🛡️ Lab 2: Network Security & Infrastructure Hardening
Implementation of a **Zero Trust** network perimeter and micro-segmentation.

### 📋 Compliance Mapping
- **ISO 27001:2022 Control A.8.20 & A.8.22:** Establishing network boundaries and segregating the Front-End subnet from the rest of the environment.
- **ISO 27001:2022 Control A.8.24:** Cryptographic enforcement by restricting insecure protocols (HTTP/80) and permitting only encrypted channels (HTTPS/443).
- **Security by Design:** Ensuring all network assets are provisioned within a predefined security perimeter (NSG-to-Subnet binding).

### 🔍 Technical Audit Logs (CLI Verification)

**1. Network Security Rules Matrix (Compliance A.8.20)**  
Verified prioritized rules for Administrative (SSH/22) and Business (HTTPS/443) traffic.
```text
Name               ResourceGroup    Priority    Access    Protocol    Direction    DestinationPortRanges
-----------------  ---------------  ----------  --------  ----------  -----------  -----------------------
Allow-SSH-Vicky    RG-SecurityLab   100         Allow     Tcp         Inbound      22
Allow-HTTPS-Vicky  RG-SecurityLab   110         Allow     Tcp         Inbound      443
```

**2. Virtual Network Inventory (Asset Management A.5.9)**  
Verification of address space allocation for the security lab environment.
```text
Nombre            Rango
----------------  -----------
VNet-SecurityLab  10.0.0.0/16
```

**3. Security Binding Verification (Network Segregation A.8.22)**  
Final confirmation of the association between the Subnet and the Network Security Group (NSG).
```text
Subred           NSG_Asociado
---------------  ------------------------------------------------------------------------------------------
Subnet-FrontEnd  .../providers/Microsoft.Network/networkSecurityGroups/NSG-Vicky
```
