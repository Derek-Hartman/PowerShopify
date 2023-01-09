<#
.Synopsis
    Set customer tag.

.EXAMPLE
    New-ShopifyCustomer -CompURL "verabradley-dev" -Token "Token" -FirstName "Bob" -LastName "Saget" -Email "bsaget@gmail.com" Password "Password" -Tag "Test"

.NOTES
    Modified by: Derek Hartman
    Date: 6/24/2022

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function New-ShopifyCustomer {
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
            HelpMessage = "Enter your Customer's First Name.")]
        [string[]]$FirstName,
		
		[Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Customer's Last Name.")]
        [string[]]$LastName,
		
		[Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Customer's Email.")]
        [string[]]$Email,
		
		[Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Customer's Password.")]
        [string[]]$Password,
		
		[Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Customer Tag.")]
        [string[]]$Tag

    )

    $Uri = @{
		"Customers" = "https://$CompURL.myshopify.com/admin/api/2022-04/customers.json"
    }

    $Header = @{
        'X-Shopify-Access-Token'   = "$Token"
        'Content-Type'  = 'application/json';
    }
	
	$Body = @{"first_name" = "$FirstName"}
	$Body += @{"last_name" = "$LastName"}
	$Body += @{"email" = "$Email"}
	$Body += @{"password" = "$Password"}
	$Body += @{"password_confirmation" = "$Password"}
	$Body += @{"send_email_welcome" = $False}
	$Body += @{"tags" = "$Tag"}

	$OuterBody = @{ "customer" = $Body }

	$PostData = ConvertTo-Json $OuterBody

    $Customers = Invoke-WebRequest -Method Post -Uri $Uri.Customers -Body $PostData -Headers $Header
	$JsonData = $Customers.Content | ConvertFrom-Json
	$OutPut = $JsonData.Customer
    Write-Output $OutPut
}