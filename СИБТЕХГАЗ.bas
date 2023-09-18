Attribute VB_Name = "СИБТЕХГАЗ"
Rem ***************************************************************************
Rem ***************************************************************************
Rem **                                                                       **
Rem ** THIS SOFTWARE PROVIDES NO WARRANITY AND DISTRIBUTED UNDER             **
Rem **                                              GNU GPL LICENCE          **
Rem ***************************************************************************
Rem ***************************************************************************

Option Explicit

Rem Используемые падежи
Public Enum Casus
    ИмПад
    РодПад
    ДатПад
    ВинПад
    [_TotalCasi]
End Enum

Rem Список всех порядков чисел
Private Enum Expo
    unitExp
    thouExp
    millExp
    billExp
    trilExp
    [_TotalExpo]
End Enum

Rem используется для определения, корректировать цену с НДС или без НДС
Public Enum ExistVAT
    БЕЗНДС
    СНДС
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

Rem Вероятные ошибки
Private Enum errors
    WSexErr = vbError + 513 ' Wrong Sex Error
    WCasErr '                 Wrong Casus Error
    WNumErr '                 Wrong Number Error
    VnFErr '                  Value not Found Error
    [_TotalErrors]
End Enum

Rem Следующие функции возвращают константные значения

Rem Функция, возвращающая константу из копеек
Private Function Cents() As WORD
    With Cents
        .Casi(ИмПад) = "копейка":  .Casi(GetPlural(ИмПад)) = "копейки"
        .Casi(РодПад) = "копейки": .Casi(GetPlural(РодПад)) = "копеек"
        .Casi(ДатПад) = "копейке": .Casi(GetPlural(ДатПад)) = "копейкам"
        .Casi(ВинПад) = "копейку": .Casi(GetPlural(ВинПад)) = "копейки"
        .sx = FemaleSex
    End With
End Function

Rem Функция, возвращающая константу из рублей
Private Function Rubles() As WORD
    With Rubles
        .Casi(ИмПад) = "рубль":  .Casi(GetPlural(ИмПад)) = "рубли"
        .Casi(РодПад) = "рубля": .Casi(GetPlural(РодПад)) = "рублей"
        .Casi(ДатПад) = "рублю": .Casi(GetPlural(ДатПад)) = "рублям"
        .Casi(ВинПад) = "рубль": .Casi(GetPlural(ВинПад)) = "рубли"
        .sx = MaleSex
    End With
End Function

Rem Функция, возвращающая константу из тысяч
Private Function Thousands() As WORD
    With Thousands
        .Casi(ИмПад) = "тысяча":  .Casi(GetPlural(ИмПад)) = "тысячи"
        .Casi(РодПад) = "тысячи": .Casi(GetPlural(РодПад)) = "тысяч"
        .Casi(ДатПад) = "тысяче": .Casi(GetPlural(ДатПад)) = "тысячам"
        .Casi(ВинПад) = "тысячу": .Casi(GetPlural(ВинПад)) = "тысячи"
        .sx = FemaleSex
    End With
End Function

Rem Функция, возвращающая константу из миллионов
Private Function Millions() As WORD
    With Millions
        .Casi(ИмПад) = "миллион":   .Casi(GetPlural(ИмПад)) = "миллионы"
        .Casi(РодПад) = "миллиона": .Casi(GetPlural(РодПад)) = "миллионов"
        .Casi(ДатПад) = "миллиону": .Casi(GetPlural(ДатПад)) = "миллионам"
        .Casi(ВинПад) = "миллион":  .Casi(GetPlural(ВинПад)) = "миллионы"
        .sx = MaleSex
    End With
End Function

Rem Функция, возвращающая константу из миллиардов
Private Function Billions() As WORD
    With Billions
        .Casi(ИмПад) = "миллиард":   .Casi(GetPlural(ИмПад)) = "миллиарды"
        .Casi(РодПад) = "миллиарда": .Casi(GetPlural(РодПад)) = "миллиардов"
        .Casi(ДатПад) = "миллиарду": .Casi(GetPlural(ДатПад)) = "миллиардам"
        .Casi(ВинПад) = "миллиард":  .Casi(GetPlural(ВинПад)) = "миллиарды"
        .sx = MaleSex
    End With
End Function

