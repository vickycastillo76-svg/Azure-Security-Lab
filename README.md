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
__________________________________________________________________________________________________________________________________________

### 🛡️ Lab 3: Compute Hardening & Centralized Logging

Implementation of secure compute assets under a **Zero Trust** model and centralized telemetry for audit readiness.

#### 📋 Compliance Mapping

* **ISO 27001:2022 Control A.8.2 & A.8.15:** Enforcement of privileged access via **Managed Identities** (secret-less auth) and establishment of logging repositories for event monitoring.
* **ISO 27001:2022 Control A.8.22:** Compute isolation by disabling **Public IP addresses**, ensuring resources are only accessible via private backbones.
* **GDPR Article 25:** **Data Protection by Design** (EEE Sovereignty) by enforcing data residency within the European Economic Area.
* **NIS2 Directive:** Strengthening asset resilience and monitoring capabilities through **centralized telemetry**.

#### 🔍 Technical Audit Logs (CLI Verification)

##### 1. Secure Compute Inventory (Compliance A.8.22)
Verification of private-only provisioning and **System-Assigned Managed Identity** activation.

```text
Name                Identity_Type    PrivateIP    PublicIP    Status
------------------  ---------------  -----------  ----------  ---------
VM-Security-Prod    SystemAssigned   10.3.1.4     None        Succeeded
```

##### 2. Centralized Telemetry Repository (Audit Trail A.8.15)
Final confirmation of the **Log Analytics Workspace** for SIEM/SOC integration.

```text
Workspace_Name         Region       Provisioning_State    Customer_ID
---------------------  -----------  -------------------  ------------------------------------
Log-Security-Central   westeurope   Succeeded            382e31f7-1981-40f5-b071-1a1b3fc56b7c
```

##### 3. Identity Security Principal (Zero Trust A.8.2)
The VM has been granted a **unique security identity** to eliminate the need for hardcoded credentials:

**PrincipalID:** `088b02b1-dce4-43a0-842d-60ff0d90c893`

---
### 📸 Evidence Gallery - Lab 3
<img width="1713" height="237" alt="Lab3_Compute_Logging_Validation" src="https://github.com/user-attachments/assets/37e1d576-d4e3-4fd2-ba10-d63918f02a5d" />


