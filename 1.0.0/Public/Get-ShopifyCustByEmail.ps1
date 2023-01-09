<#
.Synopsis
    Get customer by email address.

.EXAMPLE
    Get-ShopifyCustByEmail -CompURL "verabradley-dev" -Token "Token" -Email "shoppower@verabradley.com"

.NOTES
    Modified by: Derek Hartman
    Date: 6/24/2022

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-ShopifyCustByEmail {
    [CmdletBinding()]

    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Companies URL.")]
        [string[]]$CompURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Shopify Token.")]
        [string[]]$Token,
		
		[Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Email to Search.")]
        [string[]]$Email

    )

    $Uri = @{
		"Customers" = "https://$CompURL.myshopify.com/admin/api/2022-04/customers/search.json?query=$Email"
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