Attribute VB_Name = "���������"
Rem ***************************************************************************
Rem ***************************************************************************
Rem **                                                                       **
Rem ** THIS SOFTWARE PROVIDES NO WARRANITY AND DISTRIBUTED UNDER             **
Rem **                                              GNU GPL LICENCE          **
Rem ***************************************************************************
Rem ***************************************************************************

Option Explicit

Rem ������������ ������
Public Enum Casus
    �����
    ������
    ������
    ������
    [_TotalCasi]
End Enum

Rem ������ ���� �������� �����
Private Enum Expo
    unitExp
    thouExp
    millExp
    billExp
    trilExp
    [_TotalExpo]
End Enum

Rem ������������ ��� �����������, �������������� ���� � ��� ��� ��� ���
Public Enum ExistVAT
    ������
    ����
End Enum

Private Enum Sex
    MaleSex
    FemaleSex
    [_TotalSexes]
End Enum

Private Type WORD
    Casi(2 * [_TotalCasi]) As String
    sx As Sex
End Type

Rem ***************************************************************************
Rem ***************************************************************************
Rem **                                                                       **
Rem **         *   * ***** *   *  **** *****  *   *   * ***** *   *          **
Rem **         *  *  *   * *   * *       *   * *  *   *   *   *   *          **
Rem **         ***   *   * ***** *       *  *   * *****   *   **  *          **
Rem **         *  *  *   * *   * *       *  ***** *   *   *   * * *          **
Rem **         *   * ***** *   *  ****   *  *   * *   *   *   **  *          **
Rem **                                                                       **
Rem ***************************************************************************
Rem ***************************************************************************

Rem ��������� ������
Private Enum errors
    WSexErr = vbError + 513 ' Wrong Sex Error
    WCasErr '                 Wrong Casus Error
    WNumErr '                 Wrong Number Error
    VnFErr '                  Value not Found Error
    [_TotalErrors]
End Enum

Rem ��������� ������� ���������� ����������� ��������

Rem �������, ������������ ��������� �� ������
Private Function Cents() As WORD
    With Cents
        .Casi(�����) = "�������":  .Casi(GetPlural(�����)) = "�������"
        .Casi(������) = "�������": .Casi(GetPlural(������)) = "������"
        .Casi(������) = "�������": .Casi(GetPlural(������)) = "��������"
        .Casi(������) = "�������": .Casi(GetPlural(������)) = "�������"
        .sx = FemaleSex
    End With
End Function

Rem �������, ������������ ��������� �� ������
Private Function Rubles() As WORD
    With Rubles
        .Casi(�����) = "�����":  .Casi(GetPlural(�����)) = "�����"
        .Casi(������) = "�����": .Casi(GetPlural(������)) = "������"
        .Casi(������) = "�����": .Casi(GetPlural(������)) = "������"
        .Casi(������) = "�����": .Casi(GetPlural(������)) = "�����"
        .sx = MaleSex
    End With
End Function

Rem �������, ������������ ��������� �� �����
Private Function Thousands() As WORD
    With Thousands
        .Casi(�����) = "������":  .Casi(GetPlural(�����)) = "������"
        .Casi(������) = "������": .Casi(GetPlural(������)) = "�����"
        .Casi(������) = "������": .Casi(GetPlural(������)) = "�������"
        .Casi(������) = "������": .Casi(GetPlural(������)) = "������"
        .sx = FemaleSex
    End With
End Function

Rem �������, ������������ ��������� �� ���������
Private Function Millions() As WORD
    With Millions
        .Casi(�����) = "�������":   .Casi(GetPlural(�����)) = "��������"
        .Casi(������) = "��������": .Casi(GetPlural(������)) = "���������"
        .Casi(������) = "��������": .Casi(GetPlural(������)) = "���������"
        .Casi(������) = "�������":  .Casi(GetPlural(������)) = "��������"
        .sx = MaleSex
    End With
End Function

