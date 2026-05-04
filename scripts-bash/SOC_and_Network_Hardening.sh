#!/bin/bash
# 🛡️ Module 4: Platform Governance & Network Hardening
# Author: [Tu Nombre] (Vicky)

# 1. 🏰 BASTION DEPLOYMENT (Secure Access)
# Creating the dedicated subnet, public IP, and the Bastion Host itself.
az network vnet subnet create \
    --resource-group RG-SecurityLab \
    --vnet-name VNet-Security-DK \
    --name AzureBastionSubnet \
    --address-prefixes 10.3.2.0/26

az network public-ip create \
    --resource-group RG-SecurityLab \
    --name IP-Bastion-DK \
    --sku Standard \
    --location denmarkeast

az network bastion create \
    --name Security-Bastion-Host \
    --public-ip-address IP-Bastion-DK \
    --resource-group RG-SecurityLab \
    --vnet-name VNet-Security-DK \
    --location denmarkeast

# 2. 🧹 SHADOW I.T. CLEANUP
# Deleting redundant networks to reduce attack surface and costs.
az network vnet delete --resource-group RG-SecurityLab --name Vnet-Secure
az network vnet delete --resource-group RG-SecurityLab --name VNet-SecurityLab

echo "✅ Infrastructure Hardening Complete."
