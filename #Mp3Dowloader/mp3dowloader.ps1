[Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null


function mp3download(){
[cmdletbinding()]

param(
    [Parameter(mandatory=$true,Position=1)]
    [string] $url,

    [string] $rootFolder = "R:\Mp3"

)

    Write-Host "Running URL $url, Folder: $rootFolder" -ForegroundColor Green

    $DecodeURL = [System.Web.HttpUtility]::UrlDecode($URL) 

    $chunks = $DecodeURL -split "/"

    $folderName = $chunks[-2]

    $folder = $rootFolder + "\" + $folderName

    $folder = $folder -replace "\\","\"

    if(-not (Test-Path -LiteralPath $folder)){
                    
        New-Item -ItemType Directory -Path $folder
    
    }

    #Write-Host "Running invoke on $url" -ForegroundColor Green
    $result = Invoke-WebRequest $url -UserAgent "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:51.0) Gecko/20100101 Firefox/57.0"
    $links = $result.Links.href | where {$_ -NotLike "../"}


    foreach($item in $links){
    
        if( ($item -split "/").Count -gt 1){     
            
            $newFolder = $folder
            $newFolder = $newFolder -replace "/","\"

            $newUrl = $DecodeURL + $item    
            
            Write-Host "$newFolder $newUrl"
            mp3download -url $newUrl -rootFolder $newFolder                       
        }else{            
            $download_url = $DecodeURL + $item
            $output = $folder + "\" + $item
            $output = $output -replace "\\","\"

            $output_decoded = [System.Web.HttpUtility]::UrlDecode($output)
            
            if(-not (Test-Path -LiteralPath $output_decoded)){
                #Fix for wildcard e.g. [ ] ! , path
                Invoke-WebRequest -Uri $download_url  -OutVariable download
                [io.file]::WriteAllBytes($output_decoded, $download.Content)
            }
            
        }

    }





}

