<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<f:view>
<html>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.*" 
%>
<%@ page import="com.mysql.jdbc.Driver" %>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="Deskripsi Blog">
<meta name="author" content="Judul Blog">

<!-- Twitter Card -->
<meta name="twitter:card" content="WebContent/update.jsp""summary">
<meta name="twitter:site" content="omfgitsasalmon">
<meta name="twitter:title" content="Simple Blog">
<meta name="twitter:description" content="Deskripsi Blog">
<meta name="twitter:creator" content="Simple Blog">
<meta name="twitter:image:src" content="{{! TODO: ADD GRAVATAR URL HERE }}">

<meta property="og:type" content="article">
<meta property="og:title" content="Simple Blog">
<meta property="og:description" content="Deskripsi Blog">
<meta property="og:image" content="{{! TODO: ADD GRAVATAR URL HERE }}">
<meta property="og:site_name" content="Simple Blog">

<link rel="stylesheet" type="text/css" href="assets/css/screen.css" />
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">

<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<title>Simple Blog</title>


</head>

<body class="default">
   
<%
  InitialContext ctx;
  DataSource ds;
  Connection conn;
  Statement stmt;
  ResultSet rs;

  try {
    ctx = new InitialContext();
	Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wbd_db", "root", "");
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM post WHERE status = 'published' ORDER BY post_date DESC");
%>
<div class="wrapper">

<nav class="nav">
    <a style="border:none;" id="logo" href="index.jsp"><h1>Simple<span>-</span>Blog</h1></a>
    <h:form rendered="#{!loginHandler.login}">
        <h:outputText value="Username : "/>
        <h:inputText value="#{loginHandler.username}"></h:inputText>
        <h:outputText value="Password : "/>
        <h:inputSecret value="#{loginHandler.password}"></h:inputSecret>
        <h:commandButton value="login" action="#{loginHandler.login()}"></h:commandButton>
    </h:form>
    <h:form rendered="#{loginHandler.login}">
        <h:outputLabel value="Welcome #{loginHandler.username}" ></h:outputLabel>
        <h:commandButton value="logout" action="#{loginHandler.logout()}"></h:commandButton>
    </h:form>
    <ul class="nav-primary">
        <f:subview id="publish3" rendered="#{loginHandler.admin||loginHandler.owner}"><li><a href="newpost.jsp">+ Tambah Post</a></li></f:subview>
        <f:subview id="publish" rendered="#{loginHandler.editor||loginHandler.admin}"><li><a href="publish_post.jsp">Publish Post</a></li></f:subview>
        <f:subview id="publish2" rendered="#{loginHandler.admin}"><li><a href="man_user.jsp">Manage user</a></li></f:subview>
        <f:subview id="publish4" rendered="#{loginHandler.admin}"><li><a href="deleted_post.jsp">Manage Deleted Post</a></li></f:subview>
  </ul>
</nav>

<div id="home">
    <div class="posts">
        <nav class="art-list">
          <ul class="art-list-body">
          	<%while(rs.next()) { 
          	%>
            <li class="art-list-item">
                <div class="art-list-item-title-and-time">
                    <h2 class="art-list-title"><a href="post.jsp?postId=<% out.print(rs.getString("post_id")); %>"><% out.print(rs.getString("tittle"));%></a></h2>
                    <div class="art-list-time"><% out.print(rs.getString("post_date"));%></div>
                </div>
                <p><% out.print(rs.getString("konten"));%>&hellip;</p>
                <p>
                    <f:subview id="asd" rendered="#{loginHandler.login}"><a href="update_post.jsp?postId=<% out.print(rs.getString("post_id")); %>">Edit</a> | <a href="delete_post.jsp?postId=<% out.print(rs.getString("post_id")); %>" onclick="return confirm('Apa kamu yakin untuk menghapus post ini?');">Hapus</a>
                    </f:subview>
                </p>
            </li>
            <%}}
			  catch(Exception e){out.println("Error" + e);} %>
          </ul>
        </nav>
    </div>
</div>

<footer class="footer">
    <div class="back-to-top"><a href="">Back to top</a></div>
    <!-- <div class="footer-nav"><p></p></div> -->
    <div class="psi">&Psi;</div>
    <aside class="offsite-links">
        Asisten IF3110 /
        <a class="rss-link" href="#rss">RSS</a> /
        <br>
        <a class="twitter-link" href="http://twitter.com/YoGiiSinaga">Yogi</a> /
        <a class="twitter-link" href="http://twitter.com/sonnylazuardi">Sonny</a> /
        <a class="twitter-link" href="http://twitter.com/fathanpranaya">Fathan</a> /
        <br>
        <a class="twitter-link" href="#">Renusa</a> /
        <a class="twitter-link" href="#">Kelvin</a> /
        <a class="twitter-link" href="#">Yanuar</a> /
        
    </aside>
</footer>

</div>

<script type="text/javascript" src="assets/js/fittext.js"></script>
<script type="text/javascript" src="assets/js/app.js"></script>
<script type="text/javascript" src="assets/js/respond.min.js"></script>
<script type="text/javascript">
  var ga_ua = '{{! TODO: ADD GOOGLE ANALYTICS UA HERE }}';

  (function(g,h,o,s,t,z){g.GoogleAnalyticsObject=s;g[s]||(g[s]=
      function(){(g[s].q=g[s].q||[]).push(arguments)});g[s].s=+new Date;
      t=h.createElement(o);z=h.getElementsByTagName(o)[0];
      t.src='//www.google-analytics.com/analytics.js';
      z.parentNode.insertBefore(t,z)}(window,document,'script','ga'));
      ga('create',ga_ua);ga('send','pageview');
</script>
</body>
</html>
</f:view>