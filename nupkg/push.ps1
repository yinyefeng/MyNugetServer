# Paths
$nupkgFiles = (Get-Item *.nupkg).FullName

# Copy all nuget packages to the pack folder
foreach($nupkgFile in $nupkgFiles) {
    nuget push $nupkgFile -Source http://121.40.41.127:8003/nuget -ApiKey nu861@928
    Remove-Item $nupkgFile
}