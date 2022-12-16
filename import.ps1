$excel = New-object -ComObject Excel.Application # Launch a new excel instance

$workbook = $excel.workbooks.add() # Create a new workbook
$sheet1 = $workbook.worksheets.item(1) # Create a new sheet

$lastrow = $workbook.worksheets.usedrange.rows.count + 1 # find the last row. Since this is a new worksheet, this will always be 1

$excel.visible = $true # Make the Excel instance visible

# 1. List all the .csv files in the folder
# 2. Parse out the full file name
# 3. Inport the csv into powershell
# 4. For ever file do the following
Get-ChildItem -Filter *.csv | Select-Object -ExpandProperty FullName | Import-Csv | Foreach-Object { 
    $col = 0 # set a counter to tell what column is selected

    # For every column on the row in the input csv, starting at "A"
    foreach ($property in $_.PSObject.Property) {
        $column = [char](65 + $col) # Convert column index into corresponding column letter. The powershell csv import saved them as a number.
        $sheet1.cells.itme($lastrow, "$column") = $property.Value # Copy the contents of the cell and place it into the correct column at the bottom in the new excel doc
        $col = $col + 1 # Move to the next column
    }
    $lastrow++ # Move to the next row

    # Move to the next input file
}

Remove-Item *.csv # delete all the input .csv files
