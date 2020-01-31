Param(
    [Parameter(Mandatory=$false)]
        [string]$SubscriptionID
   ,[Parameter(Mandatory=$false)]
        [string]$Type
   ,[Parameter(Mandatory=$false)]
        [string]$application_name
   ,[Parameter(Mandatory=$false)]
        [string]$regionID
   ,[Parameter(Mandatory=$false)]
        [Object]$tagsArray
   ,[Parameter(Mandatory=$false)]
        [string]$ResourceGroupName
)

if(!$subscriptionID) {$SubscriptionID  = '921a4b2a-3b6a-4205-8ca7-e43a1fd401af'}
if(!$ResourceGroupName) {$ResourceGroupName =  'Test_lab_1'}

# Get Resource group or creating the new one
Get-AzResourceGroup -Name $ResourceGroupName -ErrorVariable notPresent
if ($notPresent) {
 $ArtResGr = New-AzResourceGroup -name $Resourcegroupname -location $Location -Verbose
 }

function Login($SubscriptionId)
{
    $context = Get-AzContext

    if (!$context -or ($context.Subscription.Id -ne $SubscriptionId)) 
    {
        Connect-AzAccount -Subscription $SubscriptionId
    } 
    else 
    {
        Write-Host "SubscriptionId '$SubscriptionId' already connected"
    }
}
Login($subscriptionID)


if (!$Type) {$Type = 'web'}
if (!$application_name) {$application_name = '3E_TEMPLATES'}
if (!$Tagsarray) {$Tagsarray =  @{'Application' ="3ETemplates"}}
if (!$Type) {$Type = 'web'}
$paramObject = @{
    'application_name' = "$application_name"
    'type' = "$type"
    'requestSource' = 'IbizaAIExtension'
    'tagsArray' = $tagsArray
        }
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile "C:\Azure_test\APP Insights\template.json" -TemplateParameterObject $paramObject