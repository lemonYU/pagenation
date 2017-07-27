<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>players</title>
		<%@include file="../../../include/styleTool.jsp" %>
		<%@include file="../../../include/jqueryMobile.jsp" %>
		<%@include file="../../../include/lazyload.jsp" %>
		<style>
 			.ui-bar-b, .ui-page-theme-b .ui-bar-inherit, html .ui-bar-b .ui-bar-inherit, html .ui-body-b .ui-bar-inherit, html body .ui-group-theme-b .ui-bar-inherit {
			    background-color: #ebbf5f;
			    border-color: #ebbf5f;
			    color: #6d3f27;
			    text-shadow: 0 1px 0 #111;
			    font-weight: 700;
			}
			.ui-btn-icon-left:after, .ui-btn-icon-right:after, .ui-btn-icon-top:after, .ui-btn-icon-bottom:after, .ui-btn-icon-notext:after {
		  	    background-color: white; 
    		    background-color: rgba(0,0,0,0); 
			    background-position: center center;
			    background-repeat: no-repeat;
			    -webkit-border-radius: 1em;
			    border-radius: 1em;
			}
			 .ui-icon-carat-r:after {
			     background-image: url(${ctx}/tools/imgs/left.png);
			     background-size:50%;
			}
			.none{display:none;}
			#playerPage a,#playerPage p{font-size:0.7rem;}
			*,body{-webkit-user-select:none;-moz-user-select:none;-o-user-select:none;user-select:none;}
 		</style>
	</head>

	<body data-position="relative">
		<div data-role="page" id="pageone" class='h100 agency2' style='background:#fff'>		
			<div data-role="header" data-theme="b" data-position='fixed'>
				<a href="${ctx}/web/auth/home" data-ajax="false" data-transition="slide" style='background:none;border:none;box-shadow:none;color:#7d5132;font-size:0.9rem;text-shadow:none;padding-top:0.6rem;padding-left:0.5rem;font-weight:normal'><img width='20%' src='${ctx }/tools/imgs/lArrow.png'><span class='pr' style='top:-0.2rem;font-size:0.9rem'>返回</span></a>
				<c:choose>  
				   <c:when test="${not empty myPlayers}">
				   	<h1>my myPlayer(${values.total})</h1>
				   </c:when>  									     
				   <c:otherwise>
				   	<h1>my myPlayer</h1>
				   </c:otherwise>  
				</c:choose>
				<!-- <a data-rel="popup" href="#myPopup"  data-transition="slidedown" class='normal' style='background:none;border:none;box-shadow:none;color:#7d5132;margin-top:-0.05rem;text-shadow:none;font-size:0.9rem'>邀请</a>  -->
				<a href="javascript:;" onclick='qrCode(this)' data-transition="slidedown" class='normal invite' style='background:none;border:none;box-shadow:none;color:#7d5132;margin-top:-0.05rem;text-shadow:none;font-size:0.9rem'>邀请</a> 
			</div>
			
			<div data-role="main" class='h100' style="background:#ededed;text-align:center;">			
				 <c:choose>
				    <%-- 玩家数非零时 --%>	
					<c:when test="${not empty myPlayers}">
						<!-- 新增排序 -->
					    <div style="margin-top:-0.47rem">
					     	 <select id="orders" name='sortType' onchange="selectSort(this.value)">
					     	 	 
					         	 <option value="">选择排序方式</option>
						 		 <option value="bindtime" <c:if test="${values.sortType eq 'bindtime'}">selected</c:if>>绑定时间</option>
                                 <option value="devotetime" <c:if test="${values.sortType eq  'devotetime'}">selected</c:if>>贡献时间</option>
                                 <option value="gold" <c:if test="${values.sortType eq  'gold'}">selected</c:if>>累积贡献最大</option>
                                 <option value="star" <c:if test="${values.sortType eq  'star'}">selected</c:if>>星级最高</option>

				 			 </select> 
					     </div>  
						 <ul data-role="listview" class='myPlayer' style="margin-top:-0.5rem">
						  <c:forEach items="${myPlayers}" var="p">
						 	<li> 
							 	<a href="${ctx}/web/auth/player/subPlayerDetail?id=${p.id}" class="ui-btn ui-corner-all ui-icon-carat-r ui-btn-icon-right normal" data-ajax="false">
							 		<img width="40" height="40" style="left:1rem;top:0.5rem" src="${p.weixin_img }" />
							 		
							 		<c:if test="${empty p.player_id }"> 
							 	    	<span style="margin-left:-1.5rem">${p.weixin_nickname}</span>
							 	    </c:if>
							 	    <c:if test="${not empty p.player_id }"> 
							 	    	<c:if test="${p.status eq '1' }">
								 	    	<span style="margin-left:-1.5rem">${p.weixin_nickname}<span>(${p.player_id})</span> <i style='color:#cb5800'>${p.gtype}星 </i></span>
								 	    </c:if>
								 	    <c:if test="${p.status eq '0' }">
								 	    	<span style="margin-left: -1.5rem"> ${p.weixin_nickname}<span>(${p.player_id})</span></span>
								 	    </c:if>
							 	    </c:if><br/>
									<small class='gray' style="margin-left:-1.5rem"><strong class='green'>贡献&yen;${p.contribution }</strong> </small>
								</a>
						 	</li>
					      </c:forEach>
	                    </ul>
	                    
	                    
	                    <form action="" method="post" id='playerPage'>
		                    <input type='hidden' id="pageNow" value='${values.pageNow }'/> 
		                    <input type='hidden' id="pageNum" value=' ${values.pageNum }'/> 
		                    <input type='hidden' id="sortType" name='sortType' value=''/>  
					    	<!-- 有多页 -->
							<c:if test='${values.pageNow eq 1&&values.pageNum gt 1}'>
							
							         当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页
							   <a href="javascript:;" id='nextpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return next(${values.pageNow+1});'>下一页</a> 
							   <a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(${values.pageNum});'>末 页</a>
							   
							</c:if>
							<c:if test='${values.pageNow gt 1&&values.pageNow lt values.pageNum&&values.pageNum gt 1}'>
								    <a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(1);'>首 页</a> 
									<a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(${values.pageNow-1});'>上一页</a> 
									<a href="javascript:;" id='nextpage' class="ui-btn ui-btn-inline " data-role="button" data-ajax="false" onclick='return next(${values.pageNow+1});'>下一页</a>
									<a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(${values.pageNum});'>末 页</a> 
									<p style='padding-bottom:0.5rem;margin-top:0'>当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页</p> 
								</c:if>
							<c:if test='${values.pageNow eq values.pageNum&&values.pageNum gt 1}'>
								<a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(1);'>首 页</a> 
								<a href="javascript:;" id='prevpage' class="ui-btn ui-btn-inline" data-role="button" data-ajax="false" onclick='return prev(${values.pageNow-1});'>上一页</a>
								当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页
								 
							</c:if>
							<!-- 只有一页 -->
							<c:if test='${values.pageNum le 1}'>										
							         当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页					   
							   
							</c:if>
						</form>
                   	</c:when>
					<c:otherwise>
                   	    <%-- 玩家数为零时 --%>	
	                    <div class='h100 tc playerNull'>
		                    <span class='tc block' style='padding:1rem;font-size:1rem'>你还没有绑定任何玩家</span>
		                    <%-- <span class='tc block' style="color:#bc6d2d">1）你的玩家充值时你获得玩家返利</span>
		                    <span class='tc block' style='padding-top:0.2rem;padding-bottom:1rem;color:#bc6d2d'>2）你的代理获得返利时你获得代理返利</span>
		                    <img class='auto block' width="90%" src="${ctx}/tools/imgs/zspic.png" /> --%>
		                    <a onclick='qrCode()' href="javascript:;" data-role="button" class='ui-btn ui-corner-all ui-btn-inline ui-btn-b invite' data-transition="slidedown" style="background:-webkit-linear-gradient(top,#3bcd4e,#199a40);border:1px solid #03ae1d;margin-top:2rem;width:60%">邀请更多玩家</a> 	
	                    </div>
                   	</c:otherwise>
				</c:choose>
					
				<!--弹窗-->
			    <div data-role="popup" id="myPopup" data-position-to="window" class="ui-content">
			        <a href='javascript:void(0)' data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
			        <h4 class='tc block' style='padding-bottom:0.5rem;border-bottom:1px solid #ccc'>如何绑定和邀请玩家？</h4>
			        <p>1)让对方在游戏大厅点击自己头像，然后绑定你的邀请码${myInvcode}</p>
			        <p>2)新玩家：将下面的二维码发送给微信好友，对方识别后即可自动与你绑定。</p>
			        <div class='tc'>
						<div id="code"></div>
						<img src="" id="imgOne" style="border:5px solid #fff"/><br>
						<small class='gray'>长按二维码可保存</small>
					</div>
			    </div> 
			   
			</div>
		</div>
	</body>
	<script type="text/javascript">
		
	loadPic();
	/*初始化*/
	var pageStart    = 0, /*offset*/
		pageNow      = 1, // 当前页
		pageSize     = 20;// 每页展示20个
		function prev(pageNow){
			$('#playerPage').attr("action","${ctx}/web/auth/player/myPlayer?pageNow="+pageNow);
	    	$("#playerPage").submit();
	    	$('#pageone').empty();
	    	
		}
		function next(pageNow){
			$('#playerPage').attr("action","${ctx}/web/auth/player/myPlayer?pageNow="+pageNow);
	    	$("#playerPage").submit();
	    	$('#pageone').empty();
		}
		
		
		 function selectSort(sortType){
			$('#sortType').val(sortType);
			$('#playerPage').attr("action","${ctx}/web/auth/player/myPlayer?pageNow="+pageNow);
			$("#playerPage").submit();
			$('#pageone').empty();
			
		}  
			/* 
			*初始化配置二维码url
			*/
			
			$('.invite').on('tap',function(e){
				 qrCode();
			}); 
			function qrCode(ele){
				$(ele).on('tap',function(){
				  var qrcodeURL = '';
					$.ajax({
						type:'get',
						url:'${ctx}/web/auth/self/share',
						dataType:'json',
						success:function(json){
							//console.log(json);
							qrcodeURL = json;
							var qrcode = $('#code').qrcode({
								render: "canvas", //也可以替换为table
								width: 120,
								height: 120,
								text : qrcodeURL
								
							}).hide();
							//将生成的二维码转换成图片格式：
							var canvas = qrcode.find('canvas').get(0);
							$('#imgOne').attr('src', canvas.toDataURL('image/jpg'));
						},
						complete:function(){
							$("#myPopup").popup('open');
						},
						error:function(){
							alert('数据获取异常，请稍后再试');
						}
					});
					return false;
				});
				var qrcodeURL = '';
				$.ajax({
					type:'get',
					url:'${ctx}/web/auth/self/share',
					dataType:'json',
					success:function(json){
						//console.log(json);
						qrcodeURL = json;
						var qrcode = $('#code').qrcode({
							render: "canvas", //也可以替换为table
							width: 120,
							height: 120,
							text : qrcodeURL
							
						}).hide();
						//将生成的二维码转换成图片格式：
						var canvas = qrcode.find('canvas').get(0);
						$('#imgOne').attr('src', canvas.toDataURL('image/jpg'));
					},
					complete:function(){
						$("#myPopup").popup('open');
					},
					error:function(){
						alert('数据获取异常，请稍后再试');
					}
				});
				return false;
			  }
			
			 function loadPic(){
				$(".myPlayer img").lazyload({placeholder:"${ctx}/tools/imgs/loading1.gif", //加载图片前的占位图片
					effect: "fadeIn"
				});
			} 
	</script>
</html>