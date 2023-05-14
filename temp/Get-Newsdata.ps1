function Get-Newsdata {
    param(
        [string]$apiKey,
        [string]$q,
        [string]$country,
        [string]$category,
        [string]$sources,
        [string]$domains,
        [string]$excludeDomains,
        [string]$from,
        [string]$to,
        [string]$language,
        [string]$sortBy,
        [string]$page
    )

    $uri = "https://newsdata.io/api/1/news"

    $queryParameters = @{
        apiKey         = $apiKey
        q              = $q
        country        = $country
        sources        = $sources
        domains        = $domains
        excludeDomains = $excludeDomains
        from           = $from
        to             = $to
        cetegory       = $category
        language       = $language
        sortBy         = $sortBy
        page           = $page
    }

    $queryString = [System.Web.HttpUtility]::ParseQueryString("")
    foreach ($param in $queryParameters.GetEnumerator()) {
        if ($param.Value) {
            $queryString[$param.Key] = $param.Value
        }
    }

    $uri += "?" + $queryString.ToString()
	
    write-verbose $uri -verbose

    $client = New-Object System.Net.Http.HttpClient
    $response = $client.GetAsync($uri).Result
    $result = $response.Content.ReadAsStringAsync().Result

    return $result
}

<# 
($data | Convertfrom-Json).results | fl title,link,keywords,country,description,pubdate,creator
($data | Convertfrom-Json).results | ?{$_.keywords -match "crypto"} | fl title,link,keywords,country,description,pubdate,creator
#>
