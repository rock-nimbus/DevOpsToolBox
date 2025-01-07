#!/bin/bash

# Variables
RESOURCE_GROUP_NAME="bicep-dev-rg" # Replace with your resource group name
LOCATION="UK South" # Replace with your Azure region shorthand
BICEP_FILE="../Bicep/main.bicep" # Bicep file to deploy
PARAMETERS_FILE="../Bicep/main.bicepparam" # Parameters file to use

# Create the resource group if it doesn't exist
echo "Checking if resource group '$RESOURCE_GROUP_NAME' exists..."
az group show --name "$RESOURCE_GROUP_NAME" > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Resource group '$RESOURCE_GROUP_NAME' not found. Creating it..."
  az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"
else
  echo "Resource group '$RESOURCE_GROUP_NAME' already exists."
fi

# Run What-If to preview changes
echo "Running What-If operation to preview changes..."
az deployment group what-if \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --template-file "$BICEP_FILE" \
  --parameters "$PARAMETERS_FILE"

# Prompt user to confirm deployment
read -p "Do you want to proceed with the deployment? (yes/no): " CONFIRMATION
if [[ "$CONFIRMATION" != "yes" ]]; then
  echo "Deployment cancelled."
  exit 0
fi

# Deploy the Bicep file
echo "Deploying Bicep template to resource group '$RESOURCE_GROUP_NAME'..."
az deployment group create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --template-file "$BICEP_FILE" \
  --parameters @"$PARAMETERS_FILE"

# Check deployment status
if [ $? -eq 0 ]; then
  echo "Bicep deployment successful!"
else
  echo "Bicep deployment failed. Please check the error messages above."
  exit 1
fi