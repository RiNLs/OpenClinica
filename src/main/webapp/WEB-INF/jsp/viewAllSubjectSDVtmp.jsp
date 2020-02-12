<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:setBundle basename="org.akaza.openclinica.i18n.words" var="resword"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.format" var="resformat"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.notes" var="restext"/>
<fmt:setBundle basename="org.akaza.openclinica.i18n.page_messages" var="resmessages"/>

<jsp:include page="include/managestudy_top_pages.jsp"/>

<!-- move the alert message to the sidebar-->
<jsp:include page="include/sideAlert.jsp"/>
<!-- then instructions-->
<tr id="sidebar_Instructions_open">
    <td class="sidebar_tab">

        <a href="javascript:leftnavExpand('sidebar_Instructions_open'); leftnavExpand('sidebar_Instructions_closed');"><span class="icon icon-caret-down gray"></span></a>

        <fmt:message key="instructions" bundle="${restext}"/>

        <div class="sidebar_tab_content">

            <fmt:message key="design_implement_sdv" bundle="${restext}"/>

        </div>

    </td>

</tr>
<tr id="sidebar_Instructions_closed" style="display: none">
    <td class="sidebar_tab">

        <a href="javascript:leftnavExpand('sidebar_Instructions_open'); leftnavExpand('sidebar_Instructions_closed');"><span class="icon icon-caret-right gray"></span></a>

        <fmt:message key="instructions" bundle="${restext}"/>

    </td>
</tr>
<jsp:include page="include/sideInfo.jsp"/>
<link rel="stylesheet" href="../includes/jmesa/jmesa.css" type="text/css">
<script type="text/JavaScript" language="JavaScript" src="${pageContext.request.contextPath}/includes/jmesa/jquery.min.js"></script>
<script type="text/JavaScript" language="JavaScript" src="${pageContext.request.contextPath}/includes/jmesa/jmesa.js"></script>
<script type="text/JavaScript" language="JavaScript" src="${pageContext.request.contextPath}/includes/jmesa/jquery.jmesa.js"></script>
<script type="text/javascript" language="JavaScript" src="${pageContext.request.contextPath}/includes/jmesa/jquery-migrate-1.4.1.js"></script>
<script type="text/javascript" language="JavaScript" src="${pageContext.request.contextPath}/includes/jmesa/jquery.blockUI.js"></script>
<script type="text/javascript" language="JavaScript" src="${pageContext.request.contextPath}/includes/permissionTagAccess.js"></script>


<%-- view all subjects starts here --%>
<script type="text/javascript">

    function onInvokeAction(id,action) {
        setExportToLimit(id, '');
        createHiddenInputFieldsForLimitAndSubmit(id);
    }
    function onInvokeExportAction(id) {
        var parameterString = createParameterStringForLimit(id);
        //location.href = '${pageContext.request.contextPath}/ViewCRF?module=manage&crfId=' + '${crf.id}&' + parameterString;
    }
</script>

</div>

<div id="box" class="dialog">
    <span id="mbm">
        <br>
        <c:if test="${(!study.status.pending)}">
            <fmt:message key="study_frozen_locked_note" bundle="${restext}"/>
        </c:if>
        
        <c:if test="${(study.status.pending)}">
            <fmt:message key="study_design_note" bundle="${restext}"/>
        </c:if>   
    </span><br>
    <div style="text-align:center; width:100%;">
        <button id="btn" onclick="hm('box');">OK</button>
    </div>
</div>

<script type="text/javascript">
    window.onload = function() {
        document.getElementById("btn").focus();
    };
</script>

<h1><span class="title_manage">
<fmt:message key="sdv_sdv_for" bundle="${resword}"/> <c:out value="${study.name}"/>
    <a href="javascript:openDocWindow('https://docs.openclinica.com/3.1/openclinica-user-guide/monitor-and-manage-data')">
        <span class=""></span></a>
</span></h1><br/>

<jsp:useBean scope='session' id='sSdvRestore' class='java.lang.String' />
<c:set var="restore" value="true"/>
<c:if test="${sSdvRestore=='false'}"><c:set var="restore" value="false"/></c:if>

