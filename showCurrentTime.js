 function postRequest(strURL, id) {
	var xmlHttp;    
	if (window.XMLHttpRequest) { 
		// Mozilla, Safari, ...        
		var xmlHttp = new XMLHttpRequest();
    } else if (window.ActiveXObject) { 
		// IE        
		var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }//end if

    xmlHttp.open('POST', strURL, true);

    xmlHttp.setRequestHeader('Content-Type', 
         'application/x-www-form-urlencoded');

    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4) {
            updatepage(xmlHttp.responseText, id);
        }
    }//end  xmlHttp.onreadystatechange

    xmlHttp.send(strURL);
}//end function postRequest

function updatepage(str, id){	
	console.log('I am here');		
    document.getElementById(id).innerHTML = "<font color='white' size='2'>" + str + "</font>";
}

var counter = 0;
function time(){	
	postRequest("time.php", "time");	
}	
        
function showCurrentTime(){
	setInterval(time, 1000);
}
