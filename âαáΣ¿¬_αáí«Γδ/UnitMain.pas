unit UnitMain;
interface
uses
  Windows, {Messages,} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {Dialogs,} Calendar, StdCtrls, ComCtrls, {Grids,} {HTTPApp,} XPMan, ExtCtrls,
  Registry;
type
//Класс формы
  TFormMain = class(TForm)
    XPManifest_: TXPManifest;
    Timer_: TTimer;
    Button_1: TButton;
    Panel_L: TPanel;
    Panel_R: TPanel;
    DateTimePicker_: TDateTimePicker;
    Button_: TButton;
    Label_1: TLabel;
    Edit_Work: TEdit;
    Label_Work: TLabel;
    Edit_Relax: TEdit;
    UpDown_Relax_Day: TUpDown;
    Label_Relax: TLabel;
    UpDown_Work_Day: TUpDown;
    DateTimePicker_Work_Day: TDateTimePicker;
    Label_2: TLabel;
    Label_3: TLabel;
    Label_: TLabel;
    procedure Button_Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer_Timer(Sender: TObject);
    procedure Button_1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateTimePicker_Change(Sender: TObject);
    procedure DateTimePicker_Work_DayChange(Sender: TObject);
    procedure UpDown_Work_DayClick(Sender: TObject; Button: TUDBtnType);
    procedure UpDown_Relax_DayClick(Sender: TObject; Button: TUDBtnType);
  end;
//Класс расчет графика
  TCalc_Schedule = Class
    const
    SubKey : String = 'Software\ScheduleCalc';
    var
    RegFile : TRegIniFile;
    TypeOfDay : String;
    Amount_Work_Day, Amount_Relax_Day : Byte;
    Day, Month, Year : word;
    Number_Of_Day : word;
    lt_x_j, lt_y_i, rb_x_j, rb_y_i : word;
    Dif : word;
    Cycle, Parity : word;
    Tr_Be_Da_Wo, Tr_S : word;
    BeginDateWork : TDateTime;
    Mass_String_Calendar : array [0..6,0..6] of String;
    Mass_Boolean_Calendar : array [0..6,0..6] of boolean;
    Metka : boolean;
    Procedure Clear_Mass;
    procedure Fill_Head_Mass;
    Procedure Calk_Mass;
    procedure Paint_Table;
    function DaysOfMonth(mm, yy: word): byte;
    function DayOfWeekRus(S: TDateTime): byte;
    function TypeOfDays(S : TDateTime): Boolean;
  end;
var
  FormMain : TFormMain;
  Calc_Schedule : TCalc_Schedule;
implementation
uses Unit_About;
{$R *.dfm}
//*********************************************************
//Активация формы
procedure TFormMain.FormActivate(Sender: TObject);
var
Date_ : String;
begin
//Текущая дата
DateTimePicker_.Date := Date;
Calc_Schedule.RegFile := TRegIniFile.Create(Calc_Schedule.SubKey);
Date_ := Calc_Schedule.RegFile.ReadString('Date', 'Date','');
if Length(Date_)<>0 then
DateTimePicker_Work_Day.Date := StrToDate(Date_)
else
DateTimePicker_Work_Day.Date := Date;
//Заполение заголовка
Label_.Caption := 'Сегодня: ' + FormatDateTime('dd MMMM yyyy',Date)+' г.'+
' ' + FormatDateTime('dddd',Date);
//Календарь
Calc_Schedule.Metka := false;//Установка метки
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//*********************************************************
//Закрытие формы
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Calc_Schedule.Free;
end;
//*********************************************************
//Перерисовка формы
procedure TFormMain.FormPaint(Sender: TObject);
begin
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//***********************************************
//Часики в окошке
procedure TFormMain.Timer_Timer(Sender: TObject);
begin
FormMain.Caption := 'График работы v.1.2   '
+ TimeToStr(Time);
end;
//*********************************************************
//Изменение количества выходных дней
procedure TFormMain.UpDown_Relax_DayClick(Sender: TObject; Button: TUDBtnType);
begin
FormMain.Repaint;
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//*********************************************************
//Изменение количества рабочих дней
procedure TFormMain.UpDown_Work_DayClick(Sender: TObject; Button: TUDBtnType);
begin
FormMain.Repaint;
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//*********************************************************
//Нажатие на кнопку расчета
procedure TFormMain.Button_Click(Sender: TObject);
begin
Calc_Schedule.RegFile.WriteString('Date', 'Date',DateToStr(DateTimePicker_Work_Day.Date));
FormMain.Repaint;
Calc_Schedule.Metka := true;//Метка о нажитии кнопки
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//********************************************************
//Изменение календаря
procedure TFormMain.DateTimePicker_Change(Sender: TObject);
begin
FormMain.Repaint;
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//*********************************************************
//Изменение первого дня работы
procedure TFormMain.DateTimePicker_Work_DayChange(Sender: TObject);
begin
FormMain.Repaint;
Calc_Schedule.Clear_Mass;//Очистить массивы
Calc_Schedule.Fill_Head_Mass;//Заполнение шапки таблицы
Calc_Schedule.Calk_Mass;//Расчет массивов
Calc_Schedule.Paint_Table;//Прорисовка таблицы
end;
//*********************************************************
//Очистить массивы
Procedure TCalc_Schedule.Clear_Mass;
var
i, j : byte;
begin
for I := 0 to 6 do
  for j := 0 to 6 do begin
  Mass_String_Calendar[i,j]:=' ';
  Mass_Boolean_Calendar[i,j]:=true;
  end;
