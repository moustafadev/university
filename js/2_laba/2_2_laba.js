//An=(1/(n^p))(1-(x*ln(n))/n)^n

var result = 0;
var n = 2;
var x = 2;
var p = 2;
function fun(x,n){
    var res = 0;
    res = Math.pow(((1-(x*Math.log(n)))/n),n);
    return res;
}

result = (1/(Math.pow(n,p)))*fun(x,n);



WScript.Echo("Result:"+result);




