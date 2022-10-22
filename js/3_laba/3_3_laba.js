//var script = "And disappear into the crowd. Yet my soul remains full of dream desires and a longing for memories. O love, hear my cry, O love, send your visions back to me, and when the morning breaks, do not wake me, but let me rest my eternal slumber.";


var arrResult= [];

var obj = WScript.Arguments;
var script = obj.Item(0);
var countNum = obj.Item(1);

var arrScript = script.split(' ');

function findCountWord(arrScript,countNum){
    for(var i=0 ;i<arrScript.length;i++){
        if(arrScript[i].length == countNum)
            WScript.Echo(arrScript[i]); 
    }
    return;
}

WScript.Echo('Source text:\n' + script + '\n');
WScript.Echo('\nNumber of words with a letter \'' + countNum + '\': ' +
findCountWord(arrScript,countNum));

