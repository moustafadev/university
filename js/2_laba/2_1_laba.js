//lab1, var4: A_n = (((n!)^2)/(2*n)!)*x^n

function step(num, d)
{
    var res = 1;
    for (i = 0; i < d; i++)
        res *= num;
    return res;
}

function factor(num)
{
    var res = 1;
    if (num > 0) 
    for (i = 1; i <= num; i++)
		res = res * i;
    return res;
}

var n = 2;
var x = 2;
var result = 0;

for (i=1; i<(n+1); i++)
	result += (factor(i)*factor(i))/factor(2*i)*step(x, i);
WScript.Echo("Сумма ряда равна:"+result);