Rem Функция, возвращающая константу из триллионов
Private Function Trillions() As WORD
    With Trillions
        .Casi(ИмПад) = "триллион":   .Casi(GetPlural(ИмПад)) = "триллионы"
        .Casi(РодПад) = "триллиона": .Casi(GetPlural(РодПад)) = "триллионов"
        .Casi(ДатПад) = "триллиону": .Casi(GetPlural(ДатПад)) = "триллионам"
        .Casi(ВинПад) = "триллион":  .Casi(GetPlural(ВинПад)) = "триллионы"
        .sx = MaleSex
    End With
End Function

Rem Функция возвращает ноль
Private Function Zero(ByVal cas As Casus) As String
    Select Case cas
        Case ИмПад
            Zero = "ноль"
        Case РодПад
            Zero = "нуля"
        Case ДатПад
            Zero = "нулю"
        Case ВинПад
            Zero = "ноль"
        Case Else
            Err.Raise WCasErr, Source:="Zero", _
                Description:="Ошибка в нумерации падежей"
    End Select
End Function

Rem Функция возвращает единицу
Private Function One(ByVal cas As Casus, ByVal sx As Sex) As String
    Select Case sx
        Case MaleSex
            Select Case cas
                Case ИмПад
                    One = "один"
                Case РодПад
                    One = "одного"
                Case ДатПад
                    One = "одному"
                Case ВинПад
                    One = "одного"
                Case Else
                    Err.Raise WCasErr, Source:="One (male)", _
                        Description:="Ошибка в нумерации падежей"
            End Select
        Case FemaleSex
            Select Case cas
                Case ИмПад
                    One = "одна"
                Case РодПад
                    One = "одной"
                Case ДатПад
                    One = "одной"
                Case ВинПад
                    One = "одну"
                Case Else
                    Err.Raise WCasErr, Source:="One (female)", _
                        Description:="Ошибка в нумерации падежей"
            End Select
        Case Else
            Err.Raise WSexErr, Source:="One", _
                Description:="Ошибка в выборе окончаний"
    End Select
End Function

Rem Функция возвращает двойку
Private Function Two(ByVal cas As Casus, ByVal sx As Sex) As String
    Select Case cas
        Case ИмПад
            Select Case sx
                Case MaleSex
                    Two = "два"
                Case FemaleSex
                    Two = "две"
                Case Else
                    Err.Raise WSexErr, Source:="Two", _
                        Description:="Ошибка в выборе окончаний"
            End Select
        Case РодПад
            Two = "двух"
        Case ДатПад
            Two = "двум"
        Case ВинПад
            Two = "двух"
        Case Else
            Err.Raise WCasErr, Source:="Two", _
                Description:="Ошибка в нумерации падежей"
    End Select
End Function

