# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

# Snapshots require a Premium app to exist for several hours.
# Deploy a Premium app and update these global variables to re-record the snapshots tests.
$snapshotRgName = 'onesdksnapshots'
$snapshotAppName = 'onesdkpremapp'
$snapshotAppSlot = 'staging'

function Test-CreateNewWebAppBackup
{
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $backupName = Get-BackupName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoContainerName = 'container' + $rgName
    $stoType = 'Standard_LRS'

    try
    {
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName
        # Create a backup of the web app
        $result = New-AzureRmWebAppBackup -ResourceGroupName $rgName -Name $wName -StorageAccountUrl $sasUri -BackupName $backupName 

        # Assert
        Assert-AreEqual $backupName $result.BackupName
        Assert-NotNull $result.StorageAccountUrl
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-CreateNewWebAppBackupPiping
{
    # Names and strings setup
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $backupName = Get-BackupName
    $backupName2 = Get-BackupName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoContainerName = 'container' + $rgName
    $stoType = 'Standard_LRS'

    try
    {
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName
        # Create a backup of the web app
        $backup = $app | New-AzureRmWebAppBackup -StorageAccountUrl $sasUri -BackupName $backupName

        # Assert
        Assert-AreEqual $backupName $backup.BackupName
        Assert-NotNull $backup.StorageAccountUrl

		$count = 0
		while (($backup.BackupStatus -like "Created" -or $backup.BackupStatus -like "InProgress") -and $count -le 20)
		{
			Wait-Seconds 30
		    $backup = $backup | Get-AzureRmWebAppBackup
			$count++
		}

        # Test that it's possible to modify the return value of the cmdlet to make a new backup
        $backup.BackupName = $backupName2
        $backup2 = $backup | New-AzureRmWebAppBackup

        # Assert
        Assert-AreEqual $backupName2 $backup2.BackupName
        Assert-NotNull $backup2.StorageAccountUrl
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-GetWebAppBackup
{
    # Names and strings setup
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $backupName = Get-BackupName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoType = 'Standard_LRS'
    $stoContainerName = 'container' + $rgName

    try
    {
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName

        # Create a backup of the web app
        $newBackup = New-AzureRmWebAppBackup -ResourceGroupName $rgName -Name $wName -StorageAccountUrl $sasUri -BackupName $backupName

        # Get the backup
        $result = Get-AzureRmWebAppBackup -ResourceGroupName $rgName -Name $wName -BackupId $newBackup.BackupId

        # Assert
        Assert-AreEqual $backupName $result.BackupName
        Assert-NotNull $result.StorageAccountUrl
        Assert-NotNull $result.BackupId

        # Test piping - should be able to pipe result of previous get backup and get the same backup
        $pipeResult = $result | Get-AzureRmWebAppBackup

        Assert-AreEqual $backupName $pipeResult.BackupName
        Assert-AreEqual $result.StorageAccountUrl $pipeResult.StorageAccountUrl 
        Assert-AreEqual $result.BackupId $pipeResult.BackupId
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-GetWebAppBackupList
{
    # Names and strings setup
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $backupName = Get-BackupName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoType = 'Standard_LRS'
    $stoContainerName = 'container' + $rgName

    try
    {
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName
        
        # Create a backup of the web app
        $backup = New-AzureRmWebAppBackup -ResourceGroupName $rgName -Name $wName -StorageAccountUrl $sasUri -BackupName $backupName -Databases $dbBackupSetting

        # Get a list of the backups
        $backupList = Get-AzureRmWebAppBackupList -ResourceGroupName $rgName -Name $wName
        $listBackup = $backupList | where {$_.BackupId -eq $backup.BackupId}

        # Assert
        Assert-AreEqual 1 $backupList.Count
        Assert-NotNull $listBackup
        Assert-AreEqual $backup.BackupName $listBackup.BackupName

        # Test piping
        $pipeBackupList = $app | Get-AzureRmWebAppBackupList
        $pipeBackup = $pipeBackupList | where {$_.BackupId -eq $backup.BackupId}

        # Assert
        Assert-AreEqual 1 $pipeBackupList.Count
        Assert-NotNull $pipeBackup
        Assert-AreEqual $backup.BackupName $pipeBackup.BackupName
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-EditAndGetWebAppBackupConfiguration
{
    # Names and strings setup
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoContainerName = 'container' + $rgName
    $stoType = 'Standard_LRS'

    try
    {
        # Setup
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName
        $startTime = (Get-Date).ToUniversalTime().AddDays(1)
        $frequencyInterval = 7
        $frequencyUnit = "Day"
        $retentionPeriod = 3

        # Set the backup configuration
        $config = Edit-AzureRmWebAppBackupConfiguration `
            -ResourceGroupName $rgName -Name $wName -StorageAccountUrl $sasUri `
            -FrequencyInterval $frequencyInterval -FrequencyUnit $frequencyUnit `
            -RetentionPeriodInDays $retentionPeriod -StartTime $startTime `
            -KeepAtLeastOneBackup 

        # Assert
        Assert-True { $config.Enabled }
        Assert-NotNull $config.StorageAccountUrl
        Assert-AreEqual $frequencyInterval $config.FrequencyInterval
        Assert-AreEqual $frequencyUnit $config.FrequencyUnit 
        Assert-True { $config.KeepAtLeastOneBackup }
        Assert-AreEqual $retentionPeriod $config.RetentionPeriodInDays
        # Cannot assert equality because time will be different in playback mode
        Assert-NotNull $config.StartTime

        # Get the configuration and verify it's the same
        $getConfig = Get-AzureRmWebAppBackupConfiguration -ResourceGroupName $rgName -Name $wName

        # Assert
        Assert-True { $getConfig.Enabled }
        Assert-NotNull $getConfig.StorageAccountUrl
        Assert-AreEqual $frequencyInterval $getConfig.FrequencyInterval
        Assert-AreEqual $frequencyUnit $getConfig.FrequencyUnit 
        Assert-True { $getConfig.KeepAtLeastOneBackup }
        Assert-AreEqual $retentionPeriod $getConfig.RetentionPeriodInDays
        # Cannot assert equality because time will be different in playback mode
        Assert-NotNull $getConfig.StartTime
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-EditAndGetWebAppBackupConfigurationPiping
{
    # Names and strings setup
    $rgName = Get-ResourceGroupName
    $wName = Get-WebsiteName
    $location = Get-Location
    $whpName = Get-WebHostPlanName
    $tier = "Standard"
    $stoName = 'sto' + $rgName
    $stoContainerName = 'container' + $rgName
    $stoType = 'Standard_LRS'

    try
    {
        # Setup
        $app = Create-TestWebApp $rgName $location $whpName $tier $wName
        $sasUri = Create-TestStorageAccount $rgName $location $stoName $stoType $stoContainerName
        $startTime = (Get-Date).ToUniversalTime().AddDays(1)
        $frequencyInterval = 7
        $frequencyUnit = "Day"
        $retentionPeriod = 3

        # Test piping a web app in
        $app | Edit-AzureRmWebAppBackupConfiguration `
            -StorageAccountUrl $sasUri -FrequencyInterval $frequencyInterval `
            -FrequencyUnit $frequencyUnit -RetentionPeriodInDays $retentionPeriod `
            -StartTime $startTime -KeepAtLeastOneBackup
        $config = $app | Get-AzureRmWebAppBackupConfiguration

        # Assert
        Assert-True { $config.Enabled }
        Assert-NotNull $config.StorageAccountUrl
        Assert-AreEqual $frequencyInterval $config.FrequencyInterval
        Assert-AreEqual $frequencyUnit $config.FrequencyUnit 
        Assert-True { $config.KeepAtLeastOneBackup }
        Assert-AreEqual $retentionPeriod $config.RetentionPeriodInDays
        # Cannot assert equality because time will be different in playback mode
        Assert-NotNull $config.StartTime

        # Test piping a modified configuration object into the Edit cmdlet
        $newFrequencyInterval = 5
        $newRetentionPeriod = 2
        $newFrequencyUnit = "Hour"
        $config.FrequencyInterval = $newFrequencyInterval
        $config.RetentionPeriodInDays = $newRetentionPeriod
        $config.FrequencyUnit = $newFrequencyUnit
        $config | Edit-AzureRmWebAppBackupConfiguration
        $pipeConfig = $app | Get-AzureRmWebAppBackupConfiguration

        # Assert
        Assert-True { $pipeConfig.Enabled }
        Assert-NotNull $pipeConfig.StorageAccountUrl
        Assert-AreEqual $newFrequencyInterval $pipeConfig.FrequencyInterval
        Assert-AreEqual $newFrequencyUnit $pipeConfig.FrequencyUnit 
        Assert-True { $pipeConfig.KeepAtLeastOneBackup }
        Assert-AreEqual $newRetentionPeriod $pipeConfig.RetentionPeriodInDays
        # Cannot assert equality because time will be different in playback mode
        Assert-NotNull $pipeConfig.StartTime
    }
    finally
    {
        # Cleanup
        Remove-AzureRmStorageAccount -ResourceGroupName $rgName -Name $stoName
        Remove-AzureRmWebApp -ResourceGroupName $rgName -Name $wName -Force
        Remove-AzureRmAppServicePlan -ResourceGroupName $rgName -Name  $whpName -Force
        Remove-AzureRmResourceGroup -Name $rgName -Force
    }
}

function Test-GetWebAppSnapshot
{
	# Test named parameters
	$snapshots = Get-AzureRmWebAppSnapshot -ResourceGroupName $snapshotRgName -Name $snapshotAppName
	Assert-True { $snapshots.Length -gt 0 }
	Assert-NotNull $snapshots[0]
	Assert-NotNull $snapshots[0].SnapshotTime
	Assert-AreEqual 'Production' $snapshots[0].Slot

	# Test positional parameters
	$snapshots = Get-AzureRmWebAppSnapshot $snapshotRgName  $snapshotAppName
	Assert-True { $snapshots.Length -gt 0 }
	Assert-NotNull $snapshots[0]
	Assert-NotNull $snapshots[0].SnapshotTime
	Assert-AreEqual 'Production' $snapshots[0].Slot

	# Test snapshots for slots
	$snapshots = Get-AzureRmWebAppSnapshot -ResourceGroupName $snapshotRgName -Name $snapshotAppName -Slot $snapshotAppSlot
	Assert-True { $snapshots.Length -gt 0 }
	Assert-NotNull $snapshots[0]
	Assert-NotNull $snapshots[0].SnapshotTime
	Assert-AreEqual $snapshotAppSlot $snapshots[0].Slot

	# Test piping
	$app = Get-AzureRmWebApp -ResourceGroupName $snapshotRgName -Name $snapshotAppName
	$snapshots = $app | Get-AzureRmWebAppSnapshot
	Assert-True { $snapshots.Length -gt 0 }
	Assert-NotNull $snapshots[0]
	Assert-NotNull $snapshots[0].SnapshotTime
	Assert-AreEqual 'Production' $snapshots[0].Slot
}

function Test-RestoreWebAppSnapshot
{
	# Test overwrite
	$snapshot = (Get-AzureRmWebAppSnapshot $snapshotRgName $snapshotAppName)[0]
	Restore-AzureRmWebAppSnapshot -ResourceGroupName $snapshotRgName -Name $snapshotAppName -InputObject $snapshot -Force -RecoverConfiguration

	# Test restore to target slot
	Restore-AzureRmWebAppSnapshot $snapshotRgName $snapshotAppName $snapshotAppSlot $snapshot -RecoverConfiguration -Force

	# Test piping and background job
	$job = $snapshot | Restore-AzureRmWebAppSnapshot -Force -AsJob
	$job | Wait-Job
}

# Utility functions

# Creates a new web app
function Create-TestWebApp
{
    param (
        [string] $resourceGroup,
        [string] $location,
        [string] $hostingPlan,
        [string] $tier,
        [string] $appName
    )
    New-AzureRmResourceGroup -Name $resourceGroup -Location $location | Out-Null
    New-AzureRmAppServicePlan -ResourceGroupName $resourceGroup -Name  $hostingPlan -Location  $location -Tier $tier | Out-Null
    $app = New-AzureRmWebApp -ResourceGroupName $resourceGroup -Name $appName -Location $location -AppServicePlan $hostingPlan 
    return $app
}

# Creates a new Azure Storage account and returns SAS URI
function Create-TestStorageAccount
{
    param (
        [string] $resourceGroup,
        [string] $location,
        [string] $storageName,
        [string] $storageType,
        [string] $stoContainerName
    )
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroup -Name $storageName -Location $location -Type $storageType | Out-Null
    $stoKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageName).Key1;
    # 2 hour access duration
    $accessDuration = New-Object -TypeName TimeSpan(2,0,0)
    $permissions = [Microsoft.WindowsAzure.Storage.Blob.SharedAccessBlobPermissions]::Write -bor
		[Microsoft.WindowsAzure.Storage.Blob.SharedAccessBlobPermissions]::Read -bor
		[Microsoft.WindowsAzure.Storage.Blob.SharedAccessBlobPermissions]::List -bor
		[Microsoft.WindowsAzure.Storage.Blob.SharedAccessBlobPermissions]::Delete
    $sasUri = Get-SasUri $storageName $stoKey $stoContainerName $accessDuration $permissions
    return $sasUri
}