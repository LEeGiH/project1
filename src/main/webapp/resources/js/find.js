 function findid() {
    var username = document.getElementById("username").value;
    var phone1 = document.getElementById("phone1").value;
    var phone2 = document.getElementById("phone2").value;
    var phone3 = document.getElementById("phone3").value;

	const findid = [username,phone1, phone2, phone3];

	if (findid.some(findid => findid === "")) {
	alert("입력되지 않은 필수 항목이 있습니다.");
	   return false;
	}
	
    return true; 
	}
 function findpw() {
    var id = document.getElementById("id").value;
    var phone1 = document.getElementById("phone1").value;
    var phone2 = document.getElementById("phone2").value;
    var phone3 = document.getElementById("phone3").value;

	const findpw = [id,phone1, phone2, phone3];

	if (findpw.some(findpw => findpw === "")) {
	alert("입력되지 않은 필수 항목이 있습니다.");
	   return false;
	}
    return true;
}

