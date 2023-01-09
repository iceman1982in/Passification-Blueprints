<#  
    
  
#>

param
( 
	  [string]$tf_storageacct,
	  [string]$tf_containername,
      [string]$tf_key,
	  [string]$tf_storagekey,
      [switch]$reapply_placeholders = $false
)

$ReplaceTokens = {
    Param(
        [string]$p_tf_storageacct,
		[string]$p_tf_containername,
        [string]$p_tf_key,
		[string]$p_tf_storagekey
        )
        
    $files = Get-ChildItem -Directory -Recurse | ?{ $_.Name -eq "terraform" } | Get-ChildItem -File -Recurse -Include "*.tf" | ?{ $_.FullName -notlike '*.terraform*' } #| %{ $_.FullName; }
    $filesCleaned = $files | ? {$_.Extension -eq '.tf' }

    # Replace the following text with parameter values
    # [[git_ssh_url]]/[[devOps_org_name]]/[[devOps_project_name]]/[[devOps_repo_name]]

    foreach($tfFile in $filesCleaned) {
        
        if($reapply_placeholders -eq $false) {
            # Replace all placeholder values with full source path
            (Get-Content -path $tfFile.FullName -Raw) -replace "\[\[tf_storageacct\]\]", $p_tf_storageacct -replace "\[\[tf_containername\]\]", $p_tf_containername -replace "\[\[tf_key\]\]", $p_tf_key -replace "\[\[tf_storagekey\]\]", $p_tf_storagekey | Set-Content -Path $tfFile.FullName;
        }
        else {
            # Re-apply all placeholder values
            (Get-Content -path $tfFile.FullName -Raw) -replace $tf_storageacct, "[[tf_storageacct]]" -replace $tf_containername, "[[tf_containername]]" -replace $tf_key, "[[tf_key]]" -replace $tf_storagekey, "[[tf_storagekey]]" | Set-Content -Path $tfFile.FullName;
        }

        Write-Host "Updated"$tfFile.FullName;
    }
}

Invoke-Command -ScriptBlock $ReplaceTokens -ArgumentList $tf_storageacct, $tf_containername, $tf_key, $tf_storagekey
