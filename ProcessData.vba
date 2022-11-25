' Date Column
Public Const DATE_COLUMN As Integer = 3
' Number of days minus from today, to recalculate the formulas
Public Const BACK_DATE As Integer = 30


Sub ProcessData()
      Dim rowNum As Integer
      
      ' Get total number or rows in the sheet
      totalRows = Range("A1", Range("A1").End(xlDown)).Rows.Count
      
      ' Loop Through all rows in the sheet. Starting after the header in row 1
      For rowNum = 2 To totalRows
        ' Get and Save the row date
        Dim rowDate As Range
        Set rowDate = Cells(rowNum, DATE_COLUMN)
        
        ' Check to see if the date is within BACK_DATE numbers of days from today
        If IsDate(rowDate.Value) _
        And rowDate.Value > Date - BACK_DATE Then
            Row (rowNum)
        End If
      Next
      
    Debug.Print "--****--"
End Sub

Private Sub Row(rowNum)
    'Cells(rowNum, 7).Value = Application.Evaluate("SUM(D" & rowNum & ":E" & rowNum & ")")
End Sub
