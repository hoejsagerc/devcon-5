using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$Name = $Request.Body.Name
$Image = $Request.Body.Image
$Username = $Request.Body.Username
$Id = Get-Random -Minimum 1000 -Maximum 9999

$Message = "{'instanceName':'$($Name)-$($Id)','image':'$($Image)','username':'$($Username)','id':'$($Id)'}"

try {
    Write-Host "Pushing to outputTable"
    Push-OutputBinding -Name outputTable -Value @{
        PartitionKey = 'DEVSPACE'
        RowKey = "$Id"
        InstanceName = "$Name-$Id"
        Image = "$Image"
        Username = "$Username"
        Status = "Pending"
    }
    Write-Host "Pushing to outputQueueItem"
    Push-OutputBinding -Name outputQueueItem -Value $Message 
    Write-Host "Pushing to Response"
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = 201
        Body = $Message
    })
}
catch {
    write-error -message "$_"
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = 500 
        Body = "Request failed - Returning 500"
    })
}
