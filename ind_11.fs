open System
open System.IO
open System.Windows.Forms
open System.Drawing

let form = new Form(Width= 400, Height = 300, Text = "Высокотехнологичное программное обеспечение")
let cb1 = new CheckBox(Text="1", Top=20, Left=50)
let cb2 = new CheckBox(Text="2", Top=20, Left=200)
let textbox = new TextBox(Left=50, Top=100, Width=300, Text="")
let button = new Button(Text="чек", Left=50, Top=150, Height = 50,  Width=300)

form.Controls.Add(cb1)
form.Controls.Add(cb2)
form.Controls.Add(textbox)
form.Controls.Add(button)


[<EntryPoint>]
let main argv =
    do Application.Run(form)
    0 // return an integer exit code