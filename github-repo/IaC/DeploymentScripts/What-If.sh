#!/bin/bash

# Variables
RESOURCE_GROUP_NAME="bicep-dev-rg" # Replace with your resource group name
LOCATION="UK South" # Replace with your Azure region shorthand
BICEP_FILE="../Bicep/main.bicep" # Bicep file to deploy
PARAMETERS_FILE="../Bicep/main.bicepparam" # Parameters file to use

# Check if the resource group exists
echo "Checking if resource group '$RESOURCE_GROUP_NAME' exists..."
az group show --name "$RESOURCE_GROUP_NAME" > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Resource group '$RESOURCE_GROUP_NAME' does not exist. Please create it before running this script."
  exit 1
else
  echo "Resource group '$RESOURCE_GROUP_NAME' found."
fi

# Run What-If to preview changes
echo "Running What-If operation to generate a report..."
az deployment group what-if \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --template-file "$BICEP_FILE" \
  --parameters "$PARAMETERS_FILE" \
  --output table

# Check What-If operation status
if [ $? -eq 0 ]; then
  echo "What-If operation completed successfully. Review the above report for details."
else
  echo "What-If operation failed. Please check the error messages above."
  exit 1
fi