
function Create-Directories($base, $yaml) {

    if ($yaml -eq $null) { return }


    foreach($key in $yaml.keys) {

        if ($yaml.$key.keys -ne $null) {
            New-Item -Name $key -Path $base -Type Container -Force | Out-Null
            Create-Directories $base\$key $yaml.$key
        } else {
            $yaml.$key | Out-File -FilePath $base\$key
        }
    }
}


function Setup($setupItem, $faml = $null) {
    New-Item -Name pester -Path $env:Temp -Type Container -Force | Out-Null

    if ($faml -eq $null) { return }

    $yaml = Get-Yaml -YamlString $faml
    Create-Directories $env:temp\pester $yaml
}