end;
//***********************************************//
//Заполнение шапки
procedure TCalc_Schedule.Fill_Head_Mass;
begin
Mass_String_Calendar[0,0] := '   Пон';
Mass_String_Calendar[1,0] := '   Вт';
Mass_String_Calendar[2,0] := '   Ср';
Mass_String_Calendar[3,0] := '   Чет';
Mass_String_Calendar[4,0] := '   Пят';
Mass_String_Calendar[5,0] := '   Суб';
Mass_String_Calendar[6,0] := '   Вск';
end;
//*********************************************************
//Заполнение массивов
Procedure TCalc_Schedule.Calk_Mass;
var
i, j : byte;
begin
//Инициализвция переменных
DecodeDate(FormMain.DateTimePicker_.Date, Year, Month, Day);
BeginDateWork := FormMain.DateTimePicker_Work_Day.DateTime;
Amount_Work_Day := StrToInt(FormMain.Edit_Work.Text);
Amount_Relax_Day := StrToInt(FormMain.Edit_Relax.Text);
Number_Of_Day := 1;
//Заполнение массива
//*********************************************************
//Первая строка
if Metka=false then begin
//Первая строка
DecodeDate(FormMain.DateTimePicker_.Date, Year, Month, Day);
for i := DayOfWeekRus(EncodeDate(Year, Month, 1)) to 6 do begin
  Mass_String_Calendar [i,1] := IntToStr(Number_Of_Day);
  if i = 6 then break;
  Inc(Number_Of_Day);
end;
//Остальные строки
for j := 2 to 6 do begin
  for i := 0 to 6 do begin
    If Number_Of_Day < DaysOfMonth(Month, Year) then begin
    Inc(Number_Of_Day);
    Mass_String_Calendar [i,j] := IntToStr(Number_Of_Day);
    end
    else break;
    end;
  end;
end;
//*********************************************************
//Первая строка
if Metka=true then begin
for i := DayOfWeekRus(EncodeDate(Year, Month, 1)) to 6 do begin
  if TypeOfDays(EncodeDate(Year, Month, Number_Of_Day))= true then
  TypeOfDay := 'раб.';
  if TypeOfDays(EncodeDate(Year, Month, Number_Of_Day))= false then
  TypeOfDay := 'вых.';
  Mass_String_Calendar [i,1] := IntToStr(Number_Of_Day)+'  '+TypeOfDay;
  Mass_Boolean_Calendar [i,1] := TypeOfDays(EncodeDate(Year, Month, Number_Of_Day));
  if i = 6 then break;
  Inc(Number_Of_Day);
end;
//Остальные строки
for j := 2 to 6 do
  for i := 0 to 6 do begin
    If Number_Of_Day < DaysOfMonth(Month, Year) then begin
    Inc(Number_Of_Day);
    if TypeOfDays(EncodeDate(Year, Month, Number_Of_Day))= true then
    TypeOfDay := 'раб.';
    if TypeOfDays(EncodeDate(Year, Month, Number_Of_Day))= false then
    TypeOfDay := 'вых.';
    Mass_String_Calendar [i,j] := IntToStr(Number_Of_Day)+' '+TypeOfDay;
    Mass_Boolean_Calendar [i,j]:= TypeOfDays(EncodeDate(Year, Month, Number_Of_Day));
    end
    else break;
    end;
  end;
//*********************************************************
end;
//*********************************************************
//Заполнить таблицу
procedure TCalc_Schedule.Paint_Table;
var
i, j : byte;
begin
 for i := 0 to 6 do
  for j := 0 to 6 do begin
   if j=0 then begin
    lt_x_j := 1; rb_x_j := 56;
   end;
   if i=0 then begin
    lt_y_i := 1+25; rb_y_i := 25+25;
   end;
   if j<>0  then begin
    lt_x_j := 1+(j*56); rb_x_j := 56+(j*56);
   end;
   if i<>0  then begin
    lt_y_i := 1+25+(i*25); rb_y_i := 25+25+(i*25);
   end;
