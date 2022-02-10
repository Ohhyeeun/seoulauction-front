<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE HTML> 
<div id="custom-modal" class="modal" style="top: 100px; display: block; width:540px;">
<div id="overlay" class="pop_wrap">
	<style> 
		.loading_container {
			display: none;
		}
		.loading_container > img {
			position: absolute;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			margin: auto;
			z-index: 15;
		}
		
		.find_cont .both_cont > div {
		    box-sizing: border-box !important;
		    
		    /* 20210528 csy추가 */
		    width:100%;
	        display: flex;
		    flex-direction: column;
		    align-items: center;
		}
		
		
	</style>
	 
		<button type="button" ng-click="closeThisDialog(this);" class="sp_btn btn_pop_close"><span class="hidden">닫기</span></button>
		<div class="title">
			<h2><spring:message code="label.passwordloginIdfind" /></h2>
		</div>
		<div class="cont">
			<div class="tab_wrap type01 wide find">
				<div class="tab tab01" ng-class="search_kind == 'id' ? 'sele' : ''"><a href="#" ng-click="search_kind = 'id'"><spring:message code="label.loginIdfind" /></a></div>
				<div class="tab_cont" ng-class="search_kind == 'id' ? 'sele' : ''">
					<div class="find_cont">
						<div class="list_style01" ng-hide="custInfo">
							<ul>
								<li ng-if="locale != 'en'">회원정보에 등록된 정보로 아이디를 찾을 수 있습니다.</li>
								<li ng-if="locale == 'en'">You can find the ID by the information registered in the member information.</li>
								<li ng-if="locale != 'en'"><strong>가입 시 입력한 정보를 입력하신 후 <span class="txt_green">아이디 찾기 버튼을 클릭</span>해주세요.</strong></li>
								<li ng-if="locale == 'en'"><strong>Enter your information that you entered when you signed up and <span class="txt_green">click the Find ID button.</span></strong></li>
							</ul>
						</div>
						<div class="idContainer" ng-hide="custInfo"> <!-- form -->
							<fieldset>
								<div class="loading_container idLoading">
									<img alt="loading" src="/images/loading.gif">
								</div>
								<legend><spring:message code="label.passwordfind" /></legend>
								<div class="both_cont border"><!-- [D]회원가입 완료시 회원가입부분 보이지 않게 처리 -> 클래스 'login' 추가 -->
									<div>
									<form name="id_person" onsubmit="" method="post">
										<div class="inner bg_img bg04">
											<div class="tit_h3 noborder">
												<h3>{{locale == 'ko'? '아이디 찾기': 'Find your ID'}}</h3>
											</div>
											<div class="lb_wrap first">
													<label for="search_way_email" style="font-weight: bold;">
														<input type="radio" name="search_way" id="search_way_email" ng-model="search_way" value="email" tabindex=1 />
														<span>{{locale == 'ko'? '이메일로 찾기': 'Email'}}</span>
													</label>
													
													<label for="search_way_phone" style="font-weight: bold;">
														<input type="radio" name="search_way" id="search_way_phone" ng-model="search_way" value="phone" tabindex=1 />
														<span>{{locale == 'ko'? '휴대폰로 찾기': 'Mobile'}}</span>
													</label>
													
												</div>
											<div>
												<div class="input_full fl_wrap input_email input_flex_row"  >
													<input type="text" ng-model="form_data.cust_name" placeholder="{{locale == 'ko'? '이름 입력하기': 'Input your name' }}" tabindex=2 autofocus="autofocus" required/>
												</div>
												<div ng-show="search_way == 'phone'" class="fl_wrap type02" >
														<div class="input_email input_flex_row">
															<select id="Customer_phone" name="Customer_phone" ng-model="form_data.p_phone" style="margin-right: 0;" ng-required="search_way == 'phone'" tabindex=3  >        
																<option value="" selected>{{locale == 'ko'? '선택': 'Select'}}</option>
																<option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option> 
															</select>  
															<span class="tbl_label" style="margin-right: 0;">-</span>   
															<input type="text" id="Customer_phone2" name="p_phone2" ng-model="form_data.p_phone2" value="" class="tac" placeholder="{{locale == 'ko'? '앞자리': ' ' }}" maxlength=4  style="margin-right: 0; ime-mode:disabled;" ng-required="search_way == 'phone'" tabindex=4 />   
															<span class="tbl_label" style="margin-right: 0;">-</span>  
															<input type="text" id="Customer_phone3" name="p_phone3" ng-model="form_data.p_phone3" value="" class="tac" placeholder="{{locale == 'ko'? '뒷자리': ' '}}" maxlength=4  style="margin-right: 0; ime-mode:disabled;" ng-required="search_way == 'phone'" tabindex=5/>  
														</div>
													</div>
													<div ng-show="search_way == 'email'" class="fl_wrap type02">
														<div class="input_email input_flex_row">
															<input type="text" name="p_email1" ng-model="form_data.p_email1" placeholder="{{locale == 'ko'? '이메일 앞부분': 'Email account'}}" tabindex=3 ng-required="search_way == 'email'"/>
															<span class="tbl_label">@</span>
															<input type="text" name="p_email2" ng-model="form_data.p_email2" placeholder="{{locale == 'ko'? '이메일 도메인': 'domain'}}" tabindex=4 ng-required="search_way == 'email'"/>
															<select name="p_email_select" ng-model="p_email_select" ng-change="form_data.p_email2=p_email_select;" tabindex=5 >
																<option value="" >{{locale == 'ko'? '선택하기': 'Select'}}</option>
																<option value="naver.com">naver.com</option>
																<option value="nate.com">nate.com</option>
																<option value="gmail.com">gmail.com</option>
																<option value="daum.net">daum.net</option>
																<option value="hanmail.net">hanmail.net</option>
																<option value="hotmail.com">hotmail.com</option>
															</select>
														</div>
													</div>										
												<div class="btn_wrap">
													<span class="btn_style01 green02 xlarge">
														<button type="submit" ng-click="searchId()">{{locale == 'ko'? '아이디 찾기' : 'Find your ID'}}</button>