Rem Функция, возвращающая числа до двадцати
Private Function ThreeTwenty(ByVal dig As Byte, ByVal cas As Casus) As String
    Dim numbs(19 - 3, [_TotalCasi]) As String
    numbs(3 - 3, ИмПад) = "три"
    numbs(3 - 3, РодПад) = "трёх"
    numbs(3 - 3, ДатПад) = "трём"
    numbs(3 - 3, ВинПад) = "трёх"
    
    numbs(4 - 3, ИмПад) = "четыре"
    numbs(4 - 3, РодПад) = "четырёх"
    numbs(4 - 3, ДатПад) = "четырём"
    numbs(4 - 3, ВинПад) = "четырёх"
    
    numbs(5 - 3, ИмПад) = "пять"
    numbs(5 - 3, РодПад) = "пяти"
    numbs(5 - 3, ДатПад) = "пяти"
    numbs(5 - 3, ВинПад) = "пять"
    
    numbs(6 - 3, ИмПад) = "шесть"
    numbs(6 - 3, РодПад) = "шести"
    numbs(6 - 3, ДатПад) = "шести"
    numbs(6 - 3, ВинПад) = "шесть"
    
    numbs(7 - 3, ИмПад) = "семь"
    numbs(7 - 3, РодПад) = "семи"
    numbs(7 - 3, ДатПад) = "семи"
    numbs(7 - 3, ВинПад) = "семь"
    
    numbs(8 - 3, ИмПад) = "восемь"
    numbs(8 - 3, РодПад) = "восьми"
    numbs(8 - 3, ДатПад) = "восьми"
    numbs(8 - 3, ВинПад) = "восемь"
    
    numbs(9 - 3, ИмПад) = "девять"
    numbs(9 - 3, РодПад) = "девяти"
    numbs(9 - 3, ДатПад) = "девяти"
    numbs(9 - 3, ВинПад) = "девять"
    
    numbs(10 - 3, ИмПад) = "десять"
    numbs(10 - 3, РодПад) = "десяти"
    numbs(10 - 3, ДатПад) = "десяти"
    numbs(10 - 3, ВинПад) = "десять"
    
    numbs(11 - 3, ИмПад) = "одиннадцать"
    numbs(11 - 3, РодПад) = "одиннадцати"
    numbs(11 - 3, ДатПад) = "одиннадцати"
    numbs(11 - 3, ВинПад) = "одиннадцать"
    
    numbs(12 - 3, ИмПад) = "двенадцать"
    numbs(12 - 3, РодПад) = "двенадцати"
    numbs(12 - 3, ДатПад) = "двенадцати"
    numbs(12 - 3, ВинПад) = "двенадцать"
    
    numbs(13 - 3, ИмПад) = "тринадцать"
    numbs(13 - 3, РодПад) = "тринадцати"
    numbs(13 - 3, ДатПад) = "тринадцати"
    numbs(13 - 3, ВинПад) = "тринадцать"
    
    numbs(14 - 3, ИмПад) = "четырнадцать"
    numbs(14 - 3, РодПад) = "четырнадцати"
    numbs(14 - 3, ДатПад) = "четырнадцати"
    numbs(14 - 3, ВинПад) = "четырнадцать"
    
    numbs(15 - 3, ИмПад) = "пятнадцать"
    numbs(15 - 3, РодПад) = "пятнадцати"
    numbs(15 - 3, ДатПад) = "пятнадцати"
    numbs(15 - 3, ВинПад) = "пятнадцать"
    
    numbs(16 - 3, ИмПад) = "шестнадцать"
    numbs(16 - 3, РодПад) = "шестнадцати"
    numbs(16 - 3, ДатПад) = "шестнадцати"
    numbs(16 - 3, ВинПад) = "шестнадцать"
    
    numbs(17 - 3, ИмПад) = "семнадцать"
    numbs(17 - 3, РодПад) = "семнадцати"
    numbs(17 - 3, ДатПад) = "семнадцати"
    numbs(17 - 3, ВинПад) = "семнадцать"
    
    numbs(18 - 3, ИмПад) = "восемнадцать"
    numbs(18 - 3, РодПад) = "восемнадцати"
    numbs(18 - 3, ДатПад) = "восемнадцати"
    numbs(18 - 3, ВинПад) = "восемнадцать"
    
    numbs(19 - 3, ИмПад) = "девятнадцать"
    numbs(19 - 3, РодПад) = "девятнадцати"
    numbs(19 - 3, ДатПад) = "девятнадцати"
    numbs(19 - 3, ВинПад) = "девятнадцать"
    
    ThreeTwenty = numbs(dig - 3, cas)
End Function

Private Function Ten(ByVal dig As Byte, cas As Casus) As String
    Dim numbs(9, [_TotalCasi]) As String
        
    numbs(2, ИмПад) = "двадцать"
    numbs(2, РодПад) = "двадцати"
    numbs(2, ДатПад) = "двадцати"
    numbs(2, ВинПад) = "двадцать"
    
    numbs(3, ИмПад) = "тридцать"
    numbs(3, РодПад) = "тридцати"
    numbs(3, ДатПад) = "тридцати"
    numbs(3, ВинПад) = "тридцать"
    
    numbs(4, ИмПад) = "сорок"
    numbs(4, РодПад) = "сорока"
    numbs(4, ДатПад) = "сорока"
    numbs(4, ВинПад) = "сорок"
    
    numbs(5, ИмПад) = "пятьдесят"
    numbs(5, РодПад) = "пятидесяти"
    numbs(5, ДатПад) = "пятидесяти"
    numbs(5, ВинПад) = "пятьдесят"
    
    numbs(6, ИмПад) = "шестьдесят"
    numbs(6, РодПад) = "шестидесяти"
    numbs(6, ДатПад) = "шестидесяти"
    numbs(6, ВинПад) = "шестьдесят"
    
    numbs(7, ИмПад) = "семьдесят"
    numbs(7, РодПад) = "семидесяти"
    numbs(7, ДатПад) = "семидесяти"
    numbs(7, ВинПад) = "семьдесят"
    
    numbs(8, ИмПад) = "восемьдесят"
    numbs(8, РодПад) = "восьмидесяти"
    numbs(8, ДатПад) = "восьмидесяти"
    numbs(8, ВинПад) = "восемьдесят"
    
    numbs(9, ИмПад) = "девяносто"
    numbs(9, РодПад) = "девяноста"
    numbs(9, ДатПад) = "девяноста"
    numbs(9, ВинПад) = "девяносто"
    
    Ten = numbs(dig, cas)
