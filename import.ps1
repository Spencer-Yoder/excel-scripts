$excel = New-object -ComObject Excel.Application

$workbook = $excel.workbooks.add()
$sheet1 = $workbook.worksheets.item(1)

$lastrow = $workbook.worksheets.usedrange.rows.count + 1

$excel.visible = $true

Get-ChildItem -Filter *.csv | Select-Object -ExpandProperty FullName | Import-Csv | Foreach-Object { 
    $sheet1.cells.item($lastrow, "a") = $_.a
    $sheet1.cells.item($lastrow, "b") = $_.b
    $sheet1.cells.item($lastrow, "c") = $_.c
    $sheet1.cells.item($lastrow, "d") = $_.d
    $sheet1.cells.item($lastrow, "e") = $_.e
    
    $lastrow++
}

Remove-Item *.csv
