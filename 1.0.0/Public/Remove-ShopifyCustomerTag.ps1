<#
.Synopsis
    Remove customer tags.

.EXAMPLE
    Remove-ShopifyCustomerTag -CompURL "verabradley-dev" -Token "Token" -CustomerID "5822010196065"

.NOTES
    Modified by: Derek Hartman
    Date: 6/24/2022

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Remove-ShopifyCustomerTag {
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
            HelpMessage = "Enter your Customer ID.")]
        [string[]]$CustomerID

    )

    $Uri = @{
		"Customers" = "https://$CompURL.myshopify.com/admin/api/2022-04/customers/$CustomerID.json"
    }

    $Header = @{
        'X-Shopify-Access-Token'   = "$Token"
        'Content-Type'  = 'application/json';
    }
	
	$Body = @{"id" = "$CustomerID"}
	$Body += @{"tags" = ""}

	$OuterBody = @{ "customer" = $Body }

	$PostData = ConvertTo-Json $OuterBody

    $Customers = Invoke-WebRequest -Method Put -Uri $Uri.Customers -Body $PostData -Headers $Header
	$JsonData = $Customers.Content | ConvertFrom-Json
	$OutPut = $JsonData.Customer
    Write-Output $OutPut
}