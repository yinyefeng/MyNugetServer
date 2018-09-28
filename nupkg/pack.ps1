# Paths
$packFolder = (Get-Item -Path "./" -Verbose).FullName
$slnPath = Join-Path $packFolder "../"
$srcPath = Join-Path $slnPath "src"

# List of projects
$projects = (    
    "MyNugetServer"    
)

# Rebuild solution
Set-Location $slnPath

# Copy all nuget packages to the pack folder
foreach($project in $projects) {
    
    $projectFolder = Join-Path $srcPath $project
    $projectFileName = $project + ".csproj"

    # Create nuget pack
    Set-Location $projectFolder

    Remove-Item -Recurse (Join-Path $projectFolder "bin/Release")
    nuget pack $projectFileName -Build -Prop Configuration=Release -OutputDirectory .\bin\Release
    
    #& dotnet msbuild /p:Configuration=Release /p:SourceLinkCreate=true
    #& dotnet msbuild /t:pack /p:Configuration=Release /p:SourceLinkCreate=true

    # Copy nuget package
    $projectPackPath = Join-Path $projectFolder ("/bin/Release/" + $project + ".*.nupkg")
    Move-Item $projectPackPath $packFolder -Force
}

# Go back to the pack folder
Set-Location $packFolder