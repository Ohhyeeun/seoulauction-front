<%
  String user = request.getParameter("user");
  String savedUser = (String)session.getAttribute("user");
  
  if( user != null && !user.isEmpty() ) {
    session.setAttribute("user",user);
  }
%>
<html>
<head>
<title>Test JSP</title>
</head>

<body>
<form action="/jsp/test.jsp" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#CCCCCC">
    <td width="20%">TomcatB Machine</td>
    <td width="80%"> </td>
  </tr>
  <tr>
    <td>Session ID :</td>
    <td><%=session.getId()%></td>
  </tr>
  <tr>
    <td>Saved User :</td>
    <td><input type="text" value="<%=savedUser%>" /></td>
  </tr>
  <tr>
    <td>New User :</td>
    <td><input type="text" name="user" value="" /></td>
  </tr>
  <tr>
    <td colspan="2"><input type="button" value="SEND" onclick="frm.submit()" /></td>
  </tr>
</table>
</form>
</body>
</html>
