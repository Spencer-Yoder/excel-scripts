$excel = New-Object -ComObject Excel.Application # Launch a new Excel instance
$workbook = $excel.Workbooks.Add() # Create a new workbook
$sheet1 = $workbook.Worksheets.Item(1) # Select the first worksheet
$excel.Visible = $true # Make the Excel instance visible

# Get all the .txt files in the folder
$txtFiles = Get-ChildItem -Filter *.txt | Select-Object -ExpandProperty FullName

# Initialize variables
$lastRow = 2 # Start at row 2 for the first file (headers will be in row 1)
$headersAdded = $false # To track whether headers have been added

# Iterate through each text file
foreach ($file in $txtFiles) {
    $col = 1 # Start at the first column

    # Read the file and process each line
    $content = Get-Content $file
    $rowData = @{} # To store key-value pairs for this file

    foreach ($line in $content) {
        # Split each line at the '=' sign to separate key and value
        $parts = $line -split '='
        $key = $parts[0].Trim() # Key is the first part
        $value = $parts[1].Trim() # Value is the second part

        # If headers haven't been added yet, add them in row 1
        if (-not $headersAdded) {
            $sheet1.Cells.Item(1, $col) = $key
        }

        # Store the value in the appropriate column for the current row
        $sheet1.Cells.Item($lastRow, $col) = $value

        $col++ # Move to the next column
    }

    $headersAdded = $true # Headers have now been added
    $lastRow++ # Move to the next row for the next file
}

# Save the workbook (optional)
# $workbook.SaveAs("output.xlsx")

# Cleanup (optional)
# $excel.Quit()
# [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel)