<!-- 														<a href="#" ng-if="locale != 'en'" ng-click="searchId('person')"></a> -->
<!-- 														<a href="#" ng-if="locale == 'en'" ng-click="searchId('person')">Find your ID</a> -->
													</span>
												</div>
											</div>
										</div>	
										</form>
									</div>
								</div>
							</fieldset>
						</div>						
						
						<div class="box_style01 idContainer" ng-hide="custInfo">
							<div class="list_style02">
								<ul>
									<li ng-if="locale != 'en'">아이디를 찾으실 수 없을 경우, <strong>대표번호 02-395-0330</strong>로 연락바랍니다.</li>
									<li ng-if="locale == 'en'">If you can not find your ID, please email <strong>webmaster@seoulauction.com</strong></li>
									
									<li ng-if="locale != 'en'">
										해외 국적으로 가입하신 회원은 서울옥션 영문홈페이지를 이용해주세요.<br />
										Please, foreigners use English pages.
									</li>
								</ul>
							</div>
							<span class="btn_style01" ng-if="locale != 'en'"><a href="/login/?lang=en">Seoul Auction ENG</a></span>
						</div>
						
						<!-- 결과 -->
						<div id="idResultContainer" class="box_style02" ng-show="custInfo">
							<div class="bg_img bg27">
								<div ng-if="custInfo.length > 0">
									<p class="txt_style02">회원님의 아이디는 
									<strong id="foundId" class="txt_green">
										<span ng-repeat="cust in custInfo">
											{{!$first ? ',': ''}} {{cust.LOGIN_ID}}
										</span>
									</strong> 입니다.</p>
									<p class="lh20">※ 개인정보 보호를 위해 아이디 일부는 *로 표시됩니다.</br>※ 아이디가 확인되지 않을경우 성함과 등록시 입력한 이메일을 확인 후 다시 조회 부탁드립니다.</br>
									                ※ 아이디를 찾으실 수 없을 경우, <strong>대표번호 02-395-0330</strong>로 연락바랍니다.</p>
									<div class="btn_wrap border">
										<span class="btn_style01 green02 xlarge"><a href="/login">로그인</a></span>
										<!-- 임시로 버튼 없앰 -->
										<!-- <span class="btn_style01 dark xlarge">
											<a href="#" ng-click="search_kind = 'passwd'"  ng-if="locale != 'en'">비밀번호 찾기</a>
											<a href="#" ng-click="search_kind = 'passwd'"  ng-if="locale == 'en'">Find your password</a> href="javascript:changeTab(true);"
										</span> -->
									</div>
								</div>
								<div ng-if="custInfo.length <= 0">
									<p class="txt_style02">일치하는 회원 정보가 없습니다.</p>
									<p class="lh20">※ 아이디가 확인되지 않을경우 성함과 등록시 입력한 이메일을 확인 후 다시 조회 부탁드립니다.</br>
									                ※ 아이디를 찾으실 수 없을 경우, <strong>대표번호 02-395-0330</strong>로 연락바랍니다.</p>
									<div class="btn_wrap border">
										<span class="btn_style01 green02 xlarge">
											<a href="/join/agree" ng-if="locale != 'en'">회원가입 하기</a>
											<a href="/join/agree" ng-if="locale == 'en'">Register Now</a>
										</span>
