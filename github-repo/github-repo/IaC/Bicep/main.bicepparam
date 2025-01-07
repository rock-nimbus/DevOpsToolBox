using 'main.bicep'

var projectName = 'BicepDevelopmentLab'
param environment = 'dev'
param location_short = 'uks'

@description('Generates a consistent 3-character project ID.')
param projectId = toLower('${substring(projectName, 0, 2)}${substring(projectName, length(projectName) - 1, 1)}')


param tags = {
  project: projectName
  environment: environment
  location: location_short
  projectID: projectId
}
