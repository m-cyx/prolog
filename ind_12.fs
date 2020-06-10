//7. Для введенного списка построить новый список, который получен из
//начального упорядочиванием по количеству встречаемости элемента,
//То есть из списка [5,6,2,2,3,3,3,5,5,5] необходимо получить список [5,5,5,5,3,3,3,2,2,6]. 
let rec read_list n = //читаю лист рекурсивно 
    if n=0 then []
    else
    let Head = System.Convert.ToInt32(System.Console.ReadLine()) //символ -> 32бит число
    let Tail = read_list (n-1)
    Head::Tail

let rec write_list (count,num) = //вывожу лист рекурсивно 
    match count,num with
    |h1::tail,h2::tail2 when h1>0 ->
        System.Console.Write(int(h2));
        System.Console.Write("\n");
        let newcount = 
            let head = h1-1
            head::tail
        write_list (newcount,num)

    |h1::tail,h2::tail2 -> write_list (tail,tail2)
    |_,_ -> ()

let enter_list = //ввожу список
    System.Console.Write("Кол-во элементов исходного списка: ")
    let n=System.Convert.ToInt32(System.Console.ReadLine())
    System.Console.Write("Введите список:\n")
    read_list n

let rec findEl X El = //есть ли элемент в текущем списке
    match X with
    |head::tail when head=El -> true
    |head::tail -> findEl tail El
    |[] -> false
    
let FindCountEl L El = //сколько раз текущий элемент в списке
    let rec findCountEl L El count = 
        match L with
        |head::tail when head=El -> findCountEl tail El count+1
        |head::tail -> findCountEl tail El count
        |[] -> count
    findCountEl L El 0

let ListOfUnic list =  //полчение списка уникальных
    let rec createListOfUnic list res =  
        match list with
        |head::tail when findEl res head = false -> let result = res@[head] 
                                                    createListOfUnic list result
        |head::tail -> createListOfUnic tail res
        |[]->res
    createListOfUnic list []
    
let MakeCountList refList unicList = //получеение списка кол-ва каждого элмента
    let rec makeCountList refList unicList res = 
        match unicList with
        |head::tail -> let count = FindCountEl refList head
                       let result = res@[count]
                       makeCountList refList tail result
        |[]->res
    makeCountList refList unicList []

let ResultList list list2 =  // по двум спискам выводит результат 
    let rec sort pred list res pred2 list2 res2 = 
        match list,list2 with
        |s1::s2::tail,s3::s4::tail2 when s1<s2 -> 
            let result = pred@[s2;s1]@tail //конкатинируем
            let result2 = pred2@[s4;s3]@tail2
            sort [] result result [] result2 result2
        |s1::s2::tail,s3::s4::tail2 -> 
            let Tail = s2::tail
            let prednew = pred@[s1]
            let Tail2 = s4::tail2
            let prednew2 = pred2@[s3]
            sort prednew Tail res prednew2 Tail2 res2
        
        |[],[]->res,res2
        |_,[]->res,res2
        |[],_->res,res2
        |_,_->res,res2
    
    sort [] list list [] list2 list2

[<EntryPoint>]
let main argv = 
    let list = enter_list
    let unicEl = ListOfUnic list
    let unicCountList = MakeCountList list unicEl
    let resultOut = ResultList unicCountList unicEl
    System.Console.Write("Результирующий список:\n")
    write_list resultOut
    let pause = System.Console.ReadKey()
    0 // return an integer exit code