End Function

Private Function Hundred(ByVal dig As Byte, cas As Casus) As String
    Dim numbs(9, [_TotalCasi]) As String
        
    numbs(1, ИмПад) = "сто"
    numbs(1, РодПад) = "ста"
    numbs(1, ДатПад) = "ста"
    numbs(1, ВинПад) = "сто"
        
    numbs(2, ИмПад) = "двести"
    numbs(2, РодПад) = "двуста"
    numbs(2, ДатПад) = "двуста"
    numbs(2, ВинПад) = "двести"
    
    numbs(3, ИмПад) = "триста"
    numbs(3, РодПад) = "трёхсот"
    numbs(3, ДатПад) = "трёмста"
    numbs(3, ВинПад) = "триста"
    
    numbs(4, ИмПад) = "четыреста"
    numbs(4, РодПад) = "четырёхсот"
    numbs(4, ДатПад) = "четырёстам"
    numbs(4, ВинПад) = "четыреста"
    
    numbs(5, ИмПад) = "пятьсот"
    numbs(5, РодПад) = "пятиста"
    numbs(5, ДатПад) = "пятиста"
    numbs(5, ВинПад) = "пятьсот"
    
    numbs(6, ИмПад) = "шестьсот"
    numbs(6, РодПад) = "шестиста"
    numbs(6, ДатПад) = "шестиста"
    numbs(6, ВинПад) = "шестьсот"
    
    numbs(7, ИмПад) = "семьсот"
    numbs(7, РодПад) = "семиста"
    numbs(7, ДатПад) = "семиста"
    numbs(7, ВинПад) = "семьсот"
    
    numbs(8, ИмПад) = "восемьсот"
    numbs(8, РодПад) = "восьмиста"
    numbs(8, ДатПад) = "восьмиста"
    numbs(8, ВинПад) = "восемьсот"
    
    numbs(9, ИмПад) = "девятьсот"
    numbs(9, РодПад) = "девятиста"
    numbs(9, ДатПад) = "девятиста"
    numbs(9, ВинПад) = "девятьсот"
    
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

Rem Функция переводит в множественное число
Private Function GetPlural(ByVal cas As Casus) As Casus
    GetPlural = cas + [_TotalCasi]
End Function

Rem Функция возвращает пропись числа, меньше 1000
Private Function ThWord(ByVal num As Integer, _
                        ByVal cas As Casus, _
                        ByRef unit As WORD, _
                        ByVal getpar As Boolean) As String
    If num > 1000 Then _
        Err.Raise WNumErr, _
                  Source:="ThWord", _
                  Description:="Значение выше 1000"
    ThWord = Trim(Hundred(num \ 100, cas) & " " & _
        DigWord(num Mod 100, cas, unit.sx))
    If (num Mod 10 >= 2 And num Mod 10 <= 4) And _
          (num Mod 100 < 12 Or num Mod 100 > 14) Then
        Select Case cas
            Case ИмПад
                cas = РодПад
            Case РодПад
                cas = GetPlural(РодПад)
            Case ДатПад
                cas = РодПад
            Case ВинПад
            Case Else
                Err.Raise WCasErr, _
                    Source:="ThWord", _
                    Description:="Ошибка в нумерации падежей"
        End Select
    Else
        If cas = ДатПад Then
            cas = GetPlural(cas)
        ElseIf num Mod 10 <> 1 Or num Mod 100 = 11 Then
            cas = GetPlural(РодПад)
        End If
    End If
    If getpar Then _
        ThWord = ThWord & ") " & unit.Casi(cas) _
    Else _
        ThWord = ThWord & " " & unit.Casi(cas)
End Function

Rem Функция переводит двузначное значение в пропись
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

Rem Функция возвращает первый аргумент в случае истинности второго аргумента
Private Function RetFirst(ByVal var1 As String, cond As Boolean) As String
    If cond Then RetFirst = var1 Else RetFirst = ""
End Function