<script type="text/javascript">
    function setRedirection(formObj) {
        var params = new URLSearchParams(window.location.search);
        params.delete('redirection');
        if (!params.has('studyId'))
            params.append('studyId', '${study.studyId}');
        formObj.redirection.value = '${pageContext.request.contextPath}/pages/viewAllSubjectSDVtmp?' + params.toString();
    }

    function prompt(formObj,crfId){
        var bool = confirm(
                "<fmt:message key="uncheck_sdv" bundle="${resmessages}"/>");
        if(bool){
            setRedirection(formObj);
            formObj.action='${pageContext.request.contextPath}/pages/handleSDVRemove';
            formObj.crfId.value=crfId;
            formObj.submit();
        }
    }

    function submitSdv(formObj,crfId) {
        setRedirection(formObj);
        formObj.action='${pageContext.request.contextPath}/pages/handleSDVGet';
        formObj.crfId.value=crfId;
        formObj.submit();
    }
</script>
<div id="subjectSDV">
    <form name='sdvForm' action="${pageContext.request.contextPath}/pages/viewAllSubjectSDVtmp">
        <input type="hidden" name="studyId" value="${param.studyId}">
        <input type="hidden" name=imagePathPrefix value="../">
        <%--This value will be set by an onclick handler associated with an SDV button --%>
        <input type="hidden" name="crfId" value="0">
        <%-- the destination JSP page after removal or adding SDV for an eventCRF --%>
        <input type="hidden" name="redirection" value="viewAllSubjectSDVtmp?sdv_restore=true&studyId=${param.studyId}">
        <%--<input type="hidden" name="decorator" value="mydecorator">--%>
        ${sdvTableAttribute}
        <br />
        <input type="submit" name="sdvAllFormSubmit" class="button_medium" value="<fmt:message key="sdv_all_checked" bundle="${resword}"/>" onclick="this.form.method='POST';this.form.action='${pageContext.request.contextPath}/pages/handleSDVPost';this.form.submit();"/>
        <!--  <input type="submit" name="sdvAllFormCancel" class="button_medium" value="Cancel" onclick="this.form.action='${pageContext.request.contextPath}/pages/viewAllSubjectSDVtmp?sdv_restore=true&studyId=${param.studyId}';this.form.submit();"/> -->
    </form>
   <%-- <script type="text/javascript">hideCols('sdv',[2,3,6,7,11,12,13])</script> --%>

</div>
<%-- view all subjects ends here --%>

<link rel="stylesheet" href="../includes/css/icomoon-style.css">

<script>
  function store(callback) {
    if (callback)
      store.data = callback(store.data) || store.data;
    if (!store.dirty) {
      store.dirty = true;
      setTimeout(function() {
        sessionStorage.setItem(store.key, JSON.stringify(store.data));
        if (
          store.data.ocStatusHide !== 'oc-status-removed' ||
          store.data.datatables.some(function(state) {return canReset(state)}) ||
          $('#studySubjectRecord.collapsed, #subjectEvents.collapsed, #commonEvents>.expanded').length
        )
          $('#reset-all-filters').removeClass('invisible');
        else
          $('#reset-all-filters').addClass('invisible');
        store.dirty = false;
      }, 1);
    }
  }
  store.key = '${study.oc_oid}.SDVs';
  store.data = JSON.parse(sessionStorage.getItem(store.key)) || {
    sdvChecks: {}
  };
  store.dirty = false;

  $('#sdv')
      .on('change', 'input[type=checkbox]', function() {
        var checkbox = $(this);
        var name = checkbox.attr('name');
        var checked = checkbox.is(':checked');
        store(function(data) {
            data.sdvChecks[name] = checked;
        });
      })
      .find('input[type=checkbox]').each(function() {
        var checkbox = $(this);
        var name = checkbox.attr('name');
        var checked = store.data.sdvChecks[name];
        if (checked)
            checkbox.attr('checked', 'checked');
        else
            checkbox.removeAttr('checked');
      });
