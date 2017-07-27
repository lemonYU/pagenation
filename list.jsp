<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>promote</title>
		<%@ include file="../../../include/styleTool.jsp" %>  
		<%@ include file="../../../include/bootstrap.jsp" %>
		<%@ include file="../../../include/jqueryMobile.jsp" %>
		<style type="text/css">			
			.ui-bar-b, .ui-page-theme-b .ui-bar-inherit, html .ui-bar-b .ui-bar-inherit, html .ui-body-b .ui-bar-inherit, html body .ui-group-theme-b .ui-bar-inherit {
			    background-color: #ebbf5f;
			    border-color: #ebbf5f;
			    color: #6d3f27;
			    text-shadow: 0 1px 0 #111;
			    font-weight: 700;
			}
			.none{display:none;}
			
			 .table th,.table td{text-align: center;font-size:1rem;}
			 .pageinfo{font-size:1rem;line-height:2.5rem;}
            .page{padding:1rem 20%;overflow:hidden;background: #f4f4f4;}
             @media all and (orientation : portrait){
                 .page{padding:1rem 10%;overflow:hidden;background: #f4f4f4;}
                 .prev{float: left; width:38%;}
                 .next{float: right; width:38%;}
             }
            
            @media all and (orientation : landscape) { 
                .page{padding:1rem 20%;overflow:hidden;background: #f4f4f4;}
                .prev{float: left; width:28%;}
                .next{float: right; width:28%;}
            }
            .promotePage h1 {
			    line-height: 20px;
			}
			@media screen and (min-width : 768px) {
				.table th,.table td{font-size:1.5rem;}
				.pageinfo{font-size:1.2rem;}
			}
		</style>
	</head>
	<body data-position="relative" class='landscape'>
            <div data-role="page" class='h100 promotePage'>
                <div data-role="header" data-theme="b" data-position='fixed'>
                    <a id='back' href='javascript:;' onclick='back()' data-ajax="false" data-transition="slide" style='background:none;border:none;box-shadow:none;color:#7d5132;font-size:0.9rem;text-shadow:none;padding-top:0.6rem;padding-left:0.5rem;font-weight:normal'><img width='20%' src='${ctx }/tools/imgs/lArrow.png'><span class='pr' style='top:0.05rem;font-size:0.9rem'>返回</span></a>
                    <h1>promote</h1>		
                    <a data-ajax="false" href="#" data-transition="slide" class='normal' style='background:none;border:none;box-shadow:none;color:#7d5132;margin-top:-0.05rem;text-shadow:none;font-size:0.9rem'>邀请好友总人数：${values.total}</a>
                </div>
                <div data-role="main" class='ui-content h100 promote_wrap' style="background: #fff;text-align:center;">
                    <table class="table">
                        
                        <tr>
                            <th>promote-time</th>
                            <th>nickname</th>
                            <th>status</th>
                        </tr>
                        <tbody>
                        <c:forEach items="${listData}" var="d">
                        	<!-- 推广成功 -->
                        	
                        		<tr>
	                                <td>${d.union_time }</td>
	                                <td>${d.weixin_nickname }</td>
	                                <c:if  test="${d.tot ge '8'}">
	                                	<td style='color:#57a601'>success</td>
	                                </c:if>
	                                <c:if  test="${d.tot lt '8'}">
	                                	<td style='color:#e82a25'>fail</td>
	                                </c:if> 
	                            </tr>
                        
                        </c:forEach>
                           
                        </tbody>
                       
                    </table>
                    <form action="" method="get" id='promoteRecord' class='page'>
	                    <input type='hidden' id="pageNow" value='${values.pageNow }'/> 
	                    <input type='hidden' id="pageSize" name="pageSize" value='${values.pageSize }'/>
	                    <input type='hidden' id="user_id" name="user_id" value='${values.user_id }'/> 
	                    <input type='hidden' id="player_id" name="player_id" value='${values.player_id }'/> 
				    	<!-- 有多页 -->
						<c:if test='${values.pageNow eq 1&&values.pageNum gt 1}'>
							<!-- 当前第一页，有多页 -->
                           <img class="next" onclick='return next(${values.pageNow+1});' src="${ctx }/tools/imgs/promote/btn_next.png">
						   									
						   <p class='nowrap pageinfo'> 当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页</p>
						   
						</c:if>
						<c:if test='${values.pageNow gt 1&&values.pageNow lt values.pageNum&&values.pageNum gt 1}'>
			                <!-- 当前中间页，有多页 -->
						    <img class="prev" onclick='return prev(${values.pageNow-1});' src="${ctx }/tools/imgs/promote/btn_prev.png">
                            <img class="next" onclick='return next(${values.pageNow+1});' src="${ctx }/tools/imgs/promote/btn_next.png">
							<br><br>						
						    <p class='nowrap pageinfo'> 当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页</p> 
						</c:if>
						<c:if test='${values.pageNow eq values.pageNum&&values.pageNum gt 1}'>
							<!-- 当前最后一页，有多页 -->
							<img class="prev" onclick='return prev(${values.pageNow-1});' src="${ctx }/tools/imgs/promote/btn_prev.png">
																	
						    <p class='nowrap pageinfo'> 当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页</p>
							 
						</c:if>
						<!-- 只有一页 -->
						<c:if test='${values.pageNum le 1}'>
							<%-- <img class="prev" src="${ctx }/tools/imgs/promote/btn_prev.png">
                            <img class="next" src="${ctx }/tools/imgs/promote/btn_next.png"><br><br> --%>	<br>									
						    <p class='nowrap pageinfo'> 当前第<span style='color:#73b34c'>${values.pageNow }</span>页 共<span style='color:#73b34c'>${values.pageNum }</span>页</p>					   
						   
						</c:if>
					</form>
                     
                </div>
            </div>

            
        </body>
        <script>
        function back(){
        	window.open('${ctx }/web/wxshare/pmInviteDetails/'+$('#player_id').val(),'_self')
        }
       
	        /*初始化*/
	    	var pageStart    = 0, /*offset*/
	    		pageNow      = 1, // 当前页
	    		pageSize     = 6;// 每页展示20个
    		function prev(pageNow){
    			$('#promoteRecord').attr("action","${ctx}/web/wxshare/pmInviteList?pageNow="+pageNow);
    	    	$("#promoteRecord").submit();
    	    	
    		}
    		function next(pageNow){
    			$('#promoteRecord').attr("action","${ctx}/web/wxshare/pmInviteList?pageNow="+pageNow);
    	    	$("#promoteRecord").submit();
    		}
        </script>
</html>