#
# Module manifest for module 'PSGet_AzureRM'
#
# Generated by: Microsoft Corporation
#
# Generated on: 7/10/2018
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '6.5.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'b433e830-b479-4f7f-9c80-9cc6c28e1b51'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Azure Resource Manager Module'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
DotNetFrameworkVersion = '4.5.2'

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
CLRVersion = '4.0'

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(@{ModuleName = 'AzureRM.Profile'; RequiredVersion = '5.3.3'; },
               @{ModuleName = 'Azure.Storage'; RequiredVersion = '4.3.2'; },
               @{ModuleName = 'AzureRM.AnalysisServices'; RequiredVersion = '0.6.10'; },
               @{ModuleName = 'Azure.AnalysisServices'; RequiredVersion = '0.5.2'; },
               @{ModuleName = 'AzureRM.ApiManagement'; RequiredVersion = '6.1.1'; },
               @{ModuleName = 'AzureRM.ApplicationInsights'; RequiredVersion = '0.1.4'; },
               @{ModuleName = 'AzureRM.Automation'; RequiredVersion = '5.0.2'; },
               @{ModuleName = 'AzureRM.Backup'; RequiredVersion = '4.0.6'; },
               @{ModuleName = 'AzureRM.Batch'; RequiredVersion = '4.1.1'; },
               @{ModuleName = 'AzureRM.Billing'; RequiredVersion = '0.14.3'; },
               @{ModuleName = 'AzureRM.Cdn'; RequiredVersion = '5.0.1'; },
               @{ModuleName = 'AzureRM.CognitiveServices'; RequiredVersion = '0.9.6'; },
               @{ModuleName = 'AzureRM.Compute'; RequiredVersion = '5.3.0'; },
               @{ModuleName = 'AzureRM.Consumption'; RequiredVersion = '0.3.5'; },
               @{ModuleName = 'AzureRM.ContainerInstance'; RequiredVersion = '0.2.6'; },
               @{ModuleName = 'AzureRM.ContainerRegistry'; RequiredVersion = '1.0.6'; },
               @{ModuleName = 'AzureRM.DataFactories'; RequiredVersion = '5.0.1'; },
               @{ModuleName = 'AzureRM.DataFactoryV2'; RequiredVersion = '0.5.6'; },
               @{ModuleName = 'AzureRM.DataLakeAnalytics'; RequiredVersion = '5.1.0'; },
               @{ModuleName = 'AzureRM.DataLakeStore'; RequiredVersion = '6.1.0'; },
               @{ModuleName = 'AzureRM.DevTestLabs'; RequiredVersion = '4.0.5'; },
               @{ModuleName = 'AzureRM.Dns'; RequiredVersion = '5.0.0'; },
               @{ModuleName = 'AzureRM.EventGrid'; RequiredVersion = '0.3.5'; },
               @{ModuleName = 'AzureRM.EventHub'; RequiredVersion = '0.6.6'; },
               @{ModuleName = 'AzureRM.HDInsight'; RequiredVersion = '4.1.4'; },
               @{ModuleName = 'AzureRM.Insights'; RequiredVersion = '5.0.1'; },
               @{ModuleName = 'AzureRM.IotHub'; RequiredVersion = '3.1.4'; },
               @{ModuleName = 'AzureRM.KeyVault'; RequiredVersion = '5.0.4'; },
               @{ModuleName = 'AzureRM.LogicApp'; RequiredVersion = '4.1.0'; },
               @{ModuleName = 'AzureRM.MachineLearning'; RequiredVersion = '0.18.1'; },
               @{ModuleName = 'AzureRM.MachineLearningCompute'; RequiredVersion = '0.4.4'; },
               @{ModuleName = 'AzureRM.MarketplaceOrdering'; RequiredVersion = '0.2.3'; },
               @{ModuleName = 'AzureRM.Media'; RequiredVersion = '0.10.0'; },
               @{ModuleName = 'AzureRM.Network'; RequiredVersion = '6.4.0'; },
               @{ModuleName = 'AzureRM.NotificationHubs'; RequiredVersion = '5.0.1'; },
               @{ModuleName = 'AzureRM.OperationalInsights'; RequiredVersion = '5.0.2'; },
               @{ModuleName = 'AzureRM.PolicyInsights'; RequiredVersion = '1.0.2'; },
               @{ModuleName = 'AzureRM.PowerBIEmbedded'; RequiredVersion = '4.1.6'; },
               @{ModuleName = 'AzureRM.RecoveryServices'; RequiredVersion = '4.1.4'; },
               @{ModuleName = 'AzureRM.RecoveryServices.Backup'; RequiredVersion = '4.3.0'; },
               @{ModuleName = 'AzureRM.RecoveryServices.SiteRecovery'; RequiredVersion = '0.2.6'; },
               @{ModuleName = 'AzureRM.RedisCache'; RequiredVersion = '5.0.1'; },
               @{ModuleName = 'AzureRM.Relay'; RequiredVersion = '0.3.6'; },
               @{ModuleName = 'AzureRM.Resources'; RequiredVersion = '6.2.1'; },
               @{ModuleName = 'AzureRM.Scheduler'; RequiredVersion = '0.16.6'; },
               @{ModuleName = 'AzureRM.ServiceBus'; RequiredVersion = '0.6.7'; },
               @{ModuleName = 'AzureRM.ServiceFabric'; RequiredVersion = '0.3.8'; },
               @{ModuleName = 'AzureRM.Sql'; RequiredVersion = '4.10.0'; },
               @{ModuleName = 'AzureRM.Storage'; RequiredVersion = '5.0.0'; },
               @{ModuleName = 'AzureRM.StreamAnalytics'; RequiredVersion = '4.0.6'; },
               @{ModuleName = 'AzureRM.Tags'; RequiredVersion = '4.0.3'; },
               @{ModuleName = 'AzureRM.TrafficManager'; RequiredVersion = '4.0.7'; },
               @{ModuleName = 'AzureRM.UsageAggregates'; RequiredVersion = '4.0.3'; },
               @{ModuleName = 'AzureRM.Websites'; RequiredVersion = '5.0.5'; })

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        LicenseUri = 'https://aka.ms/azps-license'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Azure/azure-powershell'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '6.5.0 - July 2018
AzureRM.Profile
* Updated help for ''Get-AzureRmContextAutosaveSetting''

