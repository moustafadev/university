
function includeHTML() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        console.log(this.responseText);
    if (this.readyState == 4 && this.status == 200) {
        document.getElementById("includedContent").innerHTML = this.responseText;
    }
    };
    xhttp.open("GET", "/templates/index.html", true);
    xhttp.send();
}