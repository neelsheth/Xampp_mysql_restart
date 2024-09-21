# in C:\xampp\mysql\repair-mysql-data.ps1 , add below file , save , and just open with terminal

# Delete existing data_old directory (Not Tested)
# Remove-Item -Path "./data_old" -Recurse -Force

# Backup old data
Rename-Item -Path "./data" -NewName "./data_old"

# Create new data directory
Copy-Item -Path "./backup" -Destination "./data" -Recurse
Remove-Item "./data/test" -Recurse
$dbPaths = Get-ChildItem -Path "./data_old" -Exclude ('mysql', 'performance_schema', 'phpmyadmin') -Recurse -Directory
Copy-Item -Path $dbPaths.FullName -Destination "./data" -Recurse
Copy-Item -Path "./data_old/ibdata1" -Destination "./data/ibdata1"

# Notify user
Write-Host "Finished repairing MySQL data"
Write-Host "Previous data is located at ./data_old"

