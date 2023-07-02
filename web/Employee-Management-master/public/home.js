function openNav() {
    //opens side navbar by 70 percent
    document.getElementById("mySidenav").style.width = "30%" 

//opens overlay display
    document.getElementById('backdrop').style.display = "block" 
}

function closeNav() {
    //closes side navbar totally
    document.getElementById("mySidenav").style.width = "0"

    //removes overlay display
    document.getElementById('backdrop').style.display = "none"
}

const myElement = document.getElementById('my-element');

if(10>5){
    myElement.innerHTML = '<h1>Hello, world!</h1>';
}else{
    myElement.innerHTML = '<h1>Hello!</h1>';
}

// считываем входные данные
