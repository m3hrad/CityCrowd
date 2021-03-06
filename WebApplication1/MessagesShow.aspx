﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageUser.Master" AutoEventWireup="true" CodeBehind="MessagesShow.aspx.cs" Inherits="WebApplication1.MessagesShow" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../../../Styles/themes/moody.min.css" />
    <link rel="stylesheet" href="../../../Styles/themes/jquery.mobile.icons.min.css" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.3/jquery.mobile.structure-1.4.3.min.css" />
    <link rel="stylesheet" href="../../../Styles/font-awesome-4.2.0/css/font-awesome.min.css" />
    <link href="Images/favicon.png" rel="icon" type="image/png" />

    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
        $(document).on("mobileinit", function () {
            $.mobile.selectmenu.prototype.options.nativeMenu = false;
        });
        $(document).bind("mobileinit", function () {
            $.mobile.ajaxEnabled = false;
        });
    </script>
    <script src="../../../JS/script.js"></script>
    <script src="../../../JS/jquery-ui.min.js"></script>
    <script src="../../../JS/jquery.cookie.js"></script>

    <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <link rel="stylesheet" href="../../../Styles/style.css" />
    <link rel="stylesheet" href="../../../Styles/jquery-ui.min.css" />

    <!-- signalR -->
    <!--Reference the SignalR library. -->
    <script src="../../../Scripts/jquery.signalR-2.2.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../../../signalr/hubs"></script>
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script>
        $(document).ready(function () {
            messagesShowPage();
            generalLook();
            menu();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="nHeader">
        <div class="nMenuButton">
            <div class="nMenuButtonLogo">
            </div>
            <div class="nMenuNotification nMenuButtonNotification">
                <figure class="front">0</figure>
                <figure class="back">0</figure>
            </div>
        </div>
        <div class="nMenuAdd"></div>
        <div class="nPageTitle">Messages</div>
    </div>
    <div class="nMSMessagesContainer animationAll">
        <div class="nMSmoreButton hidden">Loading more...</div>

        <asp:Repeater ID="RepeaterMessages" runat="server">
            <ItemTemplate>
                <div class="eachMessage">
                    <div class="nMessagesPicture nMessagesShowPicture">
                        <div class="nMessagesUrl invisible"><%# Eval("UserId") %></div>
                        <asp:HiddenField ID="HiddenFieldUserId" runat="server" Value='<%# Eval("UserId") %>' />
                    </div>
                    <asp:HiddenField ID="HiddenFieldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                    <div>
                    </div>
                    <div class="nMessageBody">
                        <span><%# Eval("Message") %></span>
                        <div class="nMessageDecoration"></div>
                    </div>
                    <!--<asp:Label ID="LabelUnread" runat="server" Text='<%# Eval("Unread") %>' CssClass="EachMessageUnread ViewClass"></asp:Label> -->
                    <div class="invisible">
                        <asp:Label ID="LabelSender" runat="server" Text='<%# Eval("Sender") %>' CssClass="EachMessageSender"></asp:Label>
                    </div>
                    <div class="clear"></div>
                    <div class="MessageListDate nMSDate">
                        <asp:Label ID="LabelDate" runat="server" Text='<%# Eval("PassedDate") %>' CssClass="EachMessageDate ViewClass"></asp:Label>
                    </div>
                </div>
                <div class="clear"></div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class=" nMSFooter animationAll ">
        <div class="nMessageSendArea">
            <asp:Panel ID="PanelMessage" CssClass="nMSPanel" runat="server">
                <div class="nMSSendButton">
                    <b>SEND</b>
                </div>
                <div class="nMSTextArea">
                    <asp:TextBox ID="TextBoxMessage" runat="server" CssClass="TextBoxMultiR2L" TextMode="MultiLine" data-autogrow="false"></asp:TextBox>
                </div>
                <div class="  nMessageFooterButton">
                    <div class="nFooterButton nProfileMessageButton nMSFooterButton">
                        <div class="nFooter1Image nProfileImageGrey"></div>
                        BACK TO MESSAGES
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
    <div class="invisible">
    </div>
    <asp:HiddenField ID="HiddenFieldOwnerName" runat="server" />
    <asp:HiddenField ID="HiddenFieldOwnerPhotoUrl" runat="server" />
    <asp:HiddenField ID="HiddenFieldOtherName" runat="server" />
    <asp:HiddenField ID="HiddenFieldOtherPhotoUrl" runat="server" />
    <asp:HiddenField ID="HiddenFieldOtherId" runat="server" />
    <asp:HiddenField ID="HiddenFieldMessageId" runat="server" />
</asp:Content>