</script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css"/>
<script type="text/JavaScript" language="JavaScript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<style>
  #itemsdv {
    position: relative;
  }

  #sdv-close-popup {
    float: right;
    position: absolute;
    right: -25px;
    top: -25px;
  }
  #sdv-close-popup > .icon-cancel::before {
    border-radius: 50px;
    color: white;
  }
  #sdv-show-type {
    float: right;
    padding: 10px;
  }
  #sdv-items {
    clear: both;
  }
  #sdv-details {
    padding: 10px;
    background-color: lightgray;
  }
  #sdv-details th {
    font-weight: normal;
    text-align: left;
    padding: 5px;
  }
  #sdv-details td {
    width: 150px;
    border: 1px solid gray;
    font-weight: bold;
  }
  #sdv-items_wrapper {
    margin: 0 10px 10px;
  }
  #sdv-items th {
    font-weight: normal;
  }
  .blockOverlay {
    cursor: default !important;
  }
  .blockUI.blockMsg.blockPage {
    padding: 0 !important;
  }
</style>

<div id="itemsdv" style="display:none;">
  <a href="javascript:jQuery.unblockUI()" id="sdv-close-popup">
    <span class="icon icon-cancel"></span>
  </a>
  <table id="sdv-details">
    <tbody>
      <tr>
        <th>Participant ID:</th>
        <td id="participantId"></td>
        <th>Event Name:</th>
        <td id="eventName"></td>
        <th>Form Name:</th>
        <td id="formName"></td>
        <th>SDV Requirement:</th>
        <td id="sdvRequirement"></td>
      </tr>
      <tr>
        <th>Site Name:</th>
        <td id="siteName"></td>
        <th>Event Start Date:</th>
        <td id="eventStartDate"></td>
        <th>Form Status:</th>
        <td id="formStatus"></td>
        <th>SDV Status:</th>
        <td id="sdvStatus"></td>
      </tr>
    </tbody>
  </table>
  <div id="sdv-show-type">
    <label>
      <input name="type" type="radio" autofocus="autofocus" checked="checked"> Show all items
    </label>
    <label>
      <input name="type" type="radio"> Show only changed since last Verified
    </label>
  </div>
  <table id='sdv-items'>
    <thead>
      <tr>
        <th>Brief Description (Item Name)</th>
        <th>Value</th>
        <th>Last Verified</th>
        <th>Open Queries</th>
        <th>Last Modified</th>
        <th>Modified By</th>
      </tr>
    </thead>
    <tbody id="sdvItems">
    </tbody>
  </table>
</div>

<script>
  jQuery('#sdv-items').DataTable({
    dom: 't',
    columns: [
    {data: 'briefDescription'},
    {data: 'value'},
    {data: 'lastVerifiedDate'},
    {data: 'openQueriesCount'},
    {data: 'lastModifiedDate'},
    {data: 'lastModifiedUserName'},
    ]
  });

  function translate(str) {
    var trans = {
      '100percent_required': '100% Required'
    };
    return trans[str] || str;
  }

  function popupSdv(item) {
    var data = $(item).data();
    var url = 'auth/api/sdv/studies/' + data.studyOid + '/events/' + data.eventOid + '/occurrences/1/forms/' + data.formOid + '/participants/' + data.participantId + '/sdvItems?changedAfterSdvOnlyFilter=n';
    $.get(url, function(data) {
      $('#participantId').text(data.participantId);
      if (data.repeatingEvent) {
        $('#eventName').text(data.eventName + '(' + data.eventOrdinal + ')');
      }
      else {
        $('#eventName').text(data.eventName);
      }
      $('#formName').text(data.formName);
      $('#sdvRequirement').text(translate(data.sdvRequirement));
      $('#siteName').text(data.siteName);
      $('#eventStartDate').text(data.eventStartDate);
      $('#formStatus').text(data.formStatus);
      $('#sdvStatus').text(data.sdvStatus);

      var tbl = jQuery('#sdv-items').DataTable();
      tbl.rows.add(data.sdvItems.map(function(item) {
        item.lastVerifiedDate = data.lastVerifiedDate;
        return item;
      }));
      tbl.draw();
    });

    jQuery.blockUI({message: jQuery('#itemsdv'), css:{cursor:'default', left:'75px', top:'100px'}});
    var cols = $(item).closest('tr').children();
  }

</script>
