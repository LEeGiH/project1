 function writeSave() {
    var id = document.getElementById("id").value;
    var pw = document.getElementById("pw").value;
    var pwRe = document.getElementById("pwRe").value;
    var username = document.getElementById("username").value;
    var birth = document.getElementById("birth").value;
    var phone1 = document.getElementById("phone1").value;
    var phone2 = document.getElementById("phone2").value;
    var phone3 = document.getElementById("phone3").value;
    var sex = document.getElementById("sex").value;
    var nick = document.getElementById("nick").value;

	const fields = [id, pw, pwRe, username, sex, birth, phone1, phone2, phone3, nick];
	var idPattern = /^[a-zA-Z0-9]+$/;
	var nickRegex = /^[^ \s!"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]*$/;
    if (!idPattern.test(id)) {
        alert("ID는 영어와 숫자만 사용 가능합니다.");
        return false;
    }
	if (fields.some(field => field === "")) {
	alert("입력되지 않은 항목이 있습니다.");
	   return false;
	}
	if (!nickRegex.test(nick)) {
        alert("닉네임은 영어 대소문자, 한글, 숫자만 사용 가능합니다.");
        return false; // 폼 전송을 막습니다.
    }
    if (pw !== pwRe) {
        alert("비밀번호가 일치하지 않습니다.");
        
        document.getElementById("pwRe").focus();
        return false;
    }
    if (id.length > 8 || id.length < 4 ){
		alert("아이디는 4~8사이로 입력해주세요.");
        document.getElementById("id").focus();
        return false;
	}    
	if (pw.length < 8 || pw.length >= 12 ){
		alert("비밀번호는 8~12사이로 입력해주세요.");
        document.getElementById("pw").focus();
        return false;
	}
    return true;
}

