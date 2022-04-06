<%-- path of this file : /data1/app/webapps/ROOT --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>                    

<%

Class.forName("org.mariadb.jdbc.Driver");

String db_url = "jdbc:mariadb://172.27.0.121:3306/seouldev";
String db_id = "seouldev";
String db_pw = "seouldev0330!";

Connection conn = null;

try{
    conn=DriverManager.getConnection(db_url,db_id,db_pw);
    out.println("True");
}catch(Exception e){
    e.printStackTrace();
    out.println("Connection Failed : " + e);
}
finally{
    try{
        if( conn != null && !conn.isClosed()){
            conn.close();
        }
    }
    catch( SQLException e){
      System.out.println("Exception closing : " + e);
    }
}

%>
