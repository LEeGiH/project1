function changes1Step(fr) {
	num =  fr.split(",");
	count = form.Step2.length;
	for(i=0; i<count; i++) {
		form.Step2.options[0] = null;
	}
	console.log(form.Step2.length+"=="+fr);
	for(i=0; i<num.length; i++) {
		form.Step2.options[i] = new Option(num[i],num[i]);
	}
}

function changesfiles(fc) {	
	var fileList = document.getElementById('thisfilelist');
		fileList.innerHTML = '';
	for(var i =0 ; i< fc ; i++) {		
		fileList.innerHTML = fileList.innerHTML + "<input type='file' name='files" + i + "'><br>"
	}
}

function changesimg(fc) {	
	var imgList = document.getElementById('thisimglist');
		imgList.innerHTML = '';
	for(var i =0 ; i< fc ; i++) {		
		imgList.innerHTML = imgList.innerHTML + "<input type='file' name='img" + i + "'><br>"
	}
}

function checkfiles() {
	var form = document.getElementById('form');
	var formData = new FormData(form);
	var fileList = document.getElementById('thisfilelist');
	fileList.innerHTML = '';
	var filenames = document.getElementById('files').files;
	for (var i = 0; i < filenames.length; i++) {
		var listItem = document.createElement('li');
		listItem.textContent = filenames[i].name;
		fileList.appendChild(listItem);
	}
	var imageList = document.getElementById('thisimglist');
	imageList.innerHTML = '';
	var imgnames = document.getElementById('img').files;
	for (var i = 0; i < imgnames.length; i++) {
		var listItem = document.createElement('li');
		listItem.textContent = imgnames[i].name;
		imageList.appendChild(listItem);
	}
	var xhr = new XMLHttpRequest();
	xhr.open('POST', form.action);
	xhr.onload = function() {
		if (xhr.status === 200) {
			console.log(xhr.responseText);
		} else {
			console.error('파일 업로드 실패:', xhr.status);
		}
	};
	xhr.send(formData);
}

function names(){
	var form = document.getElementById('form');
	var formData = new FormData(form);
	var filenames = document.getElementById('files').files;
	var filenamelist = "";
	for (var i = 0; i < filenames.length; i++) {
		if(filenamelist === "" ){
			filenamelist = filenames[i].name;
		}else{
			filenamelist = filenamelist +","+ filenames[i].name;
		}
	}
	document.getElementById("thisfilenames").value = filenamelist;
	var imgnames = document.getElementById('img').files;
	var imgnamelist = "";
	for (var i = 0; i < imgnames.length; i++) {
		if(imgnamelist === "" ){
			imgnamelist = imgnames[i].name;
		}else{
			imgnamelist = imgnamelist +","+ imgnames[i].name;
		}
	}
	document.getElementById("thisimgnames").value = imgnamelist;
	var xhr = new XMLHttpRequest();
	xhr.open('POST', form.action);
	xhr.onload = function() {
		if (xhr.status === 200) {
			console.log(xhr.responseText);
		} else {
			console.error('파일 업로드 실패:', xhr.status);
		}
	};
	xhr.send(formData);
}

function changekate(){
	open("changekate.jsp","카테고리 변경","width=600 . height=400 ");
}

function selectchange(){
	var target = document.getElementById("Step1");
	opener.document.getElementById("readkate").value = target.options[target.selectedIndex].text;
	opener.document.getElementById("readlist").value = document.getElementById("Step2").value
	self.close();
}

function changelist(){
	document.getElementById("changelistname").value = document.getElementById("readlist").value;
}


