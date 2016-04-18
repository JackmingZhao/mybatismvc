<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=basePath%>js/jquery/base/jquery.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery/base/fweb.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div>
		<label>regist users</label> <br>
		<br>
		<span></span>
		<form id="reg_form" method="post">
			id：<input type="text" name="userid"> <br>
			name：<input type="text" name="username"> <br>
		</form>
		<input type="button" value="提交" onclick="regist();">
	</div>
	<br>
</body>

<script type="text/javascript">
	function regist() {
		var params = $('#reg_form').serializeJson();
		if(typeof JSON == 'undefined'){
			$('head').append($("<script type='text/javascript' src='<%=basePath%>js/json2.js'>"));
			params = JSON2.stringify(params);
        } else {
			params = JSON.stringify(params);
        }
		
		$.ajax({
			type: "POST", 
		    contentType: "application/json; charset=utf-8",
			dataType: "json", 
			url: '<%=basePath%>user/updateUser',
            contentType:"application/json",
			data: params,
			success: function (data) {
				alert(data);
				$.each(data, function(i, val) {  
				    var text = "Key:" + i + ", Value:" + val;  
					alert(text);
				});
			},
			error: function(data) {
				alert("出错");
			}
		});
	}
	
	function serializeArray() {
		var arr = document.getElementById("#reg_form").children;
		var param= "{";
		for(var i=0;i<arr.length;i++) {
			if(arr[i].tagName=="INPUT") {
				var proname = arr[i].name;
				var provalue = arr[i].value;
				param+='"'+proname+'"'+':'+'"'+provalue+'"'+',';
			}
		}
		param=param.substring(0, param.length-1);
		param+="}";
		xmlHttp.onreadystatechange=function() {
		  if (xmlHttp.readyState==4 && xmlHttp.status==200)
		    {
		    	alert(xmlHttp.responseText);
		    }
		}
		xmlHttp.open("POST", "mini/insert", true);
		xmlHttp.setRequestHeader("Content-type","application/json");
		xmlHttp.send(param);
	}
</script>
</html>