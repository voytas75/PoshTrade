function Get-Newsdata {
    param(
        [string]$apiKey,
        [string]$q,
        [string]$sources,
        [string]$domains,
        [string]$excludeDomains,
        [string]$from,
        [string]$to,
        [string]$language,
        [string]$sortBy,
        [string]$pageSize,
        [string]$page,
		[string]$category = "business,technology,top"
    )

    $uri = "https://newsdata.io/api/1/news"

    $queryParameters = @{
        apiKey = $apiKey
        q = $q
        sources = $sources
        domains = $domains
        excludeDomains = $excludeDomains
        from = $from
        to = $to
        language = $language
        sortBy = $sortBy
        pageSize = $pageSize
        page = $page
		cetegory = $category
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

#https://newsdata.io/api/1/archive?apikey=pub_221372b0f58522823328d361f07fac7fa40cf&q=example&language=en&from_date=2023-01-19&to_date=2023-01-25

Categories
business
technology
top
