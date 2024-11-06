<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<meta charset="UTF-8">
    <link rel="stylesheet"  href="../resources/css/main.css">
    <title>게시판</title>
<div class="main1block">
<div class="log">
<img src="/project/resources/image/log.png" width="287px" height="70px" >
</div>
</div>
<br/><br/>


<form action="input.jsp" onclick='is_checked()'>
	<input type="checkbox" name="agree" id="agree" value="1" onclick='is_checked()' />[필수] 조==null; 이용약관                           
	<div class="article">
		<h3 class="article_title">여러분을 환영합니다.</h3>
		<p class="article_text">
		조==null; 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 조==null; 서비스의 이용과
		관련하여 조==null; 서비스를 제공하는 조==null; 이를 이용하는 조==null; 서비스 회원(이하
		‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 조==null; 서비스 이용에 도움이 될 수 있는 유익한
		정보를 포함하고 있습니다.
		</p><br/><br/>
	
	</div>
	
	<input type="checkbox" name="agree1" id="agree1" value="2" onclick='is_checked()' />[필수] 개인정보 수집 및 이용
	<div class="article">
		<p class="article_text">
        개인정보보호법에 따라 조==null;에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및
        이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니
        자세히 읽은 후 동의하여 주시기 바랍니다.
    	</p><br/><br/>
	</div>
	
	<input type="checkbox" name="agree2"  value="3" />[선택] 실명 인증된 아이디로 가입
	<div class="article">
		<p class="article_text">
        실명 인증된 아이디로 가입하시면 본인인증이 필요한 서비스(조==null;) 가입 후 바로 이용하실 수 있어요.</p>
    	</p><br/><br/>
	</div>
	
	<input type="checkbox" name="agree3" value="4" />[선택] 위치 서비스 기반 이용약관
	<div class="article">
		<p class="article_text">
        위치기반서비스 이용약관에 동의하시면,
        <strong>위치를 활용한 광고 정보 수신 등을 포함하는 조==null; 위치기반 서비스</strong>를 이용할 수 있습니다.
    	</p><br/><br/>
    </div>  
	<div class="btn_submit_wrap" >
        <input type="submit"  id="next" value="다음" class="submit-button" disabled />
    </div>
  
    
<script>
function is_checked() {
	  
	  var checkbox = document.getElementById('agree');
	  var checkbox1 = document.getElementById('agree1');
	  var is_checked = checkbox.checked;
	  var is_checked1 = checkbox1.checked;
	  
	   if (is_checked !== true || is_checked1 !== true){
			  document.getElementById('next').disabled = true;  
		  		return false;
		}
		document.getElementById('next').disabled = false;  
	}
	
</script>
</form>
