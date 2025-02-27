<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="esapi" uri="http://www.owasp.org/index.php/Category:OWASP_Enterprise_Security_API" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
	<title>EUSurvey - <spring:message code="label.Properties" /></title>	
	<%@ include file="../includes.jsp" %>	
	<link href="${contextpath}/resources/css/fileuploader.css?version=<%@include file="../version.txt" %>" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextpath}/resources/js/fileuploader.js?version=<%@include file="../version.txt" %>"></script>
	<script type='text/javascript' src='${contextpath}/resources/js/knockout-3.5.1.js?version=<%@include file="../version.txt" %>'></script>
	
	<jsp:include page="propertiesHead.jsp" />
</head>
<body data-spy="scroll" data-target="#navbar-example" data-offset="400">
<div class="page-wrap">

	<jsp:include page="../header.jsp" />
	<jsp:include page="../menu.jsp" />
	<jsp:include page="formmenu.jsp" />
	
	<div id="propertiespage" class="fullpageform" style="padding-top:190px;">		
		<form:form id="save-form" style="width: 730px; margin-left: auto; margin-right: auto;" method="POST" action="${contextpath}/${sessioninfo.shortname}/management/properties?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data" modelAttribute="form">
			<form:hidden path="survey.id" />
			<input type="hidden" id="survey-security" name="survey.security" value="" />
			
			<div class="actions">
				<div style="width: 950px; margin-left: auto; margin-right: auto;">
					<div style="float: left">
						<a onclick="checkPropertiesAndSubmit(false, false);" class="btn btn-primary" style="margin-top: 2px; margin-left: 1px;"><spring:message code="label.Save" /></a>
					</div>
						
					<div style="width: auto;">			
						 <nav class="navbar navbar-default" id="navbar-example" style="width: 730px;">	
						    <ul class="nav nav-tabs scrolltabs" role="tablist">
						      <li class="active"><a href="#basic"><spring:message code="label.Basic" /></a></li>
						      <li><a href="#advanced"><spring:message code="label.Advanced" /></a></li>
						      <li><a href="#security"><spring:message code="label.Security" /></a></li>
						      <li><a href="#appearance"><spring:message code="label.Appearance" /></a></li>
						      <li><a href="#publishresults"><spring:message code="label.PublishResults" /></a></li>
						      <li><a href="#specialpages"><spring:message code="label.SpecialPages" /></a></li>
						      <li><a href="#type"><spring:message code="label.Type" /></a></li>						      
						    </ul>			
						</nav>				
					</div>
				</div>
			</div>
	
			<div class="propertiesbox">
				<a class="anchor" id="basic"></a>
				<label><spring:message code="label.Basic" /></label>
				<table class="table table-bordered">
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.Alias" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
							</div>
							<div style="float: right; max-width: 500px;">
								<form:input id="edit-survey-shortname" type="text" maxlength="255" class="form-control required freetext max255" path="survey.shortname" />
							</div>
							<div style="clear: both"></div>
							<div class="help" style="display: none; margin-top: 10px;">
								<span><spring:message code="message.MeaningfulShortnameNew" /></span>	
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.Title" />
							</div>
							<div style="float: right">
								<div class="preview">${form.survey.title} <a class="iconbutton" onclick="$('#tinymcetitle').show();$(this).closest('.preview').hide()" style="margin-left: 10px;"><span class="glyphicon glyphicon-pencil"></span></a></div>
								<div id="tinymcetitle" style="display: none">
									<form:textarea class="tinymcealign required xhtml" id="edit-survey-title" path="survey.title"></form:textarea>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.MainLanguage" />
							</div>
							<div style="float: right">
								<form:select path="survey.language" class="form-control required" style="width: auto;">
									<c:forEach items="${form.survey.completeTranslations}" var="language">				
										<c:choose>
											<c:when test="${form.survey.language.code.equals(language)}">
												<form:option selected="selected" value="${language}"><esapi:encodeForHTML>${language}</esapi:encodeForHTML></form:option>
											</c:when>
											<c:otherwise>
												<form:option value="${language}"><esapi:encodeForHTML>${language}</esapi:encodeForHTML></form:option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</form:select>		
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.Contact" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
							</div>
							<div style="float: right">
								<div style="float:left; text-align: right;">
									<select class="form-control" data-bind="value: contactType" id="survey-contact-type" style="width: auto;">
										<option value="form"><spring:message code="label.ContactForm" /></option>
										<option value="email"><spring:message code="label.Email" /></option>
										<option value="url"><spring:message code="label.Webpage" /></option>								
									</select><br />
									<div id="survey-contact-label-label" data-bind="visible: contactType() == 'url'" style="font-weight: bold; margin-top: 5px;"><spring:message code="label.Label" /></div>
								</div>
								<div style="float:left; margin-left: 10px">
									<form:input htmlEscape="false" path="survey.contact" class="form-control required email" type="text" maxlength="255" style="width: 300px;" /><br />
									<form:input data-bind="visible: contactType() == 'url'" htmlEscape="false" path="survey.contactLabel" type="text" class="form-control" style="width: 300px" maxlength="255"  />
								</div>								
							</div>
							<div style="clear: both"></div>
							<div class="help" style="display: none;">
								<span><spring:message code="message.Contact" /></span>	
							</div>
						</td>
					</tr>			
				</table>
			</div>
			
			<div class="propertiesbox">
				<a class="anchor" id="advanced"></a>
				<label><spring:message code="label.Advanced" /></label>
				<table class="table table-bordered">
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AutomaticSurveyPublishing" />
							</div>
							<div style="float: right">
								<c:choose>
									<c:when test="${form.survey.isOPC}">
										<div class="onoffswitch">
											<input data-bind="checked: automaticPublishing; enabled: false" type="checkbox" name="survey.automaticPublishing" class="onoffswitch-checkbox" id="myonoffswitch" />
											 <label class="onoffswitch-label" for="myonoffswitch">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</div>
										<form:hidden path="survey.automaticPublishing" />
									</c:when>
									<c:otherwise>
										<div class="onoffswitch">
											<input data-bind="checked: automaticPublishing" type="checkbox" name="survey.automaticPublishing" class="onoffswitch-checkbox" id="myonoffswitch" />
											 <label class="onoffswitch-label" for="myonoffswitch">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</div>
									</c:otherwise>
								</c:choose>	
							</div>
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: automaticPublishing">
						<td>
							<div style="float: left">
								<span class="hideme mandatory autopub">*</span><spring:message code="label.StartDate" />
							</div>
							<div style="float: right">
								<div class="input-group">
									<div class="input-group-addon" onclick="$(this).parent().find('.datepicker').datepicker('show');">
										<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>										
									</div>			
									<form:input path="survey.start" maxlength="10" style="padding-left: 5px; width: 100px; height: 30px; margin-right: 10px;" class="hourselector datepicker date"/>	
								
									<form:select path="startHour" style="width: auto; height: 30px;">
										<form:option value="0">0:00</form:option>
										<form:option value="1">1:00</form:option>
										<form:option value="2">2:00</form:option>
										<form:option value="3">3:00</form:option>
										<form:option value="4">4:00</form:option>
										<form:option value="5">5:00</form:option>
										<form:option value="6">6:00</form:option>
										<form:option value="7">7:00</form:option>
										<form:option value="8">8:00</form:option>
										<form:option value="9">9:00</form:option>
										<form:option value="10">10:00</form:option>
										<form:option value="11">11:00</form:option>
										<form:option value="12">12:00</form:option>
										<form:option value="13">13:00</form:option>
										<form:option value="14">14:00</form:option>
										<form:option value="15">15:00</form:option>
										<form:option value="16">16:00</form:option>
										<form:option value="17">17:00</form:option>
										<form:option value="18">18:00</form:option>
										<form:option value="19">19:00</form:option>
										<form:option value="20">20:00</form:option>
										<form:option value="21">21:00</form:option>
										<form:option value="22">22:00</form:option>
										<form:option value="23">23:00</form:option>
									</form:select>									
								</div>
							</div>					
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: automaticPublishing">
						<td>
							<div style="float: left">
								<span class="hideme mandatory autopub">*</span><spring:message code="label.ExpiryDate" />
							</div>
							<div style="float: right">
								<div class="input-group">
									<div class="input-group-addon" onclick="$(this).parent().find('.datepicker').datepicker('show');">
										<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>										
									</div>						
									<form:input path="survey.end" maxlength="10" style="padding-left: 5px; width: 100px; height: 30px; margin-right: 10px;" class="datepicker hourselector date"/>	
									<form:select path="endHour" style="width: auto; height: 30px;">
										<form:option value="0">0:00</form:option>
										<form:option value="1">1:00</form:option>
										<form:option value="2">2:00</form:option>
										<form:option value="3">3:00</form:option>
										<form:option value="4">4:00</form:option>
										<form:option value="5">5:00</form:option>
										<form:option value="6">6:00</form:option>
										<form:option value="7">7:00</form:option>
										<form:option value="8">8:00</form:option>
										<form:option value="9">9:00</form:option>
										<form:option value="10">10:00</form:option>
										<form:option value="11">11:00</form:option>
										<form:option value="12">12:00</form:option>
										<form:option value="13">13:00</form:option>
										<form:option value="14">14:00</form:option>
										<form:option value="15">15:00</form:option>
										<form:option value="16">16:00</form:option>
										<form:option value="17">17:00</form:option>
										<form:option value="18">18:00</form:option>
										<form:option value="19">19:00</form:option>
										<form:option value="20">20:00</form:option>
										<form:option value="21">21:00</form:option>
										<form:option value="22">22:00</form:option>
										<form:option value="23">23:00</form:option>
									</form:select>
								</div>
							</div>
						</td>
					</tr>
					<tr data-bind="visible: automaticPublishing, attr:{class: endNotifications() ? 'subelement nobottomborder' : 'subelement'}">
						<td>
							<div style="float: left">
								<spring:message code="label.Reminder" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>								
							</div>
							<div style="float: right; text-align: right">															
								<!-- <div class="onoffswitch">
									<input type="checkbox" data-bind="checked: endNotifications" name="notification" class="onoffswitch-checkbox" id="myonoffswitchnotification">
									 <label class="onoffswitch-label" for="myonoffswitchnotification">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div> -->
								
								<div class="form-inline" style="margin-bottom: 5px;">
									 <div class="form-group">
										<form:select class="form-control" path="survey.notificationValue" style="width: auto;">
											<form:option value="-1"><spring:message code="label.none" /></form:option>
											<c:forEach var="i" begin="1" end="30">
												<form:option value="${i}"><c:out value="${i}"/></form:option>
											</c:forEach>
										</form:select>	
									</div>
									 <div class="form-group">
										<form:select class="form-control" path="survey.notificationUnit" style="width: auto;">
											<form:option value="-1"><spring:message code="label.none" /></form:option>
											<form:option value="0"><spring:message code="label.hours" /></form:option>
											<form:option value="1"><spring:message code="label.days" /></form:option>
											<form:option value="2"><spring:message code="label.weeks" /></form:option>
											<form:option value="3"><spring:message code="label.months" /></form:option>
										</form:select>
									</div>
									<spring:message code="label.before" />
								</div>	
								<!--<form:radiobutton class="check" path="survey.notifyAll" value="true"/><spring:message code="label.AllFormManagers" />&#160;
								<form:radiobutton class="check" path="survey.notifyAll" value="false"/><spring:message code="label.FormCreatorOnly" />-->
							</div>
							<div style="clear: both"></div>
							<div class="help hideme"><spring:message code="info.Reminder" /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AutomaticConfirmationEmail" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.AutomaticConfirmationEmail" /></div>
							</div>
							<div style="float: right">
								<div class="onoffswitch">
									<form:checkbox path="survey.sendConfirmationEmail" data-bind="checked: sendConfirmationEmail" class="onoffswitch-checkbox" id="myonoffswitchSendConfirmationEmail" />
									 <label class="onoffswitch-label" for="myonoffswitchSendConfirmationEmail">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>	
					<tr>
						<td>
							<div style="float: left; max-width: 500px;">
								<spring:message code="label.UseMaxNumberContribution" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.MaxNumberContributions" /></div>
							</div>
							<div style="float: right; text-align: right">										
								<div class="onoffswitch">
									<form:checkbox path="survey.isUseMaxNumberContribution" data-bind="checked: isUseMaxNumberContribution" class="onoffswitch-checkbox" id="myonoffswitchlimitmaxcont" />
									 <label class="onoffswitch-label" for="myonoffswitchlimitmaxcont">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
								<br>							
							</div>
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: isUseMaxNumberContribution">
						<td>
							<div style="float: left; max-width: 500px;">						
								<spring:message code="label.MaxNumberContributions" />
							</div>
							<div style="float: right; text-align: right">
								<div>
									<input id='maxContributionInput' class="form-control number max1000000000" type='number' name='survey.maxNumberContribution' min='0' max='1000000000' value="<esapi:encodeForHTMLAttribute>${form.survey.maxNumberContribution}</esapi:encodeForHTMLAttribute>">
								</div>
							</div>
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: isUseMaxNumberContribution">
						<td>
							<div style="float: left; max-width: 500px;">
								<spring:message code="label.MaxNumberContributionText" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.MaxNumberContributionText" /></div>
							</div>
							<div style="float: right; text-align: right">
								<form:radiobutton data-bind="click: function() {isUseMaxNumberContributionLink(false); return true;}" class="check" path="survey.isUseMaxNumberContributionLink" value="false"/><spring:message code="label.Text" />&nbsp;		
								<form:radiobutton data-bind="click: function() {isUseMaxNumberContributionLink(true); return true;}" class="check" path="survey.isUseMaxNumberContributionLink" value="true"/><spring:message code="label.Link" />
				
								<div data-bind="hidden: isUseMaxNumberContributionLink">						
									<div class="preview">${form.survey.maxNumberContributionText} <a class="iconbutton" onclick="$('#tinymcelimit').show();$(this).closest('.preview').hide()" style="margin-left: 10px;"><span class="glyphicon glyphicon-pencil"></span></a></div>
									<div id="tinymcelimit" style="display: none">
										<form:textarea maxlength="255" class="tinymcealign required xhtml max255" id="edit-survey-max-result-page" path="survey.maxNumberContributionText"></form:textarea>
									</div>
								</div>	
								
								<div data-bind="visible: isUseMaxNumberContributionLink">
									<form:input htmlEscape="false" path="survey.maxNumberContributionLink" type="text" class="form-control" style="display: inline-block" />
								</div>
							</div>
						</td>
					</tr>		
					<tr>
						<td>
							<div style="float: left; max-width: 500px;">
								<spring:message code="label.CreateContacts" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.ContactsCreated" /></div>
							</div>	
							<div style="float: right; text-align: right">
								<div class="onoffswitch">
									<form:checkbox path="survey.registrationForm" class="onoffswitch-checkbox" id="myonoffswitchnregform" />
									 <label class="onoffswitch-label" for="myonoffswitchnregform">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.UsefulLinks" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.UsefulLinks" /></div>				
							</div>
						
							<div style="float: right">
														
								<table data-bind="visible: showUsefulLinks" class="table table-bordered" id="usefullinkstable" style="width: 500px">
									<tr>
										<td><spring:message code="label.Label" /></td>
										<td><spring:message code="label.URL" /></td>
										<td style="width: 40px;">
											<a data-toggle="tooltip" title="<spring:message code="label.AddUsefulLink" />" class="btn btn-default btn-xs" data-bind="click: addLinksRow"><span class="glyphicon glyphicon-plus"></span></a>
										</td>
									</tr>
									<c:forEach var="link" items="${form.survey.getAdvancedUsefulLinks()}" varStatus="rowCounter">
										<tr class="usefullink">
											<td>
												<input class="form-control xhtml freetext max250" style="width: 180px" type="text" maxlength="250" name="linklabel${rowCounter.index}" value="<esapi:encodeForHTMLAttribute>${link.key}</esapi:encodeForHTMLAttribute>" />
											</td>
											<td>
												<input type="text" class="form-control targeturl" style="width: 180px" maxlength="255" name="linkurl${rowCounter.index}" value="<esapi:encodeForHTMLAttribute>${link.value}</esapi:encodeForHTMLAttribute>" />
											</td>
											<td style="vertical-align: middle">
												<a data-toggle="tooltip" title="<spring:message code="label.RemoveUsefulLink" />" class="btn btn-default btn-xs"  onclick="_properties.removeLinksRow(this)"><span class="glyphicon glyphicon-remove"></span></a>
											</td>
										</tr>
									</c:forEach>										
								</table>
								
								<a data-bind="visible: !showUsefulLinks(), click: addLinksRow" data-toggle="tooltip" title="<spring:message code="label.AddUsefulLink" />" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-plus"></span></a>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.BackgroundDocuments" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.BackgroundDocuments" /></div>
							</div>
							<div style="float: right">
								<table data-bind="visible: showBackgroundDocs" class="table table-bordered" id="backgrounddocumentstable" style="width: 500px">
									<tr>
										<td><spring:message code="label.Label" /></td>
										<td><spring:message code="label.Document" /></td>
										<td style="width: 40px">
											<a data-toggle="tooltip" title="<spring:message code="label.AddBackgroundDocument" />" class="btn btn-default btn-xs"  data-bind="click: addDocRow"><span class="glyphicon glyphicon-plus"></span></a>
										</td>
									</tr>
									<c:forEach var="link" items="${form.survey.getBackgroundDocumentsAlphabetical()}" varStatus="rowCounter">
										<tr>
											<td>
												<input class="xhtml freetext max250" type="text" maxlength="250" name="doclabel${rowCounter.index}" value="<esapi:encodeForHTMLAttribute>${link.key}</esapi:encodeForHTMLAttribute>" />
											</td>
											<td>
												<div style="word-wrap: break-word; max-width: 200px;">
													<a href="<esapi:encodeForHTMLAttribute>${link.value}</esapi:encodeForHTMLAttribute>">${form.survey.getFileNameForBackgroundDocument(link.key)}</a>
												</div>
												<input type="hidden" name="docurl${rowCounter.index}" value="<esapi:encodeForHTMLAttribute>${link.value}</esapi:encodeForHTMLAttribute>" />
											</td>
											<td style="vertical-align: middle">
												<a data-toggle="tooltip" title="<spring:message code="label.RemoveBackgroundDocument" />" class="btn btn-default btn-xs" onclick="_properties.removeDocRow(this);"><span class="glyphicon glyphicon-remove"></span></a>
											</td>
										</tr>
									</c:forEach>										
								</table>
								
								<a data-bind="visible: !showBackgroundDocs(), click: addDocRow" data-toggle="tooltip" title="<spring:message code="label.AddBackgroundDocument" />" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-plus"></span></a>
							</div>
						</td>
					</tr>					
				</table>
			</div>		
			
			<div class="propertiesbox">
				<a class="anchor" id="security"></a>
				<label><spring:message code="label.Security" /></label>
				<table class="table table-bordered">
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.SecureYourSurvey" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
							</div>
							<div style="float: right">
								<div class="onoffswitch">
									<c:choose>
										<c:when test='${form.survey.isOPC}'>
											<input data-bind="checked: secured" type="checkbox" disabled name="radio-new-survey-security" class="onoffswitch-checkbox" id="myonoffswitchsecured">
											<label class="onoffswitch-label disabled" for="myonoffswitchsecured">
												<span class="onoffswitch-inner"></span>
								    			<span class="onoffswitch-switch"></span>
								    		</label>
										</c:when>
										<c:otherwise>
											<input data-bind="checked: secured" type="checkbox" name="radio-new-survey-security" class="onoffswitch-checkbox" id="myonoffswitchsecured">
											<label class="onoffswitch-label" for="myonoffswitchsecured">
												<span class="onoffswitch-inner"></span>
								    			<span class="onoffswitch-switch"></span>
								    		</label>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div style="clear: both"></div>
							<div class="help hideme"><spring:message code="info.SecureYourSurveyNew" /></div>
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: secured">
						<td>
							<div style="float: left">
								<spring:message code="label.SecureWithPassword" />
							</div>
							<div style="float: right">
								<div id="edit-password">
									<c:choose>
										<c:when test='${form.survey.isOPC}'>
											<input class="form-control" type="text" maxlength="255" disabled="disabled" autocomplete="off" style="margin: 0px; width: 150px;" />
											<input class="check" type="checkbox" disabled="disabled" /><spring:message code="label.ShowPassword" />
										</c:when>
										<c:when test="${form.survey.password != null && form.survey.password.length() > 0}">
											<form:password class="form-control" maxlength="255" autocomplete="off" value="********" path="survey.password" style="margin: 0px;" onchange="$('#clearpassword').val($(this).val())" />
											<input class="form-control" style="display: none; width: auto" type="text" maxlength="255" id="clearpassword" readonly="readonly" disabled="disabled" value="${form.survey.password}" />
											<input class="check" type="checkbox" onclick="checkShowPassword(this)" /><spring:message code="label.ShowPassword" />
										</c:when>
										<c:otherwise>
											<form:password class="form-control" maxlength="255" autocomplete="off" path="survey.password" style="margin: 0px;" onchange="$('#clearpassword').val($(this).val())" />
											<input class="form-control" style="display: none; width: auto" type="text" maxlength="255" id="clearpassword" readonly="readonly" disabled="disabled" />
											<input class="check" type="checkbox" onclick="checkShowPassword(this)" /><spring:message code="label.ShowPassword" />
										</c:otherwise>
									</c:choose>												
								</div>
							</td>
						</tr>
						<c:choose>
							<c:when test="${USER.getGlobalPrivilegeValue('ECAccess') > 0}">
								<tr class="subelement" data-bind="visible: secured, attr:{class: ecasSecurity() ? 'nobottomborder subelement' : 'subelement'}">
									<td>
										<div style="float: left">
											<spring:message code="label.SecureWithEULogin" />
										</div>
										<div style="float: right">
											<div class="onoffswitch">
												<c:choose>
													<c:when test='${form.survey.isOPC}'>	
														<input disabled="disabled" checked="checked" type="checkbox" name="survey.ecasSecurity" class="onoffswitch-checkbox" id="myonoffswitchecas" />
														<label class="onoffswitch-label disabled" for="myonoffswitchecas">
													        <span class="onoffswitch-inner"></span>
													        <span class="onoffswitch-switch"></span>
													    </label>
													</c:when>
													<c:otherwise>
														<input data-bind="checked: ecasSecurity" type="checkbox" name="survey.ecasSecurity" class="onoffswitch-checkbox" id="myonoffswitchecas" />
														<label class="onoffswitch-label" for="myonoffswitchecas">
													        <span class="onoffswitch-inner"></span>
													        <span class="onoffswitch-switch"></span>
													    </label>
													</c:otherwise>
												</c:choose>
												 
											</div>
										</div>
									</td>
								</tr>
								<tr class="subsubelement noborder" data-bind="visible: secured() && ecasSecurity()">
									<td>
										<div style="float: left">
											<spring:message code="label.Users" />
										</div>
										<div style="float: right">
											<c:choose>
												<c:when test='${form.survey.isOPC}'>
													<input type="radio" disabled="disabled" checked="checked" name="ecas-mode" class="check" /><spring:message code="label.everybody" /><br />
													<input type="radio" disabled="disabled" name="ecas-mode" class="check" /><spring:message code="label.EuropeanInstitutionsStaff" />
													<form:hidden path="survey.ecasMode" name="ecas-mode" />
												</c:when>
												<c:otherwise>
													<form:radiobutton path="survey.ecasMode" id="ecas-mode-all" name="ecas-mode" value="all" class="check" /><spring:message code="label.everybody" /><br />
													<form:radiobutton path="survey.ecasMode" id="ecas-mode-internal" name="ecas-mode" value="internal" class="check" /><spring:message code="label.EuropeanInstitutionsStaff" /><br />
												</c:otherwise>
											</c:choose>													
										</div>
									</td>
								</tr>
								<c:if test='${!form.survey.isOPC}'>
									<tr class="subsubelement noborder" data-bind="visible: secured() && ecasSecurity()">
										<td>
											<div style="float: left">
												<spring:message code="label.ContributionsPerUser" />
												<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
												<div class="help hideme"><spring:message code="info.ContributionsPerUser" /></div>
											</div>
											<div style="float: right">
												<form:input htmlEscape="false" path="survey.allowedContributionsPerUser" type="text" class="form-control spinner required number min1 integer" maxlength="10" style="width: 50px" />
											</div>
											<div style="clear: both"></div>																						
										</td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<tr style="display: none">
									<td>
										<form:hidden path="survey.ecasSecurity" id="enableecas" name="enableecas"  />						
										<form:hidden path="survey.ecasMode" name="ecas-mode" />
									</td>
								</tr>
							</c:otherwise>
					</c:choose>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AnonymousSurveyMode" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
							</div>						
							<div style="float: right">								
							
								<c:choose>
									<c:when test='${form.survey.isOPC}'>
										<div class="onoffswitch">
											<input type="checkbox" disabled="disabled" class="onoffswitch-checkbox" id="myonoffswitchprivacy" />									
											
											<label class="onoffswitch-label disabled" for="myonoffswitchprivacy">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
									    </div>
									</c:when>
									<c:when test='${haspublishedanswers != null && (form.survey.security.equals("openanonymous") || form.survey.security.equals("securedanonymous"))}'>
										<div class="onoffswitch">
											<input type="checkbox" disabled="disabled" class="onoffswitch-checkbox" checked="checked" id="myonoffswitchprivacy" />									
										
											<label class="onoffswitch-label disabled" for="myonoffswitchprivacy">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
									    </div>
									</c:when>
									<c:otherwise>
										<div class="onoffswitch">
											<c:choose>
												<c:when test='${form.survey.security.equals("openanonymous") || form.survey.security.equals("securedanonymous")}'>
													<input type="checkbox" checked="checked" name="radio-new-survey-privacy" class="onoffswitch-checkbox" id="myonoffswitchprivacy">
												</c:when>
												<c:otherwise>
													<input type="checkbox" name="radio-new-survey-privacy" class="onoffswitch-checkbox" id="myonoffswitchprivacy">
												</c:otherwise>
											</c:choose>		
											 <label class="onoffswitch-label" for="myonoffswitchprivacy">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</div>		
										</c:otherwise>
								</c:choose>											
															
							</div>
							<div style="clear: both"></div>
							<div class="help hideme"><spring:message code="info.AnonymousSurveyMode" /></div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.Captcha" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.CaptchaNew" /></div>
							</div>						
							<div style="float: right">		
								<div class="onoffswitch">
									<c:choose>
										<c:when test='${form.survey.isOPC}'>
											<input type="checkbox" disabled="disabled" class="onoffswitch-checkbox" id="myonoffswitchcaptcha" />									
											<form:hidden path="survey.captcha"/>
											<label class="onoffswitch-label disabled" for="myonoffswitchcaptcha">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</c:when>
										<c:otherwise>
											<form:checkbox path="survey.captcha" class="onoffswitch-checkbox" id="myonoffswitchcaptcha" />
											<label class="onoffswitch-label" for="myonoffswitchcaptcha">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</c:otherwise>
									</c:choose>	
									 
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AllowSaveAsDraft" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme">
									<!-- ko if: _properties.delphi() -->
									<spring:message code="info.AllowSaveAsDraftDelphi" />
									<!-- /ko -->
									<!-- ko ifnot: _properties.delphi() -->
									<spring:message code="info.AllowSaveAsDraft" />
									<!-- /ko -->
								</div>
							</div>						
							<div style="float: right">							
								<div class="onoffswitch">
									<form:checkbox path="survey.saveAsDraft" class="onoffswitch-checkbox" id="myonoffswitchdraft" data-bind="checked: _properties.saveAsDraft()"  />
									 <label class="onoffswitch-label" data-bind='class: "onoffswitch-label"+(_properties.delphi() ? " disabled" : "")' onclick="_properties.toggleSaveAsDraft()">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>		
						</th>
					</tr>
					
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AllowChangeContributionNew" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme">
									<!-- ko if: _properties.delphi() -->
									<spring:message code="info.AllowChangeContributionDelphi" />
									<!-- /ko -->
									<!-- ko ifnot: _properties.delphi() -->
									<spring:message code="info.AllowChangeContribution" />
									<!-- /ko -->
								</div>
							</div>						
							<div style="float: right">							
								<div class="onoffswitch">
									<form:checkbox path="survey.changeContribution" class="onoffswitch-checkbox" data-bind="checked: _properties.changeContribution()" />
									<label class="onoffswitch-label" data-bind='class: "onoffswitch-label"+(_properties.delphi() ? " disabled" : "")' onclick="_properties.toggleChangeContribution()">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>		
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AllowDownloadContributionPDFnew" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme">
									<!-- ko if: _properties.delphi() -->
									<spring:message code="info.AllowDownloadContributionPDFDelphi" />
									<!-- /ko -->
									<!-- ko ifnot: _properties.delphi() -->
									<spring:message code="info.AllowDownloadContributionPDFnew" />
									<!-- /ko -->
								</div>
							</div>						
							<div style="float: right">
								<div class="onoffswitch">
									<form:checkbox path="survey.downloadContribution" class="onoffswitch-checkbox" data-bind="checked: _properties.downloadContribution()" />
									 <label class="onoffswitch-label" data-bind='class: "onoffswitch-label"+(_properties.delphi() ? " disabled" : "")' onclick="_properties.toggleDownloadContribution()">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>		
						</td>
					</tr>
				</table>
			</div>
			
			<div class="propertiesbox">
				<a class="anchor" id="appearance"></a>
				<label><spring:message code="label.Appearance" /></label>
				<table class="table table-bordered">
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.MultiPaging" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="info.MultiPaging" /></div>	
							</div>						
							<div style="float: right">
								<div class="onoffswitch">
									<input type="checkbox" data-bind="checked: multiPaging" name="survey.multiPaging" class="onoffswitch-checkbox" id="myonoffswitchmultiPaging" />
									 <label class="onoffswitch-label" for="myonoffswitchmultiPaging">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>
					<tr class="subelement noborder" data-bind="visible: multiPaging">
						<td>
							<div style="float: left">
								<spring:message code="label.ValidatedInputPerPageNew" />
							</div>
							<div style="float: right">							
								<div class="onoffswitch">
									<form:checkbox path="survey.validatedPerPage" class="onoffswitch-checkbox" id="myonoffswitchvalidatedPerPage" />
									 <label class="onoffswitch-label" for="myonoffswitchvalidatedPerPage">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>	
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.AccessibilityMode" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
								<div class="help hideme"><spring:message code="help.AccessibilityMode" /></div>
							</div>
							<div style="float: right">							
								<div class="onoffswitch">
									<form:checkbox path="survey.wcagCompliance" class="onoffswitch-checkbox" id="myonoffswitchwcagCompliance" />
									 <label class="onoffswitch-label" for="myonoffswitchwcagCompliance">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>									
						</td>
					</tr>
					<tr class="nobottomborder">
						<td>
							<div style="float: left; max-width: 400px;">
								<spring:message code="label.Logo" />
								
								<div id="logo-cell" style="margin-left: 20px; margin-top: 20px;">
									<c:if test="${form.survey.logo != null}">
										<img src="<c:url value="/files/${form.survey.uniqueId}/${form.survey.logo.uid}" />" />
										<p><esapi:encodeForHTMLAttribute>${form.survey.logo.name}</esapi:encodeForHTMLAttribute></p>
									</c:if>
								</div>
							</div>
							<div style="float: right; text-align: right">
								
								<input type="hidden" name="logo" id="logo" />
					
								<a id="removelogobutton" style="margin-bottom: 10px" class="btn btn-default" <c:if test="${form.survey.logo == null}">style="display: none"</c:if> onclick="$(this).closest('td').find('img').remove();$(this).closest('td').find('p').remove(); $('#logo').val('deleted'); $(this).addClass('disabled').hide(); $('#file-uploader-area-div').hide();"><spring:message code="label.Remove" /></a>
								
								<div id="file-uploader-logo" style="margin-left: 90px;">
									<noscript>
									    <p>Please enable JavaScript to use file uploader.</p>
									</noscript>
								</div>
								<c:choose>
									<c:when test="${form.survey.logo != null}">
										<div id="file-uploader-area-div">
									</c:when>
									<c:otherwise>
										<div id="file-uploader-area-div" class="hideme">
									</c:otherwise>
								</c:choose>
							</div>										
						</td>
					</tr>
					<tr class="subelement noborder">
						<td>
							<div style="float: left">
								<spring:message code="label.LogoPosition" />
							</div>
							<div style="float: right">
								<form:radiobutton class="required check" path="survey.logoInInfo" value="true"/><spring:message code="label.inInformationArea" />&#160;
								<form:radiobutton class="required check" path="survey.logoInInfo" value="false"/><spring:message code="label.overTitle" />		
							</div>										
						</td>
					</tr>	
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.Skin" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>								
							</div>
							<div style="float: right">
								<select name="newskin" class="form-control" style="width: auto; display: inline-block">
									<option></option>
									<c:forEach items="${skins}" var="skin">
										<option value="${skin.id}" <c:if test="${form.survey.skin.id == skin.id}">selected="selected"</c:if>><esapi:encodeForHTML>${skin.displayName}</esapi:encodeForHTML></option>										
									</c:forEach>
								</select>
								<a href="${contextpath}/settings/skin" class="btn btn-default" style="margin-top: -2px;"><spring:message code="label.Manage" /></a>
							</div>
							<div style="clear: both"></div>
							<div class="help hideme"><spring:message code="help.Skin" /></div>							
						</td>
					</tr>	
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.SectionNumbering" />
							</div>
							<div style="float: right">
								<form:select path="survey.sectionNumbering" class="form-control required" style="width: 300px">
									<form:option value="0"><spring:message code="label.NoNumbering" /></form:option>
									<form:option value="1"><spring:message code="label.Numbers" /></form:option>
									<form:option value="2"><spring:message code="label.LettersLowerCase" /></form:option>
									<form:option value="3"><spring:message code="label.LettersUpperCase" /></form:option>
								</form:select>
							</div>											
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.QuestionNumbering" />
							</div>
							<div style="float: right">							
								<form:select path="survey.questionNumbering" class="form-control required" style="width: 300px">
									<form:option value="0"><spring:message code="label.NoNumbering" /></form:option>
									<form:option value="1"><spring:message code="label.Numbers" /></form:option>
									<form:option value="4"><spring:message code="label.Numbers" /> (<spring:message code="label.ignoreSections" />)</form:option>
									<form:option value="2"><spring:message code="label.LettersLowerCase" /></form:option>
									<form:option value="5"><spring:message code="label.LettersLowerCase" /> (<spring:message code="label.ignoreSections" />)</form:option>
									<form:option value="3"><spring:message code="label.LettersUpperCase" /></form:option>
									<form:option value="6"><spring:message code="label.LettersUpperCase" /> (<spring:message code="label.ignoreSections" />)</form:option>
								</form:select>
							</div>			
						</td>
					</tr>				
				</table>
			</div>
			
			<div class="propertiesbox">
				<a class="anchor" id="publishresults"></a>
				<label><spring:message code="label.PublishResults" /></label>
				<table class="table table-bordered">
					<tr>
						<td style="padding-bottom: 20px">
							<spring:message code="label.PublishingURLnew" />: 
							<a class="visiblelink" target="_blank" href="${serverprefix}publication/${form.survey.shortname}">${serverprefix}publication/${form.survey.shortname}</a>						
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.Publish" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.Publish" /></div>	
							</div>
							<div style="float: right; min-width: 150px;">	
								<form:checkbox id="showContent" path="survey.publication.showContent" class="check" /><spring:message code="label.Contributions" /><br />
								<form:checkbox id="showStatistics" path="survey.publication.showStatistics" class="check" /><spring:message code="label.Statistics" /><br />
								<form:checkbox path="survey.publication.showSearch" class="check hidden" /><!--<spring:message code="label.Search" /><br />-->
								<c:choose>
									<c:when test="${!form.survey.hasUploadElement}">
										<form:checkbox path="survey.publication.showUploadedDocuments" class="check hideme" />										
									</c:when>
									<c:otherwise>
										<form:checkbox path="survey.publication.showUploadedDocuments" class="check" /><spring:message code="label.UploadedDocuments" />
									</c:otherwise>
								</c:choose>
							</div>
						</td> 
					</tr>
					<tr data-bind="attr:{class: selectedQuestions() ? 'nobottomborder' : ''}">
						<td>
							<div style="float: left">
								<spring:message code="label.QuestionsToPublish" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.QuestionsToPublishNew" /></div>
							</div>
							<div style="float: right;  min-width: 150px;">	
								<form:radiobutton data-bind="click: function() {selectedQuestions(false); return true;}" path="survey.publication.allQuestions" value="true" id="questionsToPublishAll" class="check" name="questionsToPublish" /><spring:message code="label.AllQuestions" /><br />
								<form:radiobutton data-bind="click: function() {selectedQuestions(true); return true;}" path="survey.publication.allQuestions" value="false" class="check" name="questionsToPublish" /><spring:message code="label.Selection" /><br />
							</div>
						</td>
					</tr>
					<tr class="noborder" data-bind="visible: selectedQuestions">
						<td>
							<div style="float: right; max-width: 600px;">	
								<div id="questionsToPublishDiv" class="well scrollablediv">
									<table>
									<c:forEach items="${form.survey.getQuestions()}" var="question">
										<c:if test="${!question.getType().equals('Image') && !question.getType().equals('Text') && !question.getType().equals('Download')}">									
											<tr>
												<td>
													<input type="checkbox" class="check" name="question${question.id}" value="${question.id}" <c:if test="${form.survey.publication.isSelected(question.id)}">checked="checked"</c:if> />
												</td>
												<td>
													${question.title}
												</td>
											</tr>
										</c:if>																
									</c:forEach>
									</table>
								</div>
							</div>
						</td>
					</tr>
					<tr data-bind="attr:{class: selectedContributions() ? 'nobottomborder' : ''}">
						<td>
							<div style="float: left">
								<spring:message code="label.Contributions" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.ContributionsNew" /></div>	
							</div>
							<div style="float: right; min-width: 150px;">
								<form:radiobutton data-bind="click: function() {selectedContributions(false); return true;}" path="survey.publication.allContributions" value="true" onclick="checkSelections()" id="contributionsToPublishAll" class="check" name="contributionsToPublish" /><spring:message code="label.AllContributions" /><br />
								<form:radiobutton data-bind="click: function() {selectedContributions(true); return true;}" path="survey.publication.allContributions" value="false" onclick="checkSelections()" class="check" name="contributionsToPublish" /><spring:message code="label.Selection" /><br />
							</div>
						</td>
					</tr>
					<tr class="noborder" data-bind="visible: selectedContributions">
						<td>
							<div style="float: right; max-width: 600px;">	
								<div class="scrollablediv" id="contributionsToPublishDiv">
									<c:forEach items="${form.survey.getQuestions()}" var="question">
										<c:choose>
											<c:when test="${question.getType() == 'MultipleChoiceQuestion' || question.getType() == 'SingleChoiceQuestion'}">
												<div class="well">
													${question.title}
													<div>
														<c:forEach items="${question.possibleAnswers}" var="possibleanswer" varStatus="status">
															<input type="checkbox" class="check" name="contribution${question.id}|${question.uniqueId}" value="${possibleanswer.id}|${possibleanswer.uniqueId}" <c:if test="${form.survey.publication.filter.contains(question.id, question.uniqueId, possibleanswer.id, possibleanswer.uniqueId)}">checked="checked"</c:if> />${possibleanswer.title}<br />
														</c:forEach>
													</div>
												</div>
											</c:when>
										</c:choose>
									</c:forEach>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left"><spring:message code="label.Password" /></div>
							<div style="float: right">
								<c:choose>
									<c:when test="${form.survey.publication.password != null && form.survey.publication.password.length() > 0}">
										<form:password class="form-control" maxlength="255" autocomplete="off" value="********" path="survey.publication.password" style="margin: 0px;" onchange="$('#clearpublicationpassword').val($(this).val())" />
										<input class="form-control" style="display: none; width: auto" type="text" maxlength="255" id="clearpublicationpassword" readonly="readonly" disabled="disabled" value="${form.survey.publication.password}" />
										<input class="check" type="checkbox" onclick="checkShowPublicationPassword(this)" /><spring:message code="label.ShowPassword" />
									</c:when>
									<c:otherwise>
										<form:password class="form-control" maxlength="255" autocomplete="off" path="survey.publication.password" style="margin: 0px;" onchange="$('#clearpublicationpassword').val($(this).val())" />
										<input class="form-control" style="display: none; width: auto" type="text" maxlength="255" id="clearpublicationpassword" readonly="readonly" disabled="disabled" />
										<input class="check" type="checkbox" onclick="checkShowPublicationPassword(this)" /><spring:message code="label.ShowPassword" />
									</c:otherwise>
								</c:choose>
							</div>								
						</td>
					</tr>
				</table>
			</div>
			
			<div class="propertiesbox">
				<a class="anchor" id="specialpages"></a>
				<label><spring:message code="label.SpecialPages" /></label>
				<table class="table table-bordered">
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.ConfirmationPage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.ConfirmationPage" /></div>	
							</div>
							<div style="float: right; text-align: right;">
								<form:radiobutton onclick="_properties.useConfLink(false)" class="check" path="survey.confirmationPageLink" value="false"/><spring:message code="label.Text" />&#160;
								<form:radiobutton onclick="_properties.useConfLink(true)" id="conflink"  class="check" path="survey.confirmationPageLink" value="true"/><spring:message code="label.Link" />
								<br />
								<div data-bind="visible: !useConfLink()">
									<div class="preview">${form.survey.confirmationPage} <a class="iconbutton" onclick="$('#tinymceconfpage').show();$(this).closest('.preview').hide()"><span class="glyphicon glyphicon-pencil"></span></a></div>
									<div id="tinymceconfpage" style="display: none">
										<form:textarea class="tinymce required" path="survey.confirmationPage"></form:textarea>
									</div>		
								</div>
								<div data-bind="visible: useConfLink">	
									<form:input class="targeturl form-control" path="survey.confirmationLink" ></form:input>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<span class="mandatory">*</span><spring:message code="label.UnavailabilityPage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.UnavailabilityPage" /></div>	
							</div>
							<div style="float: right; text-align: right; max-width: 500px;">
								<form:radiobutton onclick="_properties.useEscapeLink(false)" class="check" path="survey.escapePageLink" value="false"/><spring:message code="label.Text" />&#160;
								<form:radiobutton onclick="_properties.useEscapeLink(true)"  id="esclink" class="check" path="survey.escapePageLink" value="true"/><spring:message code="label.Link" />
								<br />
								<div data-bind="visible: !useEscapeLink()">
									<div class="preview">${form.survey.escapePage} <a class="iconbutton" onclick="$('#tinymceescapepage').show();$(this).closest('.preview').hide()"><span class="glyphicon glyphicon-pencil"></span></a></div>
									<div id="tinymceescapepage" style="display: none">
										<form:textarea class="tinymce required" path="survey.escapePage"></form:textarea>
									</div>		
								</div>
								<div data-bind="visible: useEscapeLink">	
									<form:input class="targeturl form-control" path="survey.escapeLink" ></form:input>
								</div>
							</div>
						</td>
					</tr>							
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.ShowPDFOnUnavailabilityPage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.ShowPDFOnUnavailabilityPage" /></div>	
							</div>
							<div style="float: right">
 								<div class="onoffswitch">
									<form:checkbox path="survey.ShowPDFOnUnavailabilityPage" class="onoffswitch-checkbox" id="myonoffswitchpdfavail" />
									 <label class="onoffswitch-label" for="myonoffswitchpdfavail">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="float: left">
								<spring:message code="label.ShowDocsOnUnavailabilityPage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.ShowDocsOnUnavailabilityPage" /></div>	
							</div>
							<div style="float: right">
								<div class="onoffswitch">
									<form:checkbox path="survey.ShowDocsOnUnavailabilityPage" class="onoffswitch-checkbox" id="myonoffswitchdocavail" />
									 <label class="onoffswitch-label" for="myonoffswitchdocavail">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
			
			<div class="propertiesbox" style="min-height: 500px">
				<a class="anchor" id="type"></a>
				<label><spring:message code="label.Type" /></label>
				<table class="table table-bordered">
					<tr data-bind="visible: opc">
						<td>
							<div style="float: left"><spring:message code="label.EnableOPC" /></div>
							<div style="float: right">
								<div class="onoffswitch">
									<form:checkbox onchange="if ($('#myonoffswitchopc').prop('checked') == false) {$('#BRPConfirmationDialog').modal('show')}" path="survey.isOPC" class="onoffswitch-checkbox" id="myonoffswitchopc" />
									 <label class="onoffswitch-label" for="myonoffswitchopc">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
						</td>
					</tr>
					<tr  data-bind="visible: !opc()">
						<td>
							<div style="float: left"><spring:message code="label.EnableQuiz" /></div>
							<div style="float: right">
								<div class="onoffswitch">
									<c:choose>
										<c:when test="${form.survey.isOPC}">
											<input type="radio" disabled="disabled" name="survey.isQuiz" class="onoffswitch-checkbox" id="myonoffswitchquiz" />
											<label class="onoffswitch-label disabled" for="myonoffswitchquiz">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</c:when>
										<c:otherwise>
											<form:checkbox path="survey.isQuiz" onclick="_properties.toggleQuiz(this)" class="onoffswitch-checkbox" data-bind="enable: (_properties.isNormalSurvey()||_properties.quiz())" id="myonoffswitchquiz" />
											<label class="onoffswitch-label" data-bind='class: "onoffswitch-label"+((_properties.isNormalSurvey()||_properties.quiz()) ? "" : " disabled")' for="myonoffswitchquiz">
										        <span class="onoffswitch-inner"></span>
										        <span class="onoffswitch-switch"></span>
										    </label>
										</c:otherwise>
									</c:choose>									
									 
								</div>
							</div>
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: quiz">
						<td>
							<div style="float: left"><spring:message code="label.ShowQuizIcons" /><a onclick="$(this).closest('td').find('.help').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a></div>
							<div style="float: right">
								<div class="onoffswitch">
									<form:checkbox path="survey.showQuizIcons" class="onoffswitch-checkbox" id="myonoffswitchquizicons" />
									 <label class="onoffswitch-label" for="myonoffswitchquizicons">
								        <span class="onoffswitch-inner"></span>
								        <span class="onoffswitch-switch"></span>
								    </label>
								</div>
							</div>
							
							<div style="clear: both"></div>
							<div class="help" style="display: none">
								<spring:message code="info.ShowQuizIcons" />
							</div>						
						</td>
					</tr>
					<tr class="subelement" data-bind="visible: quiz">
						<td>
							<div style="float: left">
								<spring:message code="label.ShowScore" />
								<a onclick="$('#showtotalscorehelp').toggle()"><span class="glyphicon glyphicon-info-sign"></span></a>
							</div>
							<div style="float: right; max-width: 500px;">
								<table>
									<tr>
										<td style="padding-right: 15px;"><spring:message code="label.TotalScore" /></td>
										<td>
											<div class="onoffswitch">
												<form:checkbox path="survey.showTotalScore" class="onoffswitch-checkbox" id="myonoffswitchtotalscore" />
												 <label class="onoffswitch-label" for="myonoffswitchtotalscore">
											        <span class="onoffswitch-inner"></span>
											        <span class="onoffswitch-switch"></span>
											    </label>
											</div>							
										</td>
									</tr>
									<tr>
										<td style="padding-right: 15px; padding-top: 15px;">
											<spring:message code="label.ScoresByQuestion" />
										</td>
										<td style="padding-top: 15px;">
											<div class="onoffswitch">
												<form:checkbox path="survey.scoresByQuestion" class="onoffswitch-checkbox" id="myonoffswitchscoresbyquestion" />
												 <label class="onoffswitch-label" for="myonoffswitchscoresbyquestion">
											        <span class="onoffswitch-inner"></span>
											        <span class="onoffswitch-switch"></span>
											    </label>
											</div>									
										</td>
									</tr>
								</table>
							</div>
							
							<div style="clear: both"></div>
							<div class="help" id="showtotalscorehelp" style="display: none">
								<spring:message code="info.ShowTotalScoreNew" />
							</div>		
						</td>
					</tr>
					
					<tr class="subelement" data-bind="visible: quiz">
						<td>
							<div style="float: left">
								<spring:message code="label.WelcomeMessage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.WelcomeMessage" /></div>	
							</div>
							<div style="float: right">
								<div class="preview">${form.survey.quizWelcomeMessage} <a class="iconbutton" onclick="$('#tinymcewelcome').show();$(this).closest('.preview').hide()" style="margin-left: 10px;"><span class="glyphicon glyphicon-pencil"></span></a></div>
								<div id="tinymcewelcome" style="display: none">
									<form:textarea class="tinymce" path="survey.quizWelcomeMessage"></form:textarea>
								</div>
							</div>
						</td> 
					</tr>
					<tr class="subelement" data-bind="visible: quiz">
						<td>
							<div style="float: left">
								<spring:message code="label.ResultsMessage" />
								<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
								<div class="help hideme"><spring:message code="info.ResultsMessage" /></div>	
							</div>
							<div style="float: right">
								<div class="preview">${form.survey.quizResultsMessage} <a class="iconbutton" onclick="$('#tinymceresult').show();$(this).closest('.preview').hide()" style="margin-left: 10px;"><span class="glyphicon glyphicon-pencil"></span></a></div>
								<div id="tinymceresult" style="display: none">
									<form:textarea class="tinymce" path="survey.quizResultsMessage"></form:textarea>
								</div>
							</div>
						</td> 
					</tr>
					<c:if test="${enabledelphi || form.survey.isDelphi}">
						<tr data-bind="visible: !opc()">
							<td>
								<div style="float: left"><spring:message code="label.EnableDelphi" /></div>
								<div style="float: right">
									<div class="onoffswitch">
										<c:choose>
											<c:when test="${form.survey.isOPC}">
												<input type="radio" disabled="disabled" name="survey.isDelphi" class="onoffswitch-checkbox" id="myonoffswitchdelphi" />
												<label class="onoffswitch-label disabled" for="myonoffswitchdelphi">
													<span class="onoffswitch-inner"></span>
													<span class="onoffswitch-switch"></span>
												</label>
											</c:when>
											<c:otherwise>
												<form:checkbox path="survey.isDelphi" onclick="_properties.toggleDelphi(this)" class="onoffswitch-checkbox" data-bind="enable: (_properties.isNormalSurvey()||_properties.delphi())" id="myonoffswitchdelphi" />
												<label class="onoffswitch-label" data-bind='class: "onoffswitch-label"+((_properties.isNormalSurvey()||_properties.delphi()) ? "" : " disabled")' for="myonoffswitchdelphi">
													<span class="onoffswitch-inner"></span>
													<span class="onoffswitch-switch"></span>
												</label>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</td>
						</tr>
						<tr class="subelement" data-bind="visible: delphi">
							<td>
								<div style="float: left">
									<spring:message code="label.ShowDelphiResultsTableAndStatisticsInstantly" />
									<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
									<div class="help hideme"><spring:message code="info.ShowDelphiResultsTableAndStatisticsInstantly" /></div>
								</div>
								<div style="float: right">
									<div class="onoffswitch">
										<form:checkbox path="survey.isDelphiShowAnswersAndStatisticsInstantly" class="onoffswitch-checkbox" id="isDelphiShowAnswersAndStatisticsInstantly" />
										<label class="onoffswitch-label" for="isDelphiShowAnswersAndStatisticsInstantly">
											<span class="onoffswitch-inner"></span>
											<span class="onoffswitch-switch"></span>
										</label>
									</div>
								</div>
								<div style="clear: both"></div>
							</td>
						</tr>
						<tr class="subelement" data-bind="visible: delphi">
							<td>
								<div style="float: left">
									<spring:message code="label.ShowDelphiAnswerTable" />
									<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
									<div class="help hideme"><spring:message code="info.ShowDelphiAnswerTable" /></div>
								</div>
								<div style="float: right">
									<div class="onoffswitch">
										<form:checkbox path="survey.isDelphiShowAnswers" class="onoffswitch-checkbox" id="myonoffswitchdelphianswers" />
										<label class="onoffswitch-label" for="myonoffswitchdelphianswers">
											<span class="onoffswitch-inner"></span>
											<span class="onoffswitch-switch"></span>
										</label>
									</div>
								</div>
								<div style="clear: both"></div>
							</td>
						</tr>
						<tr class="subelement" data-bind="visible: delphi">
							<td>
								<div style="float: left">
									<spring:message code="label.MinimumResultsForStatistics" />
									<a onclick="$(this).closest('td').find('.help').toggle()"><span class='glyphicon glyphicon-info-sign'></span></a>
									<div class="help hideme"><spring:message code="info.MinimumResultsForStatistics" /></div>
								</div>
								<div style="float: right">
									<div style="float: right; max-width: 500px;">
										<form:input htmlEscape="false" path="survey.minNumberDelphiStatistics" id="minNumberDelphiStatistics" type="number" class="form-control number max1000000000" min='1' max='1000000000' style="display: inline-block" />
									</div>
								</div>
								<div style="clear: both"></div>
							</td>
						</tr>
					</c:if>
				</table>	
			</div>			
			
		</form:form>
	</div>
	