Rem �������, ������������ ��������� �� ����������
Private Function Billions() As WORD
    With Billions
        .Casi(�����) = "��������":   .Casi(GetPlural(�����)) = "���������"
        .Casi(������) = "���������": .Casi(GetPlural(������)) = "����������"
        .Casi(������) = "���������": .Casi(GetPlural(������)) = "����������"
        .Casi(������) = "��������":  .Casi(GetPlural(������)) = "���������"
        .sx = MaleSex
    End With
End Function

Rem �������, ������������ ��������� �� ����������
Private Function Trillions() As WORD
    With Trillions
        .Casi(�����) = "��������":   .Casi(GetPlural(�����)) = "���������"
        .Casi(������) = "���������": .Casi(GetPlural(������)) = "����������"
        .Casi(������) = "���������": .Casi(GetPlural(������)) = "����������"
        .Casi(������) = "��������":  .Casi(GetPlural(������)) = "���������"
        .sx = MaleSex
    End With
End Function

Rem ������� ���������� ����
Private Function Zero(ByVal cas As Casus) As String
    Select Case cas
        Case �����
            Zero = "����"
        Case ������
            Zero = "����"
        Case ������
            Zero = "����"
        Case ������
            Zero = "����"
        Case Else
            Err.Raise WCasErr, Source:="Zero", _
                Description:="������ � ��������� �������"
    End Select
End Function

Rem ������� ���������� �������
Private Function One(ByVal cas As Casus, ByVal sx As Sex) As String
    Select Case sx
        Case MaleSex
            Select Case cas
                Case �����
                    One = "����"
                Case ������
                    One = "������"
                Case ������
                    One = "������"
                Case ������
                    One = "������"
                Case Else
                    Err.Raise WCasErr, Source:="One (male)", _
                        Description:="������ � ��������� �������"
            End Select
        Case FemaleSex
            Select Case cas
                Case �����
                    One = "����"
                Case ������
                    One = "�����"
                Case ������
                    One = "�����"
                Case ������
                    One = "����"
                Case Else
                    Err.Raise WCasErr, Source:="One (female)", _
                        Description:="������ � ��������� �������"
            End Select
        Case Else
            Err.Raise WSexErr, Source:="One", _
                Description:="������ � ������ ���������"
    End Select
End Function

Rem ������� ���������� ������
Private Function Two(ByVal cas As Casus, ByVal sx As Sex) As String
    Select Case cas
        Case �����
            Select Case sx
                Case MaleSex
                    Two = "���"
                Case FemaleSex
                    Two = "���"
                Case Else
                    Err.Raise WSexErr, Source:="Two", _
                        Description:="������ � ������ ���������"
            End Select
        Case ������
            Two = "����"
        Case ������
            Two = "����"
        Case ������
            Two = "����"
        Case Else
            Err.Raise WCasErr, Source:="Two", _
                Description:="������ � ��������� �������"
    End Select
End Function

