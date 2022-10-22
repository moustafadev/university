

var n = 2;
var x = 2;
var result = 0;
var fact = 1,c=1;
while (c <= n) {
	fact = fact * c;
	c++;
}
var fact1 = 1,i = 1;
while (i <= 2 * n) {
	fact1 = fact1 * i;
	i++;
}
var pow = 1;
for (var j = 1; j < n; j++) {
	pow *= x;
}


for (i=1; i<(n+1); i++)
	result += (fact*fact)/fact1*pow;
WScript.Echo("Сумма ряда равна:"+result);
