

var n = 3;
var x = 4;
var result = 0;
var firstFector = 1,i=1;
while (i <= 2 * n) {
	firstFector = firstFector * i;
	i++;
}

var step = 1;
for (i=1; i<(n+1); i++)
    step *= x;

var scoundFector = 1,j=1;
while (j <= n) {
	scoundFector = scoundFector * j;
	j++;
}

for (i=1; i<(n+1); i++)
	result += (((scoundFector**2)/(firstFector))*step)


console.log(result);
//WScript.Echo("Сумма ряда равна:"+result);