Rem �������, ������������ ����� �� ��������
Private Function ThreeTwenty(ByVal dig As Byte, ByVal cas As Casus) As String
    Dim numbs(19 - 3, [_TotalCasi]) As String
    numbs(3 - 3, �����) = "���"
    numbs(3 - 3, ������) = "���"
    numbs(3 - 3, ������) = "���"
    numbs(3 - 3, ������) = "���"
    
    numbs(4 - 3, �����) = "������"
    numbs(4 - 3, ������) = "������"
    numbs(4 - 3, ������) = "������"
    numbs(4 - 3, ������) = "������"
    
    numbs(5 - 3, �����) = "����"
    numbs(5 - 3, ������) = "����"
    numbs(5 - 3, ������) = "����"
    numbs(5 - 3, ������) = "����"
    
    numbs(6 - 3, �����) = "�����"
    numbs(6 - 3, ������) = "�����"
    numbs(6 - 3, ������) = "�����"
    numbs(6 - 3, ������) = "�����"
    
    numbs(7 - 3, �����) = "����"
    numbs(7 - 3, ������) = "����"
    numbs(7 - 3, ������) = "����"
    numbs(7 - 3, ������) = "����"
    
    numbs(8 - 3, �����) = "������"
    numbs(8 - 3, ������) = "������"
    numbs(8 - 3, ������) = "������"
    numbs(8 - 3, ������) = "������"
    
    numbs(9 - 3, �����) = "������"
    numbs(9 - 3, ������) = "������"
    numbs(9 - 3, ������) = "������"
    numbs(9 - 3, ������) = "������"
    
    numbs(10 - 3, �����) = "������"
    numbs(10 - 3, ������) = "������"
    numbs(10 - 3, ������) = "������"
    numbs(10 - 3, ������) = "������"
    
    numbs(11 - 3, �����) = "�����������"
    numbs(11 - 3, ������) = "�����������"
    numbs(11 - 3, ������) = "�����������"
    numbs(11 - 3, ������) = "�����������"
    
    numbs(12 - 3, �����) = "����������"
    numbs(12 - 3, ������) = "����������"
    numbs(12 - 3, ������) = "����������"
    numbs(12 - 3, ������) = "����������"
    
    numbs(13 - 3, �����) = "����������"
    numbs(13 - 3, ������) = "����������"
    numbs(13 - 3, ������) = "����������"
    numbs(13 - 3, ������) = "����������"
    
    numbs(14 - 3, �����) = "������������"
    numbs(14 - 3, ������) = "������������"
    numbs(14 - 3, ������) = "������������"
    numbs(14 - 3, ������) = "������������"
    
    numbs(15 - 3, �����) = "����������"
    numbs(15 - 3, ������) = "����������"
    numbs(15 - 3, ������) = "����������"
    numbs(15 - 3, ������) = "����������"
    
    numbs(16 - 3, �����) = "�����������"
    numbs(16 - 3, ������) = "�����������"
    numbs(16 - 3, ������) = "�����������"
    numbs(16 - 3, ������) = "�����������"
    
    numbs(17 - 3, �����) = "����������"
    numbs(17 - 3, ������) = "����������"
    numbs(17 - 3, ������) = "����������"
    numbs(17 - 3, ������) = "����������"
    
    numbs(18 - 3, �����) = "������������"
    numbs(18 - 3, ������) = "������������"
    numbs(18 - 3, ������) = "������������"
    numbs(18 - 3, ������) = "������������"
    
    numbs(19 - 3, �����) = "������������"
    numbs(19 - 3, ������) = "������������"
    numbs(19 - 3, ������) = "������������"
    numbs(19 - 3, ������) = "������������"
    
    ThreeTwenty = numbs(dig - 3, cas)
End Function

Private Function Ten(ByVal dig As Byte, cas As Casus) As String
    Dim numbs(9, [_TotalCasi]) As String
        
    numbs(2, �����) = "��������"
    numbs(2, ������) = "��������"
    numbs(2, ������) = "��������"
    numbs(2, ������) = "��������"
    
    numbs(3, �����) = "��������"
    numbs(3, ������) = "��������"
    numbs(3, ������) = "��������"
    numbs(3, ������) = "��������"
    
    numbs(4, �����) = "�����"
    numbs(4, ������) = "������"
    numbs(4, ������) = "������"
    numbs(4, ������) = "�����"
    
    numbs(5, �����) = "���������"
    numbs(5, ������) = "����������"
    numbs(5, ������) = "����������"
    numbs(5, ������) = "���������"
    
    numbs(6, �����) = "����������"
    numbs(6, ������) = "�����������"
    numbs(6, ������) = "�����������"
    numbs(6, ������) = "����������"
    
    numbs(7, �����) = "���������"
    numbs(7, ������) = "����������"
    numbs(7, ������) = "����������"
    numbs(7, ������) = "���������"
    
    numbs(8, �����) = "�����������"
    numbs(8, ������) = "������������"
    numbs(8, ������) = "������������"
    numbs(8, ������) = "�����������"
    
    numbs(9, �����) = "���������"
    numbs(9, ������) = "���������"
    numbs(9, ������) = "���������"
    numbs(9, ������) = "���������"
    
    Ten = numbs(dig, cas)