Azure.Storage
* Support Upload Blob or File with write only Sas token
- Set-AzureStorageBlobContent
- Set-AzureStorageFileContent

AzureRM.AnalysisServices
* Add required property ResourceGroupName to AS.

AzureRM.Automation
* Update help and add example for ''New-AzureRMAutomationSchedule''

AzureRM.Compute
* Add -Tag parameter to Update/New-AzureRmAvailabilitySet
* Add example for ''Add-AzureRmVmssExtension''
* Add examples for ''Remove-AzureRmVmssExtension''
* Update help for ''Set-AzureRmVMAccessExtension''
* Update SimpleParameterSet for New-AzureRmVmss to set SinglePlacementGroup to false by default and add switch parameter ''SinglePlacementGroup'' that enables the user to create the VMSS in a single placement group.

AzureRM.EventHub
* Added a readonly property ''PendingReplicationOperationsCount'' to PSEventHubDRConfigurationAttributes class, which gives the pending replication operations count while replication is in progress

AzureRM.KeyVault
* Update error message for Set-AzureRmKeyVaultAccessPolicy

AzureRM.LogicApp
* Fixed "parameter set could not be resolved" error in New-AzureRmLogicApp

AzureRM.Network
* Enable peering across Virtual Networks in multiple Tenants for Set/Add-AzureRmVirtualNetworkPeering
* Updated below cmdlets for Application Gateway
    - New-AzureRmApplicationGateway : Added EnableFIPS flag and Zones support
    - New-AzureRmApplicationGatewaySku : Added new skus Standard_v2 and WAF_v2
    - Set-AzureRmApplicationGatewaySku : Added new skus Standard_v2 and WAF_v2
* Regenerated RouteTable cmdlets with the latest generator version

AzureRM.Relay
* Updated markdown files, fix for the parameter name issue in example

AzureRM.Resources
* Update Roleassignment and roledefinition cmdlets:
    - Remove extra roledefinition calls done as part of paging.
* Fix Get-AzureRmRoleAssignment cmdlet
    - Fix -ExpandPrincipalGroups command parameter functionality
* Fix issue with ''Get-AzureRmResource'' where ''-ResourceType'' parameter was case sensitive

AzureRM.ServiceBus
* Added top and skip parameter to list cmdlets
* Added Standard to Premium NameSpace migration cmdlets :
    - Start-AzureRmServiceBusMigration
    - Get-AzureRmServiceBusMigration
    - Complete-AzureRmServiceBusMigration
    - Stop-AzureRmServiceBusMigration
    - Remove-AzureRmServiceBusMigration
* Added a readonly property ''PendingReplicationOperationsCount'' to PSServiceBusDRConfigurationAttributes class, which gives the pending replication operations count while replication is in progress

AzureRM.ServiceFabric
* Update example for ''New-AzureRmServiceFabricCluster''

AzureRM.Sql
* Adding new Cmdlets for Management.Sql to allow customers to add TDE Certificate to Sql Server instance or a Managed Instance
	- Add-AzureRmSqlServerTransparentDataEncryptionCertificate
    - Add-AzureRmSqlManagedInstanceTransparentDataEncryptionCertificate

AzureRM.Websites
* `Set-AzureRmWebApp -AssignIdentity` and  `Set-AzureRmWebAppSlot -AssignIdentity` when set to false will now remove the Identity property from the site object.Removing preview tag as well.
* `Get-AzureRmWebAppMetrics`,`Get-AzureRmAppServicePlanMetrics` example updated
* `Set-AzureRmWebApp -PhpVersion` supports off as a valid php version
'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

