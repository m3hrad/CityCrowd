﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace WebApplication1
{
    public partial class MessagesShow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check login
            int UserId = 0;
            if (Session["UserId"] != null)
            {
                UserId = Convert.ToInt32(Session["UserId"]);
            }
            else
            {
                if (Request.Cookies["VC"] != null)
                {
                    string VC = Request.Cookies["VC"].Values["VC"];
                    Classes.LoginSession ls = new Classes.LoginSession();
                    UserId = ls.getUserId(VC);
                    if (UserId == 0) //if user not logged in redirect to login
                    {
                        Response.Redirect("~/Login/Messages");
                    }
                    else
                    {
                        Session["UserId"] = UserId.ToString();
                    }
                }
                else
                {
                    Response.Redirect("~/Login/Messages");
                }
            }

            //check user status
            string completionValue = Session["DoneCompletion"] as string; if (String.IsNullOrEmpty(completionValue))
            {
                Classes.UserInfo ui = new Classes.UserInfo();
                int userStatus = ui.getUserStatus(UserId);
                switch (userStatus)
                {
                    case 1:
                        Session["DoneCompletion"] = "1";
                        break;
                    case 0:
                    case 4:
                        Response.Redirect("~/Completion");
                        break;
                    case 2:
                        Response.Redirect("~/Error/UserDisabled");
                        break;
                    case 3:
                        Response.Redirect("~/Error/UserDeactivated");
                        break;
                }
            }

            int otherId = Convert.ToInt32(Page.RouteData.Values["ProfileId"].ToString());
            HiddenFieldOtherId.Value = otherId.ToString();

            Classes.Messages m = new Classes.Messages();
            Tuple<int, DataTable, DataTable, string, string> result = m.showMessages(UserId, otherId, 99999999);

            int status = result.Item1;
            DataTable dtUserName = result.Item2;
            DataTable dtOtherName = result.Item3;
            HiddenFieldOwnerPhotoUrl.Value = result.Item4;
            HiddenFieldOtherPhotoUrl.Value = result.Item5;

            if (status == -1)
            {
                Response.Redirect("~/Messages");
            }

            HiddenFieldOwnerName.Value = dtUserName.Rows[0]["FirstName"].ToString() + " " + dtUserName.Rows[0]["LastName"].ToString();
            HiddenFieldOtherName.Value = dtOtherName.Rows[0]["FirstName"].ToString() + " " + dtOtherName.Rows[0]["LastName"].ToString();
            Page.Title = "Messages : " + dtOtherName.Rows[0]["FirstName"].ToString() + " " + dtOtherName.Rows[0]["LastName"].ToString();
        }
    }
}