<!-- 										<span class="btn_style01 dark xlarge"> -->
<!-- 											<a href="javascript:changeTab(false);" ng-if="locale != 'en'">다시 입력</a> -->
<!-- 											<a href="javascript:changeTab(true);" ng-if="locale == 'en'">Find your password</a> -->
<!-- 										</span> -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="tab tab02" ng-class="search_kind == 'passwd' ? 'sele' : ''">
					<a href="#" ng-click="search_kind = 'passwd'"><spring:message code="label.passwordfind" /></a>
				</div>
				<div class="tab_cont" ng-class="search_kind == 'passwd' ? 'sele' : ''">
					<div class="find_cont">
						<div class="list_style01">
							<ul>
								<li ng-if="locale != 'en'">비밀번호의 경우, 암호화 저장되어 분실 시 찾아드릴 수 없습니다.</li>
								<li ng-if="locale == 'en'">If the password is encrypted, it can not be retrieved if the password is lost.</li>
								<li ng-if="locale != 'en'"><strong class="txt_green">회원정보에 등록된 이메일로 임시 비밀번호를 발송</strong>해드립니다.</li>
								<li ng-if="locale == 'en'">We will send you <strong class="txt_green">a temporary password via email to your membership information</strong>.</li>
							</ul>
						</div>
						<div class="pwContainer" > <!-- form -->
							<fieldset>
								<div class="loading_container pwLoading">
									<img alt="loading" src="/images/loading.gif">	
								</div>
								<legend>{{locale == 'ko'? '비밀번호 찾기' : 'Find your password'}}</legend>
								<div class="both_cont border"><!-- [D]회원가입 완료시 회원가입부분 보이지 않게 처리 -> 클래스 'login' 추가 -->
									<div>
										<form name="pw_person" onsubmit="" method="post">
											<div class="inner bg_img bg04">
												<div class="tit_h3 noborder">
													<h3>{{locale == 'ko'? '비밀번호 찾기' : 'Find your password'}}</h3>