End Function

Private Function Hundred(ByVal dig As Byte, cas As Casus) As String
    Dim numbs(9, [_TotalCasi]) As String
        
    numbs(1, �����) = "���"
    numbs(1, ������) = "���"
    numbs(1, ������) = "���"
    numbs(1, ������) = "���"
        
    numbs(2, �����) = "������"
    numbs(2, ������) = "������"
    numbs(2, ������) = "������"
    numbs(2, ������) = "������"
    
    numbs(3, �����) = "������"
    numbs(3, ������) = "������"
    numbs(3, ������) = "������"
    numbs(3, ������) = "������"
    
    numbs(4, �����) = "���������"
    numbs(4, ������) = "���������"
    numbs(4, ������) = "���������"
    numbs(4, ������) = "���������"
    
    numbs(5, �����) = "�������"
    numbs(5, ������) = "�������"
    numbs(5, ������) = "�������"
    numbs(5, ������) = "�������"
    
    numbs(6, �����) = "��������"
    numbs(6, ������) = "��������"
    numbs(6, ������) = "��������"
    numbs(6, ������) = "��������"
    
    numbs(7, �����) = "�������"
    numbs(7, ������) = "�������"
    numbs(7, ������) = "�������"
    numbs(7, ������) = "�������"
    
    numbs(8, �����) = "���������"
    numbs(8, ������) = "���������"
    numbs(8, ������) = "���������"
    numbs(8, ������) = "���������"
    
    numbs(9, �����) = "���������"
    numbs(9, ������) = "���������"
    numbs(9, ������) = "���������"
    numbs(9, ������) = "���������"
    
    Hundred = numbs(dig, cas)
End Function

Rem ***************************************************************************
Rem ***************************************************************************
Rem **                                                                       **
Rem **                         *   *   *   ***** *   *                       **
Rem **                         ** **  * *    *   **  *                       **
Rem **                         * * * *   *   *   * * *                       **
Rem **                         *   * *****   *   *  **                       **
Rem **                         *   * *   * ***** *   *                       **
Rem **                                                                       **
Rem ***************************************************************************
Rem ***************************************************************************

Rem ������� ��������� � ������������� �����
Private Function GetPlural(ByVal cas As Casus) As Casus
    GetPlural = cas + [_TotalCasi]
End Function

Rem ������� ���������� ������� �����, ������ 1000
Private Function ThWord(ByVal num As Integer, _
                        ByVal cas As Casus, _
                        ByRef unit As WORD, _
                        ByVal getpar As Boolean) As String
    If num > 1000 Then _
        Err.Raise WNumErr, _
                  Source:="ThWord", _
                  Description:="�������� ���� 1000"
    ThWord = Trim(Hundred(num \ 100, cas) & " " & _
        DigWord(num Mod 100, cas, unit.sx))
    If (num Mod 10 >= 2 And num Mod 10 <= 4) And _
          (num Mod 100 < 12 Or num Mod 100 > 14) Then
        Select Case cas
            Case �����
                cas = ������
            Case ������
                cas = GetPlural(������)
            Case ������
                cas = ������
            Case ������
            Case Else
                Err.Raise WCasErr, _
                    Source:="ThWord", _
                    Description:="������ � ��������� �������"
        End Select
    Else
        If cas = ������ Then
            cas = GetPlural(cas)
        ElseIf num Mod 10 <> 1 Or num Mod 100 = 11 Then
            cas = GetPlural(������)
        End If
    End If
    If getpar Then _
        ThWord = ThWord & ") " & unit.Casi(cas) _
    Else _
        ThWord = ThWord & " " & unit.Casi(cas)
End Function

