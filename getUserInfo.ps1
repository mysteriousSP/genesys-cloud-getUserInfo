# Genesys Cloud API credentials; find the clientID and Client Secret in the Genesys Admin portal
$clientId = 'clientID-goes-here'
$clientSecret = 'clientSecret-Goes-Here'
$environment = 'usw2.pure.cloud'
#change the environment to match yours

function Get-AccessToken {
    param ($clientId, $clientSecret, $environment)
    $credentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($clientId):$($clientSecret)"))
    $authUrl = "https://login.$environment/oauth/token"
    $headers = @{
        Authorization = "Basic $credentials"
        'Content-Type' = 'application/x-www-form-urlencoded'
    }
    $body = "grant_type=client_credentials"
    $response = Invoke-RestMethod -Uri $authUrl -Method Post -Headers $headers -Body $body
    return $response.access_token
}

function Search-Users {
    param ($accessToken, $environment, $userName)
    $apiHeaders = @{
        Authorization = "Bearer $accessToken"
        'Content-Type' = 'application/json'
    }
    $searchUrl = "https://api.$environment/api/v2/users/search"
    $searchBody = @{
        query = @(
            @{
                fields = @("name")
                value = $userName
                type = "CONTAINS"
            }
        )
        pageSize = 25
        pageNumber = 1
    } | ConvertTo-Json -Depth 4
    $response = Invoke-RestMethod -Uri $searchUrl -Method Post -Headers $apiHeaders -Body $searchBody
    return $response
}

function Get-UserDetails {
    param ($accessToken, $environment, $userId)
    $apiHeaders = @{
        Authorization = "Bearer $accessToken"
        'Content-Type' = 'application/json'
    }
    $userUrl = "https://api.$environment/api/v2/users/$userId`?expand=skills,languages,locations,roles,certifications,groups,team,station,profileSkills,acdAutoAnswer"
    $response = Invoke-RestMethod -Uri $userUrl -Method Get -Headers $apiHeaders
    return $response
}

# Main script
$accessToken = Get-AccessToken -clientId $clientId -clientSecret $clientSecret -environment $environment

do {
    $userName = Read-Host "Enter the full name of the user to search for"
    $searchResults = Search-Users -accessToken $accessToken -environment $environment -userName $userName

    if ($searchResults.total -gt 0) {
        foreach ($user in $searchResults.results) {
            # Get detailed user information
            $userDetails = Get-UserDetails -accessToken $accessToken -environment $environment -userId $user.id
            
            # Output raw user details directly to console
            Write-Output "`nUser Details:"
            Write-Output ($userDetails | ConvertTo-Json -Depth 4)  # Convert to JSON for better readability of raw output
        }
        Write-Output "`nTotal users found: $($searchResults.total)"
    } else {
        Write-Output "`nNo users found matching the given name."
    }

    # Ask if the user wants to perform another search
    $continueSearch = Read-Host "`nDo you want to perform another search? (yes/no)"
} while ($continueSearch -eq 'yes')

Write-Output "`nThank you for using the Genesys Cloud User Search. Goodbye!"
