Param(
    [Parameter(Mandatory = $true)]
    [string]$backendAzureRmResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$backendAzureRmStorageAccountName,

    [Parameter(Mandatory = $true)]
    [string]$backendAzureRmContainerName,

    [Parameter(Mandatory = $true)]
    [string]$backendAzureRmKey
)

try{
    Install-Module -Name Pester -MinimumVersion 5.1.1 -Force -ErrorAction 'Stop'
}
catch{
    break
}
$AzStorageBlobContent = @{
    Container = $backendAzureRmContainerName
    Blob = $backendAzureRmKey
    Context = (Get-AzStorageAccount -ResourceGroupName $backendAzureRmResourceGroupName -Name $backendAzureRmStorageAccountName).Context
    Destination = (Join-Path -Path (Get-Location) -ChildPath 'state.json')
    Force = $true
}
Get-AzStorageBlobContent @AzStorageBlobContent
Write-Host "##vso[task.setvariable variable=statelocation;]$(get-location)"
#Write-Host "##vso[artifact.associate type=container;artifactname=StateFile]$(get-location)"
$StateFileString = Get-Content -Path $AzStorageBlobContent.Destination -Raw

$PesterContainer = New-PesterContainer -Data @{ StateFileString = $StateFileString } -ScriptBlock {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$StateFileString
    )
    Describe 'Terraform StateFile Validation' {
        $State = ConvertFrom-Json -InputObject $StateFileString

        foreach($Resource in $State.resources){
            if($Resource.type -ne 'azurerm_key_vault_secret'){
                It -Name "$($Resource.Name) should exist" -Test {
                    $AzResource = Get-AzResource -ResourceId $Resource.attributes.id
                    $AzResource | Should -Not -Be null
                    $AzResource | Should -Not -Throw
                }
            }
        }
    }    
}
Invoke-Pester -Container $PesterContainer -CI 