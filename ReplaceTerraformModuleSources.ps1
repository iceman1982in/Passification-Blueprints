<#  
    
    AVANADE, LLC

    Created On: 3/8/2022
    Created By: Brandon Stalte
    
	Run the example below in a PS command prompt in the root folder for the repository.
	
	
USAGE EXAMPLES:
	
	.\ReplaceTerraformModuleSources.ps1 -devOps_org_name "AVANADE-MOD" -devOps_project_name "Azure-Terraform-Modules" -devOps_repo_name "Azure-Terraform-Modules"

	.\ReplaceTerraformModuleSources.ps1 -git_ssh_url "git::ssh://git@ssh.dev.azure.com/v3" -devOps_org_name "AVANADE-MOD" -devOps_project_name "Azure-Terraform-Modules" -devOps_repo_name "Azure-Terraform-Modules"
    
    .\ReplaceTerraformModuleSources.ps1 -devOps_org_name "AVANADE-MOD" -devOps_project_name "Azure-Terraform-Modules" -devOps_repo_name "Azure-Terraform-Modules" -reapply_placeholders

    .\ReplaceTerraformModuleSources.ps1 -git_ssh_url "git::ssh://git@ssh.dev.azure.com/v3" -devOps_org_name "AVANADE-MOD" -devOps_project_name "Azure-Terraform-Modules" -devOps_repo_name "Azure-Terraform-Modules" -reapply_placeholders

#>

param
( 
	[string]$git_ssh_url = "git::ssh://git@ssh.dev.azure.com/v3",
    [string]$devOps_org_name = "AVANADE-MOD",
    [string]$devOps_project_name,
	[string]$devOps_repo_name,
    [switch]$reapply_placeholders = $false
)

$ConfigureTerraformModuleSources = {
    Param(
        [string]$p_git_ssh_url,
		[string]$p_devOps_org_name,
        [string]$p_devOps_project_name,
		[string]$p_devOps_repo_name
        )
        
    $files = Get-ChildItem -Directory -Recurse | ?{ $_.Name -eq "terraform" } | Get-ChildItem -File -Recurse -Include "*.tf" | ?{ $_.FullName -notlike '*.terraform*' } #| %{ $_.FullName; }
    $filesCleaned = $files | ? {$_.Extension -eq '.tf' }

    # Replace the following text with parameter values
    # [[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]

    foreach($tfFile in $filesCleaned) {
        
        if($reapply_placeholders -eq $false) {
            # Replace all placeholder values with full source path
            (Get-Content -path $tfFile.FullName -Raw) -replace "\[\[git_ssh_url\]\]", $p_git_ssh_url -replace "\[\[devOps_org_name\]\]", $p_devOps_org_name -replace "\[\[devOps_project_name\]\]", $p_devOps_project_name -replace "\[\[devOps_repo_name\]\]", $p_devOps_repo_name | Set-Content -Path $tfFile.FullName;
        }
        else {
            # Re-apply all placeholder values
            (Get-Content -path $tfFile.FullName -Raw) -replace $p_git_ssh_url, "[[git_ssh_url]]" -replace $p_devOps_org_name, "[[devOps_org_name]]" -replace $p_devOps_project_name, "[[devOps_project_name]]" -replace $p_devOps_repo_name, "[[devOps_repo_name]]" | Set-Content -Path $tfFile.FullName;
        }

        Write-Host "Updated"$tfFile.FullName;
    }
}

Invoke-Command -ScriptBlock $ConfigureTerraformModuleSources -ArgumentList $git_ssh_url, $devOps_org_name, $devOps_project_name, $devOps_repo_name
