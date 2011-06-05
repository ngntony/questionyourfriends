﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Page d'accueil
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%:ViewData["Message"]%></h2>
    <p>
    
        Ask!
        
    Hello World, <%:ViewData["Firstname"]%> <%:ViewData["Lastname"]%>
    </p>
   
    <fb:serverFbml  width="300px" >
    <script type="text/fbml">
        <fb:fbml>
            <fb:request-form
            action="http://apps.facebook.com/questionyourfriends/Ask/Ask"
                    target="_top"
                    method="GET"
                    invite="true"
                    type="Demo"
                    content="Hello"
                    label='Accept' >
                <fb:friend-selector name="uid" idname="friend_sel" />
                <fb:editor-textarea name="ask" />
                <label for="annon_cost">Mise annonymisation</label>
                <input type="text" name="annon_cost" id="annon_cost"/>
                <label for="private_cost">Mise privatisation</label>
                <input type="text" name="private_cost" id="private_cost"/>
                <fb:submit >Poser</fb:submit>
            </fb:request-form>
      </fb:fbml>
    </script>
  </fb:serverFbml>
</asp:Content>
