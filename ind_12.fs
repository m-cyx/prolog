//7. Для введенного списка построить новый список, который получен из
//начального упорядочиванием по количеству встречаемости элемента,
//То есть из списка [5,6,2,2,3,3,3,5,5,5] необходимо получить список [5,5,5,5,3,3,3,2,2,6]. 



let rec read_list n = 
    if n=0 then []
    else
    let Head = System.Convert.ToInt32(System.Console.ReadLine())
    let Tail = read_list (n-1)
    Head::Tail

    [<EntryPoint>]
let main argv = 
    0 // return an integer exit code