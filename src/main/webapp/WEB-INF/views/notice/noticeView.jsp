<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../include/header.jsp" flush="false"/>
<script>

	app.controller('noticeViewCtl', function($scope, consts, common) {
		$scope.loadNoticeInfo= function($page){
	 		
	 		$d = {"baseParms":{"write_no": "${write_no}"},
	 				"actionList":[
					{"actionID":"bbs_notice_info", "actionType":"select" , "tableName": "NOTICE_INFO" ,"parmsList":[]},
					{"actionID":"bbs_file_list", "actionType":"select" , "tableName": "NOTICE_FILE_LIST" ,"parmsList":[]}
	 			 ]};

	 	   	common.callActionSet($d, function(data, status){
	 			$scope.noticeInfo = data["tables"]["NOTICE_INFO"]["rows"][0];
	 			$scope.noticeFileList = data["tables"]["NOTICE_FILE_LIST"]["rows"];
	 		});
		};
		
	});

</script>

<body>
<jsp:include page="../include/topSearch.jsp" flush="false"/>
<div id="wrap" class="noexhibition">
	<jsp:include page="../include/topMenu.jsp" flush="false"/>

	<div class="container_wrap">
		<div class="shadow left"><span class="corner"></span></div>
		<div class="shadow right"><span class="sp_txt img_logo_v"><span class="hidden">&copy; SeoulAuction Corp.</span></span></div>
		<div id="container" ng-controller="noticeViewCtl" data-ng-init="loadNoticeInfo(1);">
			<div class="sub_menu_wrap menu04">
				<div class="sub_menu">
					<jsp:include page="../contents/include/aboutSubMenu.jsp" flush="false"/>
				</div>
				<button type="button" class="m_only btn_submenu"><span class="hidden"><spring:message code="label.submenu" /></span></button>
			</div>
			<!-- //sub_menu_wrap -->
 
			<div class="contents_wrap">	 
				<div class="contents" style="min-height:700px; overflow:visible;">	  
					<div class="tit_h2">
						<h2><spring:message code="label.notice" /></h2> 
					</div>
					<div class="board_read type02">
						<div class="title" ng-if="locale == 'ko' && noticeInfo.WRITE_NO != '3304'">{{noticeInfo.TITLE}}</div>
						<div class="title" ng-if="locale != 'ko' && noticeInfo.WRITE_NO != '3304'">{{noticeInfo.TITLE_EN}}</div>    
                        <div class="title" ng-if="locale == 'ko' && noticeInfo.WRITE_NO == '3304'" style="color:#ff0000;">{{noticeInfo.TITLE}}</div>
						<div class="title" ng-if="locale != 'ko' && noticeInfo.WRITE_NO == '3304'" style="color:#ff0000;">{{noticeInfo.TITLE_EN}}</div>
						<div class="info" ng-show="noticeFileList != undefined && noticeFileList != null && noticeFileList.length > 0">
							<!-- <di> 국내경매 수수료 인상 영문 첨부 나누어 질 시 다시 원복 -->              
							<dl ng-if="locale == 'ko' || (locale != 'ko' && noticeInfo.WRITE_NO != '5507')"> 
								<dt><spring:message code="label.Attachments" /></dt> 
								<dd class="bar_space02" ng-repeat="file in noticeFileList">  
									<a href="/fileDownload?fileName={{file.FILE_NAME}}&path={{file.FILE_PATH}}/&orgName={{file.FILE_NAME_ORG}}">{{file.FILE_NAME_ORG}}</a>  
								</dd>  
							</dl>
						</div>
						<div class="cont" style="line-height:28px;">
							<p ng-if="locale == 'ko'"><span ng-bind-html="noticeInfo.CONTENT" ></span></p>
							<p ng-if="locale != 'ko'"><span ng-bind-html="noticeInfo.CONTENT_EN" ></span></p>
						</div> 
					</div>
					<!-- <div class="board_move">
						<dl>
							<dt><span>이전</span></dt>
							<dd>
								<a href="/about/noticeView?noticeId=${map.notice.prev_notice_id}&showType=${map.notice.show_type }&page=${map.page}&search_type=${map.searchType}&search_content=${map.searchContent}">
								${map.notice.prev_notice_subject }
								</a>
							</dd>
						</dl>
						<dl>
							<dt><span class="next">다음</span></dt>
							<dd>
								<a href="/about/noticeView?noticeId=${map.notice.next_notice_id}&showType=${map.notice.show_type }&page=${map.page}&search_type=${map.searchType}&search_content=${map.searchContent}">
								${map.notice.next_notice_subject }
								</a>
							</dd>
						</dl>
					</div> -->

					<div class="btn_wrap">
						<div class="right">
							<span class="btn_style01 white02 icon btn_list mbtn">
								<span class="ico list"></span>
								<a href="/noticeList">
									<span><spring:message code="label.move.list" /></span>
								</a>
							</span>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
</div>
<!-- //#wrap -->
<jsp:include page="../include/footer_in.jsp" flush="false" />
<jsp:include page="../include/footer.jsp" flush="false" />