//*********************************************************
//До расчета графика
if Metka=false then begin
 if i=0 then
  with FormMain do begin
   Canvas.Pen.Color := clYellow;
   //Canvas.Brush.Color := clYellow;
   Canvas.Font.Color := clBlue;
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Rectangle(lt_x_j, lt_y_i, rb_x_j, rb_y_i);
   Canvas.TextOut(lt_x_j+8,lt_y_i+4,Mass_String_Calendar[j,i]);
  end;
 if i<>0 then
 if Mass_String_Calendar[j,i]<>' ' then
  with FormMain do begin
   Canvas.Pen.Color := clTeal;
   //Canvas.Brush.Color := clTeal;
   Canvas.Font.Color := clBlue;
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Rectangle(lt_x_j, lt_y_i, rb_x_j, rb_y_i);
   Canvas.TextOut(lt_x_j+8,lt_y_i+4,Mass_String_Calendar[j,i]);
  end;
end;
//*********************************************************
//После расчета грфика
if Metka=true then begin
 if i=0 then
  with FormMain do begin
   Canvas.Pen.Color := clYellow;
   //Canvas.Brush.Color := clYellow;
   Canvas.Font.Color := clBlue;
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Rectangle(lt_x_j, lt_y_i, rb_x_j, rb_y_i);
   Canvas.TextOut(lt_x_j+8,lt_y_i+4,Mass_String_Calendar[j,i]);
  end;
//*********************************************************
if((Mass_Boolean_Calendar[j,i]=true) and (i<>0)) then
 if Mass_String_Calendar[j,i]<>' ' then
  with FormMain do begin
   Canvas.Pen.Color := clRed;
   //Canvas.Brush.Color := clRed;
   Canvas.Font.Color := clRed;//clBlue;
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Rectangle(lt_x_j, lt_y_i, rb_x_j, rb_y_i);
   Canvas.TextOut(lt_x_j+1,lt_y_i+4,Mass_String_Calendar[j,i]);
  end;
//*********************************************************
if ((Mass_Boolean_Calendar[j,i]=false) and (i<>0)) then
 if Mass_String_Calendar[j,i]<>' 'then
  with FormMain do begin
   Canvas.Pen.Color := clGreen;
   //Canvas.Brush.Color := clGreen;
   Canvas.Font.Size := 10;
   Canvas.Font.Style := [fsBold];
   Canvas.Font.Color := clGreen;//clBlue;
   Canvas.Rectangle(lt_x_j, lt_y_i, rb_x_j, rb_y_i);
   Canvas.TextOut(lt_x_j+1,lt_y_i+4,Mass_String_Calendar [j,i]);
  end;
//*********************************************************
end;
end;
end;
//*********************************************************
//Дни недели по росийскому стандарту - первый день Понедельник
function TCalc_Schedule.DayOfWeekRus(S: TDateTime): byte;
begin
  case DayOfWeek(S) of
    1: Result := 6;
    2: Result := 0;
    3: Result := 1;
    4: Result := 2;
    5: Result := 3;
    6: Result := 4;
    7: Result := 5;
  end;
end;
//***********************************************//
//Сколько дней в месяце
function TCalc_Schedule.DaysOfMonth(mm, yy: word): Byte;
begin
  if mm = 2 then
  begin
    Result := 28;
    if IsLeapYear(yy) then Result := 29; 
  end  
  else
  begin 
    if mm < 8 then
    begin 
      if (mm mod 2) = 0 then 
        Result := 30 
      else 
        Result := 31; 
    end  
    else
    begin 
      if (mm mod 2) = 0 then 
        Result := 31 
      else 
        Result := 30; 
    end; 
  end; 
end; 
//***********************************************//
//Тип дней - рабочий или выходной
Function TCalc_Schedule.TypeOfDays(S : TDateTime): boolean;
begin
 Cycle := Amount_Work_Day + Amount_Relax_Day;
 Tr_Be_Da_Wo := Trunc(BeginDateWork);
 Tr_S := Trunc(S);
 while Tr_S <= Tr_Be_Da_Wo do begin
  Tr_Be_Da_Wo := Tr_Be_Da_Wo - Cycle;
 end;
 Dif := Tr_S - Tr_Be_Da_Wo;
 Parity := Dif Mod Cycle;
 If Parity < Amount_Work_Day then
  result:=true
 else
 result := false;
end;
//***********************************************//
//О программе...
procedure TFormMain.Button_1Click(Sender: TObject);
begin
AboutBox := TAboutBox.Create (Self);
try
AboutBox.ShowModal;
finally
AboutBox.Free;
end;
end;
//***********************************************//
end.
