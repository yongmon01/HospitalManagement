using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.OleDb;


namespace hospitalManagement
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["LastName"].DefaultValue = txtLName.Text;
            SqlDataSource1.InsertParameters["FirstName"].DefaultValue = txtFName.Text;
            SqlDataSource1.InsertParameters["Address"].DefaultValue = txtAddress.Text;

            SqlDataSource1.Insert();

            txtLName.Text = string.Empty;
            txtFName.Text = string.Empty;
            txtAddress.Text = string.Empty;
        }

        protected void gvVisits_SelectedIndexChanged(object sender, EventArgs e)
        {
            string date = gvVisits.SelectedRow.Cells[2].Text;
            lblVisitDate.Text = date;
        }

        protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)/////
        {
            string name;
            string lName = gvPatients.SelectedRow.Cells[2].Text;
            string fName = gvPatients.SelectedRow.Cells[3].Text;
            name = lName + ", " + fName;
            lblPatient.Text = name;


            int patientsID = Convert.ToInt32(gvPatients.SelectedValue);
            double totalCharge = 0;

            IDbConnection con = new OleDbConnection();
  
            IDbCommand cmd = new OleDbCommand();

            string conn = ConfigurationManager.ConnectionStrings["patientsConnectionString"].ConnectionString;

            con.ConnectionString = conn;

            cmd.Connection = con;

            string sql =
                "SELECT " +
                    "Visits.PatientID, " +
                    "Visits.Charge " +
                "FROM " +
                    "Visits ";

            cmd.CommandText = sql;

            try
            {
                cmd.Connection.Open();

                IDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    int pID = dr.GetInt32(0);
                    double charge = (double)dr.GetDecimal(1);

                    if (pID == patientsID)
                    {
                        totalCharge += charge;
                    }
                }

                dr.Close();
                cmd.Connection.Close();

                lblTotalCharges.Text = "" + totalCharge;
            }
            catch (Exception ex)
            {
                lblTotalCharges.Text += ex.ToString();
            }
        }

        protected void btnAddVisit_Click(object sender, EventArgs e)
        {
            string ID = "" + gvPatients.SelectedValue;
            
            SqlDataSource2.InsertParameters["PatientID"].DefaultValue = ID;
            SqlDataSource2.InsertParameters["VisitDate"].DefaultValue = txtDate.Text;
            SqlDataSource2.InsertParameters["Charge"].DefaultValue = txtCharge.Text;
            SqlDataSource2.InsertParameters["Notes"].DefaultValue = txtNotes.Text;

            SqlDataSource2.Insert();

            txtDate.Text = string.Empty;
            txtCharge.Text = string.Empty;
            txtNotes.Text = string.Empty;
        }

        protected void btnAddPrescriptions_Click(object sender, EventArgs e)
        {
            string patientID = "" + gvPatients.SelectedValue;
            string visitID = "" + gvVisits.SelectedValue;

            SqlDataSource3.InsertParameters["PatientID"].DefaultValue = patientID;
            SqlDataSource3.InsertParameters["VisitID"].DefaultValue = visitID;
            SqlDataSource3.InsertParameters["DrugName"].DefaultValue = txtDrugName.Text;
            SqlDataSource3.InsertParameters["Instructions"].DefaultValue = txtInstructions.Text;

            SqlDataSource3.Insert();

            txtDrugName.Text = string.Empty;
            txtInstructions.Text = string.Empty;

        }

        protected void gvPatients_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                lblDeletePatientFailure.Visible = true;
                lblDeletePatientFailure.Text = "삭제성공";
            }
            
            else
            {
                lblDeletePatientFailure.Visible = true;
                lblDeletePatientFailure.Text = "방문기록이 존재하여 삭제할수 없습니다.";
                e.ExceptionHandled = true;
            }
        }

        protected void gvVisits_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                lblDeleteVisitFailure.Visible = true;
                lblDeleteVisitFailure.Text = "삭제 성공";
            }
            
            else
            {
                lblDeleteVisitFailure.Visible = true;
                lblDeleteVisitFailure.Text = "처방전이 존재하여 삭제할수 없습니다.";
                e.ExceptionHandled = true;
            }
        }
    }
}