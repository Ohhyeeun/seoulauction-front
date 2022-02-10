<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
						<input type="hidden" name="marketing_chk" ng-model="form_data.marketing_chk" />
						<tr>
							<th scope="row">
								<label for=""><spring:message code="label.Id" /></label>
								<span class="ico_essen"><span class="hidden">필수입력</span></span>
							</th>
							<td>
								<div class="fl_wrap">
									<div class="input_id">
									
										<span ng-if = "!is_login">
											<input type="text" name="login_id" ng-model="form_data.login_id" ng-pattern="/^[A-Za-z0-9]{6,14}$/" ng-change="initValidIdCheck();" ng-disabled="is_login" ng-style="getValidInput(joinForm.login_id.$valid && joinForm.checkId.$valid)" placeholder="<spring:message code="label.loginId" />" tabindex="1" required/>
										</span>
										<span ng-if = "is_login">
											<input type="text" name="login_id" ng-model="form_data.login_id" ng-disabled="is_login" ng-style="getValidInput(joinForm.login_id.$valid && joinForm.checkId.$valid)" placeholder="<spring:message code="label.loginId" />" tabindex="1" required/>
										</span>
										
										<span class="btn_style01 gray02" ng-hide="is_login">
											<button type="button" ng-click="checkExistId();" tabindex="2"><spring:message code="label.mem.01" /></button>
										</span>
										<p class="tbl_txt" ng-style="styleInvalid" ng-show="!joinForm.login_id.$valid && checkDupId.message == ''">
											<spring:message code="message.mem.id" />
										</p>
										<p class="tbl_txt" ng-style="styleInvalid" ng-show="joinForm.login_id.$valid && checkDupId.message == '' && !checkDupId.valid">
											<spring:message code="message.mem.02" />
										</p>
										<p class="tbl_txt" ng-style="checkDupId.valid ? styleValid : styleInvalid">
											{{checkDupId.message}}
										</p>
										<input type="hidden" name="checkId" ng-model="checkDupId.check" required />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for=""><spring:message code="label.password" /></label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap">
									<div class="input_password">
										<input type="password" ng-model="form_data.passwd" name="passwd" ng-pattern="/^[a-zA-Z0-9!@#$%^&*?_~]{4,}$/" ng-change="initValidPasswdCheck();"
											ng-style="getValidInput(joinForm.passwd.$valid && joinForm.checkPasswd.$valid)" placeholder="<spring:message code="label.putpassword" />" tabindex="3" required />
										<input type="password" ng-model="form_data.passwd2" name="passwd2" ng-style="getValidInput(joinForm.passwd.$valid && joinForm.checkPasswd.$valid)" 
											placeholder="<spring:message code="label.passwordre" />" ng-change="initValidPasswdCheck();" tabindex="4" required />
										<p class="tbl_txt" ng-style="styleInvalid" ng-show="!joinForm.passwd.$valid  && checkConfirmPwd.message == ''">
											<spring:message code="message.mem.password" />
										</p>
										<p class="tbl_txt" ng-style="styleInvalid" ng-show="joinForm.passwd.$valid && !isValidString(form_data.passwd2)">
											<spring:message code="message.mem.empassword" />
										</p>
										<p class="tbl_txt" ng-style="checkConfirmPwd.valid ? styleValid : styleInvalid" ng-show="isValidString(form_data.passwd2)">
											{{checkConfirmPwd.message}}
										</p>
										<p class="tbl_txt" ng-style="styleInvalid" ng-show="validChekForm && !joinForm.passwd.$valid">
											<!-- YBK. 20170206. 필수 항목입니다. 정확히 입력하세요. -->
											<!--<spring:message code="message.mem.03" />-->
										</p>
										<input type="hidden" name="checkPasswd" ng-model="checkConfirmPwd.check" required/>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<label ng-show="isPerson()"><spring:message code="label.mem.name" /></label>
								<label ng-show="!isPerson()">업체명</label>
								<span class="ico_essen"><span class="hidden">필수입력</span></span>
							</th>
							<td>
								<input type="text" ng-model="form_data.cust_name" name="cust_name" ng-style="getValidInput(joinForm.cust_name.$valid)"
									ng-disabled="is_login" placeholder="<spring:message code="label.mem.name" />" ng-style="" tabindex="5" required />
							</td>
						</tr>
						<tr ng-show="!isPerson()">
							<th scope="row"><label for="">사업자 등록번호</label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap">
									<input type="text" name="comp_no" ng-pattern="/^[0-9]{10}$/" ng-model="form_data.comp_no" ng-change="initValidCompNoCheck();" 
										ng-disabled="is_login" ng-style="getValidInput(joinForm.comp_no.$valid && joinForm.checkDupCompNo.$valid && joinForm.checkValidCompNo.$valid)" 
										onkeypress="return onlyNumber(event);" placeholder="- 없이 입력" tabindex="6"  ng-required="!isPerson()" />
									<!-- YBK. 로그인 시 중복확인 버튼 제거 -->
									<!--<span class="btn_style01 gray02" ng-hide="is_login"> //이렇게 하면 체크메시지까지 gray로 나옴-->
									<span ng-hide="is_login">
										<span class="btn_style01 gray02">
										<button type="button" ng-click="checkExistCompNo();" tabindex="7">중복확인</button>
										</span>
										<span class="tbl_txt" ng-style="styleInvalid" ng-show="(!joinForm.comp_no.$valid || !checkValidCompNo.valid) && checkDupCompNo.message == ''">
											유효하지 않은 사업자 등록 번호 입니다.
										</span>
										<span class="tbl_txt" ng-style="styleInvalid" ng-show="joinForm.comp_no.$valid && checkValidCompNo.valid && !checkDupCompNo.valid && checkDupCompNo.message == ''">
											유효한 사업자 등록 번호지만 중복체크가 필요합니다.
										</span>
										<span class="tbl_txt" ng-style="checkDupCompNo.valid ? styleValid : styleInvalid">
											{{checkDupCompNo.message}}
										</span>
										<input type="hidden" name="checkDupCompNo" ng-model="checkDupCompNo.check" ng-required="!is_login && !isPerson()" />
										<input type="hidden" name="checkValidCompNo" ng-model="checkValidCompNo.check" ng-required="!is_login && !isPerson()" />			
									</span>
								</div>
							</td>
						</tr>
						<tr ng-show="!isPerson()">
							<th scope="row"><label for="">대표자명</label></th>
							<td>
								<input type="text" ng-model="form_data.comp_owner" name="comp_owner" id="comp_owner" placeholder="대표자명 입력" tabindex="8">
							</td>
						</tr>
						<tr ng-show="!isPerson()">
							<th scope="row"><label for="">업무 담당자</label></th>
							<td><input type="text" ng-model="form_data.comp_man_name" name="comp_man_name" id="comp_man_name" placeholder="업무 담당자명 입력" tabindex="9" /></td>
						</tr>
						
						<!-- YBK_20170201_생년월일필드 -->
						<tr ng-show="isPerson()">
							<th scope="row">
								<label for=""><spring:message code="label.mem.birth" /></label>