<!-- 													<h3 ng-if="locale != 'en'">개인회원</h3>
<!-- 													<h3 ng-if="locale == 'en'">Individual Member</h3> -->
												</div>
												<div class="lb_wrap first">
													<label for="search_way_email" style="font-weight: bold;">
														<input type="radio" name="search_way" id="search_way_email" ng-model="search_way" value="email" tabindex=1 />
														<span>{{locale == 'ko'? '이메일로 찾기': 'Email'}}</span>
													</label>
													
													<label for="search_way_phone" style="font-weight: bold;">
														<input type="radio" name="search_way" id="search_way_phone" ng-model="search_way" value="phone" tabindex=1 />
														<span>{{locale == 'ko'? '휴대폰로 찾기': 'Mobile'}}</span>
													</label>
												</div>
												<div>
													<div class="input_full fl_wrap input_email input_flex_row"  >
														<input type="text" name="person_id" ng-model="form_data.p_login_id" placeholder="{{locale == 'ko'? '아이디 입력하기': 'Input your ID' }}" tabindex=2 autofocus="autofocus" required/>
													</div>
													<div class="input_full input_email input_flex_row">
														<input type="text" name="person_name" ng-model="form_data.cust_name" placeholder="{{locale == 'ko'? '이름 입력하기': 'Input your name' }}" tabindex=3  required/>
													</div>
													<div ng-show="search_way == 'phone'" class="fl_wrap type02" >
														<div class="input_email input_flex_row" >
															<select id="Customer_phone" name="Customer_phone" ng-model="form_data.p_phone" style="margin-right: 0;" ng-required="search_way == 'phone'" tabindex=4 >        
																<option value="" selected>{{locale == 'ko'? '선택': 'Select'}}</option>
																<option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option> 
															</select>  
															<span class="tbl_label" style="margin-right: 0;">-</span>   
															<input type="text" id="Customer_phone2" name="p_phone2" ng-model="form_data.p_phone2" value="" class="tac" placeholder="{{locale == 'ko'? '앞자리': ''}}" maxlength=4  style="margin-right: 0; ime-mode:disabled;" ng-required="search_way == 'phone'" tabindex=5 />   
															<span class="tbl_label" style="margin-right: 0;">-</span>  
															<input type="text" id="Customer_phone3" name="p_phone3" ng-model="form_data.p_phone3" value="" class="tac" placeholder="{{locale == 'ko'? '뒷자리': ''}}" maxlength=4  style="margin-right: 0; ime-mode:disabled;" ng-required="search_way == 'phone'" tabindex=6 />  
														</div>
													</div>
													<div ng-show="search_way == 'email'" class="fl_wrap type02">
														<div class="input_email input_flex_row">
															<input type="text" name="p_email1" ng-model="form_data.p_email1" placeholder="{{locale == 'ko'? '이메일 앞부분': 'Email account'}}" tabindex=4 ng-required="search_way == 'email'"/>
															<span class="tbl_label">@</span>
															<input type="text" name="p_email2" ng-model="form_data.p_email2" placeholder="{{locale == 'ko'? '이메일 도메인': 'domain'}}" tabindex=5 ng-required="search_way == 'email'"/>
															<select name="p_email_select" ng-model="p_email_select" ng-change="form_data.p_email2=p_email_select;" tabindex=6 >
																<option value="" >{{locale == 'ko'? '선택하기': 'Select'}}</option> 
																<option value="naver.com">naver.com</option>
																<option value="nate.com">nate.com</option>
																<option value="gmail.com">gmail.com</option>
																<option value="daum.net">daum.net</option>
																<option value="hanmail.net">hanmail.net</option>
																<option value="hotmail.com">hotmail.com</option>
															</select>
														</div>
													</div>
													<div class="btn_wrap">
														<span class="btn_style01 green02 xlarge">
															<button type="submit" ng-click="searchPasswd();" ng-disabled="checkSendMail">
																<span ng-show="!checkSendMail">{{locale == 'ko'? '비밀번호 찾기': 'Find your password'}}</span>
																<span ng-show="checkSendMail">메일 발송 중..</span>
															</button>
														</span>
													</div>
												</div>
											</div>
										</form>	
									</div>
								</div>
							</fieldset>
						</div>						
						
						<div class="box_style01 mt30 pwContainer" ng-if="locale != 'en'">
							<div class="list_style02">
								<ul>
									<li ng-if="locale != 'en'">
										해외 국적으로 가입하신 회원은 서울옥션 영문홈페이지를 이용해주세요.<br />
										Please, foreigners use English pages.
									</li>
								</ul>
							</div>
							<span class="btn_style01" ng-if="locale != 'en'"><a href="/login/?lang=en">Seoul Auction ENG</a></span>
							<!--<p class="eng">Members who join the foreign nationality, please use the Seoul Auction English website.</p>
							<span class="btn_style01"><a href="/eng/login">Seoul Auction ENG</a></span>-->
						</div>

						<!-- 결과 -->
						<div id="pwResultContainer" class="box_style02" style="display:none;">
							<div class="bg_img bg28">
								<p class="txt_style02">입력하신 <strong id="pwResultEmail" class="txt_green"></strong> 으로 임시 비밀번호가 발송되었습니다. </p>
								<p class="lh20"><strong>로그인 후 회원정보수정에서 비밀번호를 재설정</strong>하여 주시기 바랍니다.</p>
								<div class="btn_wrap border">
									<span class="btn_style01 green02 xlarge"><a href="/login">로그인</a></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>