<jsp:include page="properties-dialogs.jsp" />

</div>

<jsp:include page="../footer.jsp" />
	
	<script>
	$(function() {
		$("#form-menu-tab").addClass("active");
		$("#properties-button").removeClass("InactiveLinkButton").addClass("ActiveLinkButton");
		
		$("#save-form").on("submit", function(){
			var sec = "open";
			if ($('#myonoffswitchsecured').is(":checked")) {
				sec = "secured";
			}				
			if ($('#myonoffswitchprivacy').is(":checked")) {
				sec += "anonymous";
			}				
			$("#survey-security").val(sec);
		});
		
		var uploader = new qq.FileUploader({
		    element: $("#file-uploader-logo")[0],
		    action: contextpath + '/${sessioninfo.shortname}/management/uploadimage',
		    uploadButtonText: selectFileForUpload,
		    params: {
		    	'_csrf': csrftoken
		    },
		    multiple: false,
		    cache: false,
		    sizeLimit: 1048576,
		    onComplete: function(id, fileName, responseJSON)
			{
		    	if (responseJSON.success)
		    	{
			    	$("#logo-cell").find("img").remove();
			    	var img = document.createElement("img");
			    	$(img).attr("src", contextpath + "/files/" + surveyUniqueId +  "/" + responseJSON.id);
			    	$(img).attr("width",responseJSON.width);
			    	$(img).attr("data-width",responseJSON.width);
			    	$("#logo-cell").find("img").remove();
			    	$("#logo-cell").find("p").remove();
			    	$("#logo-cell").prepend("<p>" + responseJSON.name + "</p>");
			    	$("#logo-cell").prepend(img);
			    	$("#logo").val(responseJSON.id);
			    	$("#logo-cell").find(".disabled").removeClass("disabled").show();
			    	$("#file-uploader-area-div").show();
			    	$("#removelogobutton").removeClass("disabled").show();
		    	} else {
		    		showError(invalidFileError);
		    	}
			},
			showMessage: function(message){
				$("#file-uploader-logo").append("<div class='validation-error'>" + message + "</div>");
			},
			onUpload: function(id, fileName, xhr){
				$("#file-uploader-logo").find(".validation-error").remove();			
			}
		});
		
		$(".qq-upload-button").addClass("btn btn-default").removeClass("qq-upload-button");
		$(".qq-upload-list").hide();
		$(".qq-upload-drop-area").css("margin-left", "-1000px");			

		$('.navbar-default li a').click(function(event) {
		    event.preventDefault();
		    $($(this).attr('href'))[0].scrollIntoView();
		    scrollBy(0, -offset);
		});
		
		ko.applyBindings(_properties, $('#propertiespage')[0]);
		
		$('#propertiespage').find('input[type="hidden"][name^="_survey"]').each(function(){
			$('#save-form').append(this);
		});
		
		$(".datepicker").datepicker('option', 'dateFormat', "dd/mm/yy");
		
		$("#survey\\.contact").val($("#survey\\.contact").val().replace("form:", ""));		
	});	
	</script>
	
</body>
</html>