Rem ������� ��������� ���������� �������� � �������
Private Function DigWord(ByVal digs As Byte, _
                         ByVal cas As Casus, _
                         ByVal sx As Sex) As String
    Select Case digs
        Case 0
            DigWord = ""
        Case 1
            DigWord = One(cas, sx)
        Case 2
            DigWord = Two(cas, sx)
        Case Is < 20
            DigWord = ThreeTwenty(digs, cas)
        Case Else
            DigWord = Ten(digs \ 10, cas) & " " & _
                DigWord(digs Mod 10, cas, sx)
    End Select
End Function

Rem ������� ���������� ������ �������� � ������ ���������� ������� ���������
Private Function RetFirst(ByVal var1 As String, cond As Boolean) As String
    If cond Then RetFirst = var1 Else RetFirst = ""
End Function

Rem ������� ��������� ����� � �������
Public Function ��������(ByVal ���� As Currency, _
        Optional ����� As Casus = �����) As String
Attribute ��������.VB_Description = "������� ���� � ������ ��������"
Attribute ��������.VB_ProcData.VB_Invoke_Func = " \n19"
    If ���� < 0 Then _
        Err.Raise WNumErr, Source:="��������", _
            Description:="������� ������������� ����"
   ���� = Round(����, 2) ' ���������, ����� ������ ������ �������
    Dim cen As Integer, rbl As Variant
    cen = 100 * (���� - Int(����)): rbl = CDec(Int(����))
    If cen = 0 Then
        �������� = Format(cen, "#,#00") & _
            " (" & Zero(�����) & ") ������"
    Else
        �������� = Format(cen, "#,#00") & _
            " (" & ThWord(cen, �����, Cents(), True)
    End If
    If rbl = 0 Then
        �������� = Format(rbl, "0") & " (" & Zero(�����) & ") ������ " & _
            ��������
    Else
        Dim arr([_TotalExpo]) As WORD, i As Expo, thr As Integer
        arr(unitExp) = Rubles()
        arr(thouExp) = Thousands()
        arr(millExp) = Millions()
        arr(billExp) = Billions()
        arr(trilExp) = Trillions()
        Dim thr1 As Integer
        For i = unitExp To trilExp
            thr = rbl Mod 1000
            If thr > 0 Or i = unitExp Then _
                �������� = _
                    ThWord(thr, �����, arr(i), i = unitExp) & _
                        RetFirst(" ", i = unitExp Or thr1 <> 0) & _
                        ��������
            rbl = rbl \ 1000
            thr1 = thr1 + thr
            If rbl = 0 Then Exit For
        Next i
        �������� = _
            Format(Int(����), "#,###") & " (" & Trim(��������)
    End If
End Function

Rem ������� ��������� ������������ ��������, ������������, ��� �������� - ����
Rem � �������� ����� �������� � � ������� ����������,
Rem �� � ������ ������� - � ������.
Rem ����������� ���������� ����� ���� ������ ����� �������
Private Function IsCorrectPrice(ByVal price As Currency) As Boolean
    Dim fraction As Currency
    fraction = Frac(100 * Frac(price))
    If fraction <> 0 Then _
        IsCorrectPrice = False _
    Else IsCorrectPrice = True
End Function

Rem ������� ���� ��������� ���������� ���� � ��� ��� ��� (������������ ���������� ���). _
���� ����� "���������", �� ���� ������ ����������, ��� ��� ������ ��������� ��� �������������, _
���� ������� �������� ��������� "����������" ����������!
Public Function ���������( _
        ByVal ���� As Currency, _
        ByVal ��� As Currency, _
        ByVal ���������� As Currency, _
        Optional ByVal ��� As ExistVAT = ������) As Currency