Rem Функция переводит сумму в пропись
Public Function ЦЕНАПРОП(ByVal ЦЕНА As Currency, _
        Optional ПАДЕЖ As Casus = ИмПад) As String
Attribute ЦЕНАПРОП.VB_Description = "Выводит цену в рублях прописью"
Attribute ЦЕНАПРОП.VB_ProcData.VB_Invoke_Func = " \n19"
    If ЦЕНА < 0 Then _
        Err.Raise WNumErr, Source:="ЦЕНАПРОП", _
            Description:="Введена отрицательная цена"
   ЦЕНА = Round(ЦЕНА, 2) ' Округляем, чтобы убрать лишние копейки
    Dim cen As Integer, rbl As Variant
    cen = 100 * (ЦЕНА - Int(ЦЕНА)): rbl = CDec(Int(ЦЕНА))
    If cen = 0 Then
        ЦЕНАПРОП = Format(cen, "#,#00") & _
            " (" & Zero(ПАДЕЖ) & ") копеек"
    Else
        ЦЕНАПРОП = Format(cen, "#,#00") & _
            " (" & ThWord(cen, ПАДЕЖ, Cents(), True)
    End If
    If rbl = 0 Then
        ЦЕНАПРОП = Format(rbl, "0") & " (" & Zero(ПАДЕЖ) & ") рублей " & _
            ЦЕНАПРОП
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
                ЦЕНАПРОП = _
                    ThWord(thr, ПАДЕЖ, arr(i), i = unitExp) & _
                        RetFirst(" ", i = unitExp Or thr1 <> 0) & _
                        ЦЕНАПРОП
            rbl = rbl \ 1000
            thr1 = thr1 + thr
            If rbl = 0 Then Exit For
        Next i
        ЦЕНАПРОП = _
            Format(Int(ЦЕНА), "#,###") & " (" & Trim(ЦЕНАПРОП)
    End If
End Function

Rem Функция проверяет корректность значения, подразумевая, что аргумент - цена
Rem В принципе может работать и с другими значениями,
Rem но в первую очередь - с ценами.
Rem Проверяется отсутствие более двух знаков после запятой
Private Function IsCorrectPrice(ByVal price As Currency) As Boolean
    Dim fraction As Currency
    fraction = Frac(100 * Frac(price))
    If fraction <> 0 Then _
        IsCorrectPrice = False _
    Else IsCorrectPrice = True
End Function

Rem Функция ищет ближайшую корректную цену с НДС или без (определяется параметром ТИП). _
Цена будет "ближайшей", то есть первой попавшейся, так что будьте аккуратны при использовании, _
если желаете получать ближайшие "наибольшие" результаты!
Public Function НАЙТИБЛИЖ( _
        ByVal ЦЕНА As Currency, _
        ByVal НДС As Currency, _
        ByVal КОЛИЧЕСТВО As Currency, _
        Optional ByVal ТИП As ExistVAT = БЕЗНДС) As Currency
Attribute НАЙТИБЛИЖ.VB_Description = "Находит ближайшую корректную цену для Продукции, с учётомначальной цены, количества Продукции и НДС\nИ выводит результат учётом типа (с НДС или без)"
Attribute НАЙТИБЛИЖ.VB_ProcData.VB_Invoke_Func = " \n19"
    Dim valuePlus As Currency, valueMinus As Currency
    If PriceCorrection(ЦЕНА, НДС, КОЛИЧЕСТВО, ТИП) Then
            НАЙТИБЛИЖ = ЦЕНА: Exit Function
    Else
        valuePlus = Round(ЦЕНА, 2): valueMinus = valuePlus
        Do While valueMinus > 0
            If PriceCorrection(valuePlus, НДС, КОЛИЧЕСТВО, ТИП) Then
                НАЙТИБЛИЖ = valuePlus: Exit Function
            ElseIf PriceCorrection(valueMinus, НДС, КОЛИЧЕСТВО, ТИП) Then
                НАЙТИБЛИЖ = valueMinus: Exit Function
            Else
                valuePlus = valuePlus + 0.01
                valueMinus = valueMinus - 0.01
            End If
        Loop
    End If
    Err.Raise VnFErr, Source:="НАЙТИБЛИЖ", _
        Description:="Значение не найдено!" & Chr(10) & "Пожалуйста свяжитесь с Разработчиком!"
End Function