<!-- 								<span class="ico_essen"><span class="hidden">필수입력</span></span> --> <!-- ios앱 등록으로 인해 일시적으로 필수값 해제 -->
							</th>
							<td>
								<div class="fl_wrap">
									<div class="input_birth">
										<input type="text" name="born_dt" ng-model="form_data.born_dt" ng-pattern="/[12][0-9]{3}[01][0-9][0-3][0-9]/" style="ime-mode:disabled" onkeypress="return onlyNumber(event);"
										ng-change="initValidBornCheck();" ng-style="getValidInput(joinForm.born_dt.$valid)" class="tac" maxlength="8" placeholder="yyyymmdd" tabindex="10"/> <!-- ng-required="isPerson()"   -->
										<%-- <p class="tbl_txt" ng-style="styleInvalid" ng-show="!joinForm.born_dt.$valid"> <!-- !joinForm.born_dt.$valid -->
											<spring:message code="message.mem.born" />	<!-- 유효성 오류 -->
										</p>				
										<p class="tbl_txt" ng-style="styleValid" ng-show="joinForm.born_dt.$valid"> <!-- joinForm.born_dt.$valid -->
											<spring:message code="message.mem.08" />	<!-- 유효성 검증 -->
										</p> --%>
									</div>
								</div>
							</td>
						</tr>
						<!-- YBK_20170201_생년월일필드 end -->
						
						<tr ng-show="isPerson()">
							<th scope="row">
								<label for=""><spring:message code="label.mem.gender" /></label>
