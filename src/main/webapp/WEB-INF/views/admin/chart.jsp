<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<div class="container member-profile">
       		<div class="row">
               <div class="col-2">
                   <div class="profile-work">
                       <a href="#"><p>회원목록</p></a>
                       <p>통계</p>	
 				 	   <a href="${pageContext.request.contextPath}/admin/chart.do">-가입 회원</a><br />
 				 	   <a href="#">-회원 주소</a><br />
 				 	   <a href="#">-리뷰 작성</a><br />
 				 	   <a href="#">-북토리 충전</a>
                   </div>
               </div>
               <div class="container-chart">
	               <div class = "select-chart">
	               		<select id="chart-category">
	               			<option value="yaer" selected="selected">월</option>
	               			<option value="month">일</option>
	               		</select>
	               		<select id="chart-category-second" style="display: hidden">
			               	<option value="1">1월</option>
			               	<option value="2">2월</option>
			               	<option value="3">3월</option>
			               	<option value="4">4월</option>
			               	<option value="5">5월</option>
			               	<option value="6">6월</option>
			            </select>
	               </div>
					<div class ="main-chart">
			  			<canvas id="myChart" style="width : 800px;"></canvas>
					</div>
				</div>
		   </div>           
	</div>


<script>

$(document).ready(function() {

  var labels = [
	    '1월',
	    '2월',
	    '3월',
	    '4월',
	    '5월',
	    '6월'
	  ];

  var chartdata = {
    labels: labels,
    datasets: [{
      label: '가입 회원수',
      backgroundColor: 'rgb(255, 99, 132)',
      borderColor: 'rgb(255, 99, 132)',
      data: [${arr[0]}, ${arr[1]}, ${arr[2]}, ${arr[3]}, ${arr[4]}, ${arr[5]},${arr[6]}],
    }]
  };

  var config = {
    type: 'line',
    data: chartdata,
    options: {}
  };
  var myChart = new Chart(
		    document.getElementById('myChart'),
		    config
		  );

  
  $("#chart-category").on('change',function(e) {
	var category = $(e.target).val();
	
	if(category == "month"){
		$("#chart-category-second").css("display","inline-block");
	}
	else{
		$("#chart-category-second").css("display","none");
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/admin/selectChartMonth",
		method: "GET",
		data:{
			category: category
		},
		success(data){
			console.log(data);
		},
		error: console.log
	});
	
  });
  
  $("#chart-category-second").on('change',function(e){
	 var month = $(e.target).val();
	 
	 $.ajax({
			url: "${pageContext.request.contextPath}/admin/selectChartDay",
			method: "GET",
			data:{
				month: month
			},
			success(data){
				myChart.destroy();
				var len = data.length;

				labels = [];
				for(var i = 0 ; i <data.length; i++){
					labels[i] = data[i].md;
				}
				console.log(labels);
				chartdata = {
						    labels: labels,
						    datasets: [{
						      label: '가입 회원수',
						      backgroundColor: 'rgb(255, 99, 132)',
						      borderColor: 'rgb(255, 99, 132)',
						      data: [data[0].count],
						    }]
				};
				config = {
					    type: 'line',
					    data: chartdata,
					    options: {}
					  };
				myChart = new Chart(
					    document.getElementById('myChart'),
					    config
					  );
				
				
				
			},
			error: console.log
		});
	 
	  
  });
  
  
  
 
});
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>