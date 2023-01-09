<#
.Synopsis
    Get 250max customers.

.EXAMPLE
    Get-ShopifyCustomers -CompURL "verabradley-dev" -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 6/24/2022

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-ShopifyCustomers {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Companies URL.")]
        [string[]]$CompURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Shopify Token.")]
        [string[]]$Token

    )

    $Uri = @{
		"Customers" = "https://$CompURL.myshopify.com/admin/api/2022-04/customers.json?limit=250"
    }

    $Header = @{
        'X-Shopify-Access-Token'   = "$Token"
        'Content-Type'  = 'application/json';
    }  

    $Customers = Invoke-WebRequest -Method Get -Uri $Uri.Customers -Headers $Header
	$JsonData = $Customers.Content | ConvertFrom-Json
	$OutPut = $JsonData.Customers
    Write-Output $OutPut
}