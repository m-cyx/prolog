open System
open System.IO
open System.Drawing
open System.Windows.Forms




let window = new Form(Width= 400, Height = 300, Text = "Высокотехнологичное программное обеспечение")
let cb1 = new CheckBox(Text="Первый", Top=20, Left=50)
let cb2 = new CheckBox(Text="Второй", Top=20, Left=200)
let textbox = new TextBox(Text="Внимание: не нажимайте на кнопку ниже!", Left=50, Top=50, Width=300)
let button = new Button(Text="НЕ НАЖИМАТЬ!", Left=50, Top=100, Width=300, Height = 50)
window.Controls.Add(cb1)
window.Controls.Add(cb2)
window.Controls.Add(textbox)
window.Controls.Add(button)



//если нажата кнопка 
let knopka_press _ = 
    if (cb1.Checked=false && cb2.Checked=false) then
        textbox.Text<-"Галочки не установлены"
    if (cb1.Checked=true && cb2.Checked=false) then
        textbox.Text<-"Установлена только первая галочка"
    if (cb1.Checked=false && cb2.Checked=true) then
        textbox.Text<-"Установлена только вторая галочка"
    if (cb1.Checked=true && cb2.Checked=true) then
        textbox.Text<-"Обе галочки установлены "
   
    window.Controls.Remove(textbox)         //отчищаем текстбокс
    window.Controls.Add(textbox)
    |> ignore


let _ = button.Click.Add(knopka_press)     //триггер нажатия


[<EntryPoint>]
let main argv =
    do Application.Run(window)            //запускаю форму
    0 // return an integer exit code