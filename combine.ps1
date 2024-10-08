# # Install the required module if you don't have it
# Install-Module -Name ImportExcel -Force

# Import the module
Import-Module ImportExcel

# # Define directory where the text files are located
# $directory = "C:\path\to\your\files"

# Get all text files in the directory
$textFiles = Get-ChildItem -Filter *.txt

# Initialize an array to hold all rows
$allRows = @()

# Loop through each text file
foreach ($file in $textFiles) {
    # Read the file content
    $content = Get-Content -Path $file.FullName

    # Initialize a hashtable for the current row (for each file)
    $row = @{}

    # Parse the key-value pairs
    foreach ($line in $content) {
        $key, $value = $line -split "="
        $row[$key] = $value
    }

    # Add the parsed row to the array
    $allRows += New-Object PSObject -Property $row
}

# Define the Excel file path
$excelFilePath = "C:\path\to\output\combined.xlsx"

# Export the data to an Excel file
$allRows | Export-Excel -AutoSize

Write-Host "Excel file created at $excelFilePath"
