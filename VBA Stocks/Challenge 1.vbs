Sub StockCalc():

'declaring numeric variables as longs and doubles to avoid overflow errors
Dim n As Long
Dim m As Long
Dim j As Long
Dim i As Long
Dim myPerc As Double
Dim myYearOpen As Double
Dim myYearClose As Double
Dim myVol As Double
Dim myYear As Double
Dim myBig As Double
Dim mysmall As Double
Dim bigvol As Double


'naming headers
Cells(1, 9).Value = "Ticker"
Cells(1, 10).Value = "Yearly Change"
Cells(1, 11).Value = "Percent Change"
Cells(1, 12).Value = "Total Stock Volume"
Cells(1, 15).Value = "Ticker"
Cells(1, 16).Value = "Value"
Cells(2, 14).Value = "Greatest % Increase"
Cells(3, 14).Value = "Greatest % Decrease"
Cells(4, 14).Value = "Greatest Total Volume"

'assigning counters
n = 1
m = 2

'assigning variables to be changed and checked
myTick = Cells(2, 1).Value
myStock = Cells(1 + n, 1).Value


    'while row is not empty
    While Not IsEmpty(myStock)
        
        'counters for each tick
        j = 1
        myVol = 0
        
        'open price at beginning of year
        myYearOpen = Cells(n + j, 3).Value
    
        
        'iterate through all the stocks w/ same ticker
            While myStock = myTick And Not IsEmpty(myStock)
                
                'find first open value of a new ticker
                If j = 1 Then
                myYearOpen = CDbl(Cells(n + j, 3).Value)
                End If
                
                'add vol to count for this stock
                myVol = myVol + Cells(n + j, 7).Value
                
                'go to next stock and add to count
                myStock = Cells(n + j + 1, 1).Value
                j = j + 1
            
            Wend
            
        'closing price at end of year
        myYearClose = CDbl(Cells(n + j - 1, 6).Value)

        'Percent Change
        If myYearOpen = 0 Then
        myPerc = 0
        Else
        myPerc = ((myYearClose - myYearOpen) / myYearOpen)
        End If
    
        'yearly Change
        myYear = myYearClose - myYearOpen
        
        'assign values to ticker
        Cells(m, 9).Value = myTick
        Cells(m, 10).Value = myYear
        
        'fill color based on pos or neg
        If Cells(m, 10).Value > 0 Then
            Cells(m, 10).Interior.Color = RGB(0, 255, 0)
        ElseIf Cells(m, 10).Value < 0 Then
            Cells(m, 10).Interior.Color = RGB(255, 0, 0)
        End If
        
        Cells(m, 11).Value = FormatPercent(myPerc, 2)
        Cells(m, 12).Value = myVol
        
        'iterate counts
        myTick = myStock
        n = n + j - 1
        m = m + 1
        
    Wend

'determining number of tickers
myRows = Cells(Rows.Count, 9).End(xlUp).Row

'setting first tick as biggest
myBig = Cells(2, 11).Value
Cells(2, 15).Value = Cells(2, 9).Value

'setting first tick as smallest
mysmall = Cells(2, 11).Value
Cells(3, 15).Value = Cells(2, 9).Value

'setting first tick as biggest volumer
bigvol = Cells(2, 12).Value
Cells(4, 15).Value = Cells(2, 9).Value

'iterate through created list
For i = 1 To myRows

    'find max increase
    If Cells(2 + i, 11).Value > myBig Then
        myBig = Cells(2 + i, 11).Value
        Cells(2, 15).Value = Cells(2 + i, 9).Value
        Cells(2, 16).Value = FormatPercent(myBig, 2)
    End If
    
    'find max decrease
    If Cells(2 + i, 11).Value < mysmall Then
        mysmall = Cells(2 + i, 11).Value
        Cells(3, 15).Value = Cells(2 + i, 9).Value
        Cells(3, 16).Value = FormatPercent(mysmall, 2)
    End If
      
    'find max volume
    If Cells(2 + i, 12).Value > bigvol Then
        bigvol = Cells(2 + i, 12).Value
        Cells(4, 15).Value = Cells(2 + i, 9).Value
        Cells(4, 16).Value = bigvol
    End If
              
Next i
       
End Sub