Attribute ���������.VB_Description = "������� ��������� ���������� ���� ��� ���������, � ��������������� ����, ���������� ��������� � ���\n� ������� ��������� ������ ���� (� ��� ��� ���)"
Attribute ���������.VB_ProcData.VB_Invoke_Func = " \n19"
    Dim valuePlus As Currency, valueMinus As Currency
    If PriceCorrection(����, ���, ����������, ���) Then
            ��������� = ����: Exit Function
    Else
        valuePlus = Round(����, 2): valueMinus = valuePlus
        Do While valueMinus > 0
            If PriceCorrection(valuePlus, ���, ����������, ���) Then
                ��������� = valuePlus: Exit Function
            ElseIf PriceCorrection(valueMinus, ���, ����������, ���) Then
                ��������� = valueMinus: Exit Function
            Else
                valuePlus = valuePlus + 0.01
                valueMinus = valueMinus - 0.01
            End If
        Loop
    End If
    Err.Raise VnFErr, Source:="���������", _
        Description:="�������� �� �������!" & Chr(10) & "���������� ��������� � �������������!"
End Function

Private Function PriceCorrection( _
        ByVal price As Currency, _
        ByVal VAT As Currency, _
        ByVal Amount As Currency, _
        ByVal eVAT As ExistVAT) As Boolean
    If eVAT = ������ Then
        PriceCorrection = _
            IsCorrectPrice(price * (1# + VAT)) _
            And IsCorrectPrice(price * Amount * (1# + VAT)) _
            And IsCorrectPrice(price * Amount * VAT)
    Else
        PriceCorrection = _
            IsCorrectPrice(price / (1# + VAT)) _
            And IsCorrectPrice(price * Amount) _
            And IsCorrectPrice(price * Amount / (1# + VAT))
    End If
    PriceCorrection = PriceCorrection And IsCorrectPrice(price)
End Function

Private Function Frac(ByVal value As Currency)
    Frac = value - Sign(value) * Int(Abs(value))
End Function

Private Function Sign(ByVal value As Currency) As Integer
    Select Case value
        Case Is < 0
            Sign = -1
        Case Is > 0
            Sign = 1
        Case Else
            Sign = 0
    End Select
End Function

Rem ***************************************************************************
Rem ***************************************************************************
Rem **                                                                       **
Rem **                      ***** *****  **** ***** *   *                    **
Rem **                        *   *     *   *   *   *   *                    **
Rem **                        *   ***   *       *   **  *                    **
Rem **                        *   *     *       *   * * *                    **
Rem **                        *   *****  ****   *   **  *                    **
Rem **                                                                       **
Rem ***************************************************************************
Rem ***************************************************************************

Rem ���� ��� ���� ��������
Private Sub Test_����()
    If ��������(0) <> "0 (����) ������ 00 (����) ������" Then
        MsgBox "������ ��� 0", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1.01) <> "1 (����) ����� 01 (����) �������" Then
        MsgBox "������ ��� 1.01", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(2.02) <> "2 (���) ����� 02 (���) �������" Then
        MsgBox "������ ��� 2.02", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(3.03) <> "3 (���) ����� 03 (���) �������" Then
        MsgBox "������ ��� 3.03", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(4.04) <> "4 (������) ����� 04 (������) �������" Then
        MsgBox "������ ��� 4.04", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(5.05) <> "5 (����) ������ 05 (����) ������" Then
        MsgBox "������ ��� 5.05", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(6.06) <> "6 (�����) ������ 06 (�����) ������" Then
        MsgBox "������ ��� 6.06", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(7.07) <> "7 (����) ������ 07 (����) ������" Then
        MsgBox "������ ��� 7.07", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(8.08) <> "8 (������) ������ 08 (������) ������" Then
        MsgBox "������ ��� 8.08", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(9.09) <> "9 (������) ������ 09 (������) ������" Then
        MsgBox "������ ��� 9.09", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(10.1) <> "10 (������) ������ 10 (������) ������" Then
        MsgBox "������ ��� 10.1", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(11.11) <> "11 (�����������) ������ 11 (�����������) ������" Then
        MsgBox "������ ��� 11.11", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(12.12) <> "12 (����������) ������ 12 (����������) ������" Then
        MsgBox "������ ��� 12.12", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(13.13) <> "13 (����������) ������ 13 (����������) ������" Then
        MsgBox "������ ��� 13.13", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(14.14) <> "14 (������������) ������ 14 (������������) ������" Then
        MsgBox "������ ��� 14.14", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(15.15) <> "15 (����������) ������ 15 (����������) ������" Then
        MsgBox "������ ��� 15.15", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(16.16) <> "16 (�����������) ������ 16 (�����������) ������" Then
        MsgBox "������ ��� 11.11", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(17.17) <> "17 (����������) ������ 17 (����������) ������" Then
        MsgBox "������ ��� 17.17", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(18.18) <> "18 (������������) ������ 18 (������������) ������" Then
        MsgBox "������ ��� 18.18", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(19.19) <> "19 (������������) ������ 19 (������������) ������" Then
        MsgBox "������ ��� 19.19", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(20.2) <> "20 (��������) ������ 20 (��������) ������" Then
        MsgBox "������ ��� 20.20", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(30.3) <> "30 (��������) ������ 30 (��������) ������" Then
        MsgBox "������ ��� 30.30", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(40.4) <> "40 (�����) ������ 40 (�����) ������" Then
        MsgBox "������ ��� 40.40", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(50.5) <> "50 (���������) ������ 50 (���������) ������" Then
        MsgBox "������ ��� 50.50", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(60.6) <> "60 (����������) ������ 60 (����������) ������" Then
        MsgBox "������ ��� 60.60", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(70.7) <> "70 (���������) ������ 70 (���������) ������" Then
        MsgBox "������ ��� 70.70", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(80.8) <> "80 (�����������) ������ 80 (�����������) ������" Then
        MsgBox "������ ��� 80.80", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(90.9) <> "90 (���������) ������ 90 (���������) ������" Then
        MsgBox "������ ��� 90.90", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(100) <> "100 (���) ������ 00 (����) ������" Then
        MsgBox "������ ��� 100", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(200) <> "200 (������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 200", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(300) <> "300 (������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 300", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(400) <> "400 (���������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 400", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(500) <> "500 (�������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 500", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(600) <> "600 (��������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 600", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(700) <> "700 (�������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 700", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(800) <> "800 (���������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 800", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(900) <> "900 (���������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 900", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1000) <> "1�000 (���� ������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 1000", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1111) <> "1�111 (���� ������ ��� �����������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 1000", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1000000) <> "1�000�000 (���� �������) ������ 00 (����) ������" Then
        MsgBox "������ ��� 1000000", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1123456) <> "1�123�456 (���� ������� ��� �������� ��� ������ ��������� ��������� �����) ������ 00 (����) ������" Then
        MsgBox "������ ��� 1123456", vbCritical, "������!"
        Exit Sub
    ElseIf ��������(1000456) <> "1�000�456 (���� ������� ��������� ��������� �����) ������ 00 (����) ������" Then
        MsgBox "������ ��� 1000456", vbCritical, "������!"
        Exit Sub
    End If
End Sub

Private Function Test_Sign() As Boolean
    Randomize (Timer)
    Dim arr() As Currency
    ReDim arr(Int(9 * Rnd + 1))
    Dim i As Byte
    For i = 0 To UBound(arr) - 1
        arr(i) = CCur(Int(20 * Rnd - 10)) ' �� -10 �� +10
        If (arr(i) < 0 And Sign(arr(i)) <> -1) Or _
           (arr(i) > 0 And Sign(arr(i)) <> 1) Or _
           (arr(i) = 0 And Sign(arr(i)) <> 0) Then
            Test_Sign = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_Sign �� �������! " & "arr(i)=" & arr(i) & _
            " Sign(arr(i))=" & Sign(arr(i))
#End If
        End If
    Next i
    Test_Sign = True
End Function

Private Function Test_Frac() As Boolean
    If (Frac(100.1) <> 0.1) Or _
       (Frac(10.1) <> 0.1) Or _
       (Frac(8.7) <> 0.7) Or _
       (Frac(-100.1) <> -0.1) Or _
       (Frac(-23.4) <> -0.4) Or _
       (Frac(0#) <> 0#) Then
        Test_Frac = False
#If DBG > DBGLowLevel Then
        Debug.Print "Test_Frac �� �������!"
#End If
        Exit Function
    End If
    Test_Frac = True
End Function

Private Function Test_IsCorrectPrice() As Boolean
    Randomize (Timer)
    Dim arr() As Currency
    ReDim arr(Int(9 * Rnd + 1))
    Dim i As Byte
    For i = 0 To UBound(arr) - 1
        arr(i) = CCur((Int(9 * Rnd + 1))) / 1000 ' �� 0.001 �� +0.009
        If IsCorrectPrice(arr(i)) Then
            Test_IsCorrectPrice = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_IsCorrectPrice �� �������!" & "arr(i)=" & arr(i)
#End If
            Exit Function
        End If
        arr(i) = CCur((Int(9 * Rnd + 1))) / 100 ' �� 0.01 �� +0.09
        If Not IsCorrectPrice(arr(i)) Then
            Test_IsCorrectPrice = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_IsCorrectPrice �� �������!" & "arr(i)=" & arr(i)
#End If
            Exit Function
        End If
    Next i
    Test_IsCorrectPrice = True
End Function

Private Function Test_������Correction() As Boolean
    Randomize (Timer)
    If PriceCorrection(10.003, 10 * Rnd, 20 * Rnd, ������) Then
        Test_������Correction = False: Exit Function
    ElseIf PriceCorrection(20.0018, 10 * Rnd, 20 * Rnd, ������) Then
        Test_������Correction = False: Exit Function
    ElseIf PriceCorrection(157.12, 0.1, 20 * Rnd, ������) Then
        Test_������Correction = False: Exit Function
    ElseIf PriceCorrection(157.15, 0.2, 11.1, ������) Then
        Test_������Correction = False: Exit Function
    ElseIf Not PriceCorrection(157.15, 0.2, 11, ������) Then
        Test_������Correction = False: Exit Function
    End If
    Test_������Correction = True
End Function

Private Function Test_����Correction() As Boolean
    Randomize (Timer)
    If PriceCorrection(10.003, 10 * Rnd, 20 * Rnd, ����) Then
        Test_����Correction = False: Exit Function
    ElseIf PriceCorrection(20.0018, 10 * Rnd, 20 * Rnd, ����) Then
        Test_����Correction = False: Exit Function
    ElseIf PriceCorrection(157, 0.1, 20 * Rnd, ����) Then
        Test_����Correction = False: Exit Function
    ElseIf PriceCorrection(157.3, 0.1, 11.12, ����) Then
        Test_����Correction = False: Exit Function
    ElseIf PriceCorrection(157.3, 0.1, 11.121, ����) Then
        Test_����Correction = False: Exit Function
    ElseIf Not PriceCorrection(157.3, 0.1, 11, ����) Then
        Test_����Correction = False: Exit Function
    End If
    Test_����Correction = True
End Function

Private Function Test_���������() As Boolean
    If ���������(0#, 0#, 0#, ������) <> 0# Then
        Test_��������� = False: Exit Function
    ElseIf ���������(0#, 0#, 0#, ������) <> 0# Then
        Test_��������� = False: Exit Function
    ElseIf ���������(157.8994082, 0.1, 1622.4, ������) <> 158# Then
        Test_��������� = False: Exit Function
    ElseIf ���������(163.2692307, 0.1, 1622.4, ������) <> 163.5 Then
        Test_��������� = False: Exit Function
    ElseIf ���������(257.06, 0.17, 555#, ������) <> 257# Then
        Test_��������� = False: Exit Function
    ElseIf ���������(225.7, 0.2, 542#, ����) <> 225.72 Then
        Test_��������� = False: Exit Function
    ElseIf ���������(245.5, 0.17, 338#, ����) <> 245.7 Then
        Test_��������� = False: Exit Function
    End If
    Test_��������� = True
End Function