Private Function PriceCorrection( _
        ByVal price As Currency, _
        ByVal VAT As Currency, _
        ByVal Amount As Currency, _
        ByVal eVAT As ExistVAT) As Boolean
    If eVAT = БЕЗНДС Then
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

Rem Тест для цены прописью
Private Sub Test_ЦЕНА()
    If ЦЕНАПРОП(0) <> "0 (ноль) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 0", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1.01) <> "1 (один) рубль 01 (одна) копейка" Then
        MsgBox "Ошибка при 1.01", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(2.02) <> "2 (два) рубля 02 (две) копейки" Then
        MsgBox "Ошибка при 2.02", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(3.03) <> "3 (три) рубля 03 (три) копейки" Then
        MsgBox "Ошибка при 3.03", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(4.04) <> "4 (четыре) рубля 04 (четыре) копейки" Then
        MsgBox "Ошибка при 4.04", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(5.05) <> "5 (пять) рублей 05 (пять) копеек" Then
        MsgBox "Ошибка при 5.05", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(6.06) <> "6 (шесть) рублей 06 (шесть) копеек" Then
        MsgBox "Ошибка при 6.06", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(7.07) <> "7 (семь) рублей 07 (семь) копеек" Then
        MsgBox "Ошибка при 7.07", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(8.08) <> "8 (восемь) рублей 08 (восемь) копеек" Then
        MsgBox "Ошибка при 8.08", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(9.09) <> "9 (девять) рублей 09 (девять) копеек" Then
        MsgBox "Ошибка при 9.09", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(10.1) <> "10 (десять) рублей 10 (десять) копеек" Then
        MsgBox "Ошибка при 10.1", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(11.11) <> "11 (одиннадцать) рублей 11 (одиннадцать) копеек" Then
        MsgBox "Ошибка при 11.11", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(12.12) <> "12 (двенадцать) рублей 12 (двенадцать) копеек" Then
        MsgBox "Ошибка при 12.12", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(13.13) <> "13 (тринадцать) рублей 13 (тринадцать) копеек" Then
        MsgBox "Ошибка при 13.13", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(14.14) <> "14 (четырнадцать) рублей 14 (четырнадцать) копеек" Then
        MsgBox "Ошибка при 14.14", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(15.15) <> "15 (пятнадцать) рублей 15 (пятнадцать) копеек" Then
        MsgBox "Ошибка при 15.15", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(16.16) <> "16 (шестнадцать) рублей 16 (шестнадцать) копеек" Then
        MsgBox "Ошибка при 11.11", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(17.17) <> "17 (семнадцать) рублей 17 (семнадцать) копеек" Then
        MsgBox "Ошибка при 17.17", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(18.18) <> "18 (восемнадцать) рублей 18 (восемнадцать) копеек" Then
        MsgBox "Ошибка при 18.18", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(19.19) <> "19 (девятнадцать) рублей 19 (девятнадцать) копеек" Then
        MsgBox "Ошибка при 19.19", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(20.2) <> "20 (двадцать) рублей 20 (двадцать) копеек" Then
        MsgBox "Ошибка при 20.20", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(30.3) <> "30 (тридцать) рублей 30 (тридцать) копеек" Then
        MsgBox "Ошибка при 30.30", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(40.4) <> "40 (сорок) рублей 40 (сорок) копеек" Then
        MsgBox "Ошибка при 40.40", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(50.5) <> "50 (пятьдесят) рублей 50 (пятьдесят) копеек" Then
        MsgBox "Ошибка при 50.50", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(60.6) <> "60 (шестьдесят) рублей 60 (шестьдесят) копеек" Then
        MsgBox "Ошибка при 60.60", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(70.7) <> "70 (семьдесят) рублей 70 (семьдесят) копеек" Then
        MsgBox "Ошибка при 70.70", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(80.8) <> "80 (восемьдесят) рублей 80 (восемьдесят) копеек" Then
        MsgBox "Ошибка при 80.80", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(90.9) <> "90 (девяносто) рублей 90 (девяносто) копеек" Then
        MsgBox "Ошибка при 90.90", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(100) <> "100 (сто) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 100", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(200) <> "200 (двести) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 200", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(300) <> "300 (триста) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 300", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(400) <> "400 (четыреста) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 400", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(500) <> "500 (пятьсот) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 500", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(600) <> "600 (шестьсот) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 600", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(700) <> "700 (семьсот) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 700", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(800) <> "800 (восемьсот) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 800", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(900) <> "900 (девятьсот) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 900", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1000) <> "1 000 (одна тысяча) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 1000", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1111) <> "1 111 (одна тысяча сто одиннадцать) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 1000", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1000000) <> "1 000 000 (один миллион) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 1000000", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1123456) <> "1 123 456 (один миллион сто двадцать три тысячи четыреста пятьдесят шесть) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 1123456", vbCritical, "ОШИБКА!"
        Exit Sub
    ElseIf ЦЕНАПРОП(1000456) <> "1 000 456 (один миллион четыреста пятьдесят шесть) рублей 00 (ноль) копеек" Then
        MsgBox "Ошибка при 1000456", vbCritical, "ОШИБКА!"
        Exit Sub
    End If