<!-- 								<span class="ico_essen"><span class="hidden">필수입력</span></span> --> <!-- ios앱 등록으로 인해 일시적으로 필수값 해제 -->
							</th>
							<td>
								<div class="wrap_check">
									<div>
										<input type="radio" ng-model="form_data.sex_cd"  
											ng-style="getValidInput(joinForm.sex_cd.$valid)" name="sex_cd" value="male" tabindex="11" /> <!-- ng-required="isPerson()" ng-init="form_data.sex_cd='male'"  -->
										<label for="sex_cd_male"><spring:message code="label.mem.male" /></label>
									</div>
									<div>
										<input type="radio" ng-model="form_data.sex_cd" 
											ng-style="getValidInput(joinForm.sex_cd.$valid)" name="sex_cd" value="female" tabindex="12"  /><!-- ng-required="isPerson()"  -->
										<label for="sex_cd_female"><spring:message code="label.mem.female" /></label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for=""><spring:message code="label.mem.mobile" /></label><span class="ico_essen"  ng-if="locale == 'ko'"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone" ng-if="locale == 'ko'">
										<select ng-model="form_data.hp1" ng-change="changeHpValue();"
											ng-style="getValidInput(joinForm.hp1.$valid && checkHp.valid)"
											name="hp1" tabindex="13" ng-required="locale == 'ko'">
											<option value="" selected>선택</option>
											<option ng-repeat="hp in hp1s" value="{{hp}}">{{hp}}</option>
										</select>
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.hp2"
											ng-style="getValidInput(joinForm.hp2.$valid && checkHp.valid)" 
											onkeypress="return onlyNumber(event);" ng-change="changeHpValue();" 
											name="hp2" class="tac" placeholder="앞자리" maxlength=4 tabindex="14" ng-required="locale == 'ko'" />
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.hp3"
											ng-style="getValidInput(joinForm.hp3.$valid && checkHp.valid)" 
											onkeypress="return onlyNumber(event);" ng-change="changeHpValue();" 
											name="hp3" class="tac" placeholder="뒷자리" maxlength=4 tabindex="15" ng-required="locale == 'ko'"/>
											
											<!-- YBK_angularJS_if문 -->
											<span>	<!-- ng-show="!is_login"과 같은 기능,  ng-hide="!is_login" -->
												<!-- <span class="btn_style01 gray02" ng-change=""> -->
												<span class="btn_style01 gray02"><button type="button" ng-click="checkExistMobile(isPerson());">중복확인</button></span>
											</span>
											<!-- YBK_angularJS_if문 -->
						
										<p class="tbl_txt" ng-style="checkHp.valid ? styleValid : styleInvalid">{{checkHp.message}}</p>
										
										<input type="hidden" name="checkHp" ng-model="checkHp.check" ng-required="locale == 'ko'" />
									</div>
									<div class="input_phone" ng-if="locale == 'en'">
										<input type="text" name="hp" ng-model="form_data.hp" class="tac"
											ng-style="getValidInput(joinForm.hp.$valid)"
											style="width:150px;" placeholder="Number only with Country Code" 
											> <!-- ng-required="locale == 'en'" -->
									</div><!-- ng-pattern="/^[0][1][016789]\d{3,4}\d{4}$/" -->
								</div>
							</td>
						</tr>
						 <tr ng-if="locale == 'ko' && checkHp.valid">
							<th scope="row"><label for="">휴대폰 인증</label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone_auh">
										<span  ng-if="!checkHpAuth.valid" class="btn_style01 gray02"><button type="button" ng-click="authNumRequest()">{{auth_req_btn_txt}}</button></span>
										<input ng-if="checkHp.valid && !checkHpAuth.valid" type="text" ng-model="form_data.auth_num" 
											ng-style="getValidInput(checkHpAuth.valid)"
										onkeypress="return onlyNumber(event);" class="tac" placeholder="인증번호" maxlength=6 />
										<span  ng-if="checkHp.valid && !checkHpAuth.valid" class="btn_style01 gray02"><button type="button" ng-click="authNumConfirm()">인증</button></span>
										<p class="tbl_txt" ng-style="checkHpAuth.valid ? styleValid : styleInvalid">{{getHpAuthMsg()}}</p>
										<input type="hidden" name="checkHpAuth" ng-model="checkHpAuth.check" ng-required="locale == 'ko'" />
									</div>
								</div>
							</td>
						</tr>
						
						<tr ng-if="locale == 'ko'">
							<th scope="row"><label for="">전화번호</label></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone">
										<select ng-model="form_data.tel1" name="tel1" id="tel1" tabindex="16">
											<option value="">선택</option>
											<option ng-repeat="tel in tel1s" value="{{tel}}">{{tel}}</option>
										</select>
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.tel2" onkeypress="return onlyNumber(event);" name="tel2" id="tel2" class="tac" placeholder="앞자리" maxlength=4 tabindex="17" />
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.tel3" onkeypress="return onlyNumber(event);" name="tel3" id="tel3" class="tac" placeholder="뒷자리" maxlength=4 tabindex="18" />
									</div>
								</div>
							</td>
						</tr>
						<tr ng-if="locale == 'ko'">
							<th scope="row"><label for="">팩스번호</label></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_phone">
										<select ng-model="form_data.fax1" name="fax1" id="fax1" tabindex="19">
											<option value="">선택</option>
											<option ng-repeat="fax in tel1s" value="{{fax}}">{{fax}}</option>
										</select>
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.fax2" onkeypress="return onlyNumber(event);" name="fax2" id="fax2" class="tac" placeholder="앞자리" maxlength=4 tabindex="20" />
										<span class="tbl_label">-</span>
										<input type="text" style="ime-mode:disabled" ng-model="form_data.fax3" onkeypress="return onlyNumber(event);" name="fax3" id="fax3" class="tac" placeholder="뒷자리" maxlength=4 tabindex="21" />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for=""><spring:message code="label.mem.email" /></label><span class="ico_essen"><span class="hidden">필수입력</span></span></th>
							<td>
								<div class="fl_wrap type02">
									<div class="input_email">
										<input type="text" ng-model="form_data.email1" name="email1" onkeyup="characterCheck(this)" 
											ng-style="getValidInput(joinForm.email1.$valid)"
										placeholder="<spring:message code="label.mem.email01" />" tabindex="22" required/>
										<span class="tbl_label">@</span>
										<input type="text" ng-model="form_data.email2" ng-disabled="locale=='ko'? isDisable : false" onkeyup="characterCheck(this)"  
											name="email2" 
											ng-style="getValidInput(joinForm.email2.$valid)"
										placeholder="<spring:message code="label.mem.email02" />" tabindex="23" required />
										<select ng-model="email_select" ng-show="locale == 'ko'" name="email_dom" id="email_dom"  ng-change="changeDomain(email_select);" tabindex="24">
											<option value="" selected disabled hidden>선택하기</option>
											<option value="userinput" >직접입력</option>
											<option ng-repeat="email in emails" value="{{email}}">{{email}}</option>
										</select>
										<span class="btn_style01 gray02" ng-show="locale == 'en'"><button type="button" ng-click="checkExistEmail();"><spring:message code="label.mem.02" /></button></span>
										<span class="tbl_txt" ng-style="checkDupEmail.valid ? styleValid : styleInvalid">{{checkDupEmail.message}}</span>
										<input type="hidden" name="checkDupEmail" ng-model="checkDupEmail.check" />
									</div>
								</div>
                                <div class="fl_wrap" ng-if="locale == 'en'" style="padding-top:10px; line-height:20px;">※ After application. In order to enjoy all of the benefits of your online account, please complete a one-time validation of your email address.</div>
							</td>
						</tr>
						<tr ng-if="locale == 'en'">
							<th scope="row"><label for="">Country</label><span class="ico_essen"><span class="hidden">required input</span></span></th>
								<td>
									<div class="fl_wrap type02">
										<div class="input_country">
											<select ng-model="form_data.nation_cd" name="nation_cd" ng-required="locale == 'en'"
												ng-style="getValidInput(joinForm.nation_cd.$valid)">
												<option value="">Select your country</option>
												<option ng-repeat="code in codeList | filter:{GRP_ID:'nation'}:true" value="{{code.CD_ID}}">{{"CD_NM" | localeValue : code}}</option>
											</select>
										</div>
									</div>
								</td>
							</tr>
						<tr>
							<th scope="row">
								<label for=""><spring:message code="label.mem.address" /></label>
								<span class="ico_essen"><span class="hidden">필수입력</span></span>
							</th>
							<td>
								<div class="fl_wrap" ng-if="locale=='ko'">
									<div class="input_zip">
										<!-- YBK. 20170207. 기존소스
										<input type="text" disabled="disabled" ng-model="form_data.zipno" ng-style="getValidInput(joinForm.zipno.$valid)" class="zip_input" placeholder="우편번호" tabindex="25" onkeypress="return onlyNumber(event);">
										YBK. 20170207. 기존소스 -->
										<input type="text" disabled="disabled" ng-model="form_data.zipno" class="zip_input" placeholder="우편번호" tabindex="25" onkeypress="return onlyNumber(event);">	
										<span class="btn_style01 gray02 btn_modal pop04">
											<button type="button" ng-click="showAddressFinderPopup({'parent':this, 'return_function':setHomeAddr});" tabindex="27">주소검색</button>
										</span>
										<p class="tbl_txt">※ 주소를 입력해주세요.</p>
									</div>
								</div>
								
								<div class="fl_wrap" ng-if="locale=='en'">
									<input type="text" name="zipno" ng-model="form_data.zipno" ng-style="getValidInput(joinForm.zipno.$valid)" 
									class="zip_input" placeholder="Postal Code" ng-required="locale=='en'">
								</div>
								
								<div class="input_full first">
									<input type="text" ng-model="form_data.addr" name="addr" 
										ng-style="getValidInput(joinForm.addr.$valid)" placeholder="<spring:message code="label.mem.addressline1" />" class="base_addr" tabindex="28" required ng-disabled="locale == 'ko'"/>
								</div>
								<div class="input_full">
									<input type="text" ng-model="form_data.addr_dtl" name="addr_dtl" placeholder="<spring:message code="label.mem.addressline2" />" class="detail_addr" tabindex="29" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for=""><spring:message code="label.mem.address01" /></label></th>
							<td>
								<div class="wrap_check zip">
									<div>
										<label>
											<input type="checkbox" ng_model="same_addr.val" ng-change="checkSameAddr();"  tabindex="30"/>
										<spring:message code="label.mem.address02" /></label>
									</div>
								</div>
								<div class="fl_wrap" ng-if="locale=='ko'">
									<div class="input_zip">
										<input type="text" disabled="disabled" ng-model="form_data.deli_zipno" class="zip_input" placeholder="우편번호" onkeypress="return onlyNumber(event);">
										<span class="btn_style01 gray02 btn_modal pop04"><button type="button" ng-click="showAddressFinderPopup({'parent':this, 'return_function':setDeliAddr});" tabindex="33">주소검색</button></span>
									</div>
								</div>
								<div ng-if="locale=='en'">
									<input type="text" ng-model="form_data.deli_zipno" class="zip_input" placeholder="Postal Code" onkeypress="return onlyNumber(event);">
								</div>
								<div class="input_full">
									<input type="text" ng-model="form_data.deli_addr" name="deli_addr" id="deli_addr" placeholder="<spring:message code="label.mem.addressline1" />" class="base_addr" tabindex="34" value="{{deli_addr}}" ng-disabled="locale == 'ko'"/>
								</div>
								<div class="input_full">
									<input type="text" ng-model="form_data.deli_addr_dtl" name="deli_addr_dtl" id="deli_addr_dtl" placeholder="<spring:message code="label.mem.addressline2" />" class="detail_addr" tabindex="35"  value="{{deli_addr_dtl}}"/>
								</div>
							</td>
						</tr>
						<tr ng-if="(!is_login && locale=='en') || (is_login && form_data.local_kind_cd=='foreigner')">
							<th scope="row" style="background-color:#FF9"><label for=""><spring:message code="label.mem.auctionin" /></label></th>
							<td>
								<div class="wrap_check">
									<div>
										<input type="radio" ng-model="form_data.fore_bid_req_yn" 
											name="fore_bid_req_yn" value="Y" tabindex="40" />
										<label>Yes</label>
									</div>
									<div>
										<input type="radio" ng-model="form_data.fore_bid_req_yn" 
											name="fore_bid_req_yn" value="N" tabindex="41" />
										<label>No</label>
									</div>
                                </div>   
                                <div class="fl_wrap"> 
                                    <div style="padding-left:10px; line-height:20px;">
                                        * To be able to participate in online auctions, you must check “Yes” under “Bidding Registration” when applying for membership.<br/>
                                        * The bidding button will become available for use one or two business days after selecting “Yes.”<br/>
                                        * If the bidding button does not become available, please send an email inquiry to info@seoulauction.com.<br/>
                                        * If you register for membership near the closing time of an auction and make an email or phone inquiry related to bidding, Seoul Auction will provide all necessary assistance.<br/>
									</div>
								</div>
							</td>
						</tr>