End Sub

Private Function Test_Sign() As Boolean
    Randomize (Timer)
    Dim arr() As Currency
    ReDim arr(Int(9 * Rnd + 1))
    Dim i As Byte
    For i = 0 To UBound(arr) - 1
        arr(i) = CCur(Int(20 * Rnd - 10)) ' От -10 до +10
        If (arr(i) < 0 And Sign(arr(i)) <> -1) Or _
           (arr(i) > 0 And Sign(arr(i)) <> 1) Or _
           (arr(i) = 0 And Sign(arr(i)) <> 0) Then
            Test_Sign = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_Sign не пройден! " & "arr(i)=" & arr(i) & _
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
        Debug.Print "Test_Frac не пройден!"
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
        arr(i) = CCur((Int(9 * Rnd + 1))) / 1000 ' От 0.001 до +0.009
        If IsCorrectPrice(arr(i)) Then
            Test_IsCorrectPrice = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_IsCorrectPrice не пройден!" & "arr(i)=" & arr(i)
#End If
            Exit Function
        End If
        arr(i) = CCur((Int(9 * Rnd + 1))) / 100 ' От 0.01 до +0.09
        If Not IsCorrectPrice(arr(i)) Then
            Test_IsCorrectPrice = False
#If DBG > DBGLowLevel Then
            Debug.Print "Test_IsCorrectPrice не пройден!" & "arr(i)=" & arr(i)
#End If
            Exit Function
        End If
    Next i
    Test_IsCorrectPrice = True
End Function

Private Function Test_БЕЗНДСCorrection() As Boolean
    Randomize (Timer)
    If PriceCorrection(10.003, 10 * Rnd, 20 * Rnd, БЕЗНДС) Then
        Test_БЕЗНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(20.0018, 10 * Rnd, 20 * Rnd, БЕЗНДС) Then
        Test_БЕЗНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(157.12, 0.1, 20 * Rnd, БЕЗНДС) Then
        Test_БЕЗНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(157.15, 0.2, 11.1, БЕЗНДС) Then
        Test_БЕЗНДСCorrection = False: Exit Function
    ElseIf Not PriceCorrection(157.15, 0.2, 11, БЕЗНДС) Then
        Test_БЕЗНДСCorrection = False: Exit Function
    End If
    Test_БЕЗНДСCorrection = True
End Function

Private Function Test_СНДСCorrection() As Boolean
    Randomize (Timer)
    If PriceCorrection(10.003, 10 * Rnd, 20 * Rnd, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(20.0018, 10 * Rnd, 20 * Rnd, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(157, 0.1, 20 * Rnd, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(157.3, 0.1, 11.12, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    ElseIf PriceCorrection(157.3, 0.1, 11.121, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    ElseIf Not PriceCorrection(157.3, 0.1, 11, СНДС) Then
        Test_СНДСCorrection = False: Exit Function
    End If
    Test_СНДСCorrection = True
End Function

Private Function Test_НАЙТИБЛИЖ() As Boolean
    If НАЙТИБЛИЖ(0#, 0#, 0#, БЕЗНДС) <> 0# Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(0#, 0#, 0#, БЕЗНДС) <> 0# Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(157.8994082, 0.1, 1622.4, БЕЗНДС) <> 158# Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(163.2692307, 0.1, 1622.4, БЕЗНДС) <> 163.5 Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(257.06, 0.17, 555#, БЕЗНДС) <> 257# Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(225.7, 0.2, 542#, СНДС) <> 225.72 Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    ElseIf НАЙТИБЛИЖ(245.5, 0.17, 338#, СНДС) <> 245.7 Then
        Test_НАЙТИБЛИЖ = False: Exit Function
    End If
    Test_НАЙТИБЛИЖ = True
End Function


