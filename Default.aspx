<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="hospitalManagement.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Management System</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Patient Management System</h3>
            <hr />

            <p><strong>환자</strong></p>
            <asp:GridView ID="gvPatients" PageSize="5" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="PatientID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvPatients_SelectedIndexChanged" OnRowDeleted="gvPatients_RowDeleted">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                    <asp:BoundField DataField="PatientID" HeaderText="환자ID" InsertVisible="False" ReadOnly="True" SortExpression="PatientID" />
                    <asp:BoundField DataField="LastName" HeaderText="성" SortExpression="LastName" />
                    <asp:BoundField DataField="FirstName" HeaderText="이름" SortExpression="FirstName" />
                    <asp:BoundField DataField="Address" HeaderText="주소" SortExpression="Address" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
		    </asp:GridView>
		    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:patientsConnectionString %>" DeleteCommand="DELETE FROM [Patients] WHERE [PatientID] = ?" InsertCommand="INSERT INTO [Patients] ([LastName], [FirstName], [Address]) VALUES (?, ?, ?)" ProviderName="<%$ ConnectionStrings:patientsConnectionString.ProviderName %>" SelectCommand="SELECT [PatientID], [LastName], [FirstName], [Address] FROM [Patients]" UpdateCommand="UPDATE [Patients] SET [LastName] = ?, [FirstName] = ?, [Address] = ? WHERE [PatientID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="PatientID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                
                </UpdateParameters>
            </asp:SqlDataSource>
		    <asp:Label ID="lblDeletePatientFailure" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red" Text="Label" Visible="False"></asp:Label>
            <br />
            <asp:Button runat="server" Text="입력" OnClick="Unnamed1_Click" />
                &nbsp;성
            <asp:TextBox ID="txtLName" runat="server" Width="75px"></asp:TextBox>
                &nbsp;이름
            <asp:TextBox ID="txtFName" runat="server" Width="75px"></asp:TextBox>
                &nbsp;주소
            <asp:TextBox ID="txtAddress" runat="server" Width="150px"></asp:TextBox>
            <br />
            <p>
                총요금:
                <asp:Label ID="lblTotalCharges" runat="server" Font-Bold="True" 
                    ForeColor="Red" Text=""></asp:Label><br />
            </p>

            <hr />
            <p>
                <strong>방문 - </strong>
                <asp:Label ID="lblPatient" runat="server" 
                    Text="" Font-Bold="True" 
                    ForeColor="Red"></asp:Label>
            </p>
            <p>
                <asp:GridView ID="gvVisits" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="VisitID" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvVisits_SelectedIndexChanged" OnRowDeleted="gvVisits_RowDeleted">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="VisitID" HeaderText="방문ID" InsertVisible="False" ReadOnly="True" SortExpression="VisitID" />
                        <asp:BoundField DataField="VisitDate" HeaderText="방문날짜" SortExpression="VisitDate" />
                        <asp:BoundField DataField="Charge" HeaderText="요금" SortExpression="Charge" />
                        <asp:BoundField DataField="Notes" HeaderText="증상" SortExpression="Notes" />
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
			    </asp:GridView>
			    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
                    DeleteCommand="DELETE FROM [Visits] WHERE [VisitID] = ?" 
                    InsertCommand="INSERT INTO [Visits] ([PatientID], [VisitDate], [Charge], [Notes]) VALUES (?, ?, ?, ?)" 
                    ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>" 
                    SelectCommand="SELECT [VisitID], [VisitDate], [Charge], [Notes] FROM [Visits] WHERE ([PatientID] = ?)" 
                    UpdateCommand="UPDATE [Visits] SET [VisitDate] = ?, [Charge] = ?, [Notes] = ? WHERE [VisitID] = ?">
                    <DeleteParameters>
                        <asp:Parameter Name="VisitID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="PatientID" Type="Int32" />
                        <asp:Parameter Name="VisitDate" Type="String" />
                        <asp:Parameter Name="Charge" Type="Decimal" />
                        <asp:Parameter Name="Notes" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvPatients" Name="PatientID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="VisitDate" Type="String"/>
                        <asp:Parameter Name="Charge" Type="Decimal" />
                        <asp:Parameter Name="Notes" Type="String" />
                        <asp:Parameter Name="VisitID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>
			    <asp:Label ID="lblDeleteVisitFailure" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red" Text="Label" Visible="False"></asp:Label>
            </p>
            <p>
            <asp:Button ID="btnAddVisit" runat="server" Text="입력" OnClick="btnAddVisit_Click" />
                &nbsp;날짜
            <asp:TextBox ID="txtDate" runat="server" Width="75px"></asp:TextBox>
                &nbsp;요금
            <asp:TextBox ID="txtCharge" runat="server" Width="75px"></asp:TextBox>
                &nbsp;증상
            <asp:TextBox ID="txtNotes" runat="server" Width="150px"></asp:TextBox>
            </p><hr />

            <p>
                <strong>처방 - </strong>
                <asp:Label ID="lblVisitDate" runat="server" Text="" 
                    Font-Bold="True" ForeColor="Red"></asp:Label>
            </p>
            <p>
                <asp:GridView ID="gvPrescriptions" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="PrescriptionID" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="PrescriptionID" HeaderText="처방ID" InsertVisible="False" ReadOnly="True" SortExpression="PrescriptionID" />
                        <asp:BoundField DataField="DrugName" HeaderText="약" SortExpression="DrugName" />
                        <asp:BoundField DataField="Instructions" HeaderText="복용법" SortExpression="Instructions" />
                    </Columns>
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
			    </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString3 %>" 
                    DeleteCommand="DELETE FROM [Prescriptions] WHERE [PrescriptionID] = ?" 
                    InsertCommand="INSERT INTO [Prescriptions] ([PatientID], [VisitID], [DrugName], [Instructions]) VALUES (?, ?, ?, ?)" 
                    ProviderName="<%$ ConnectionStrings:ConnectionString3.ProviderName %>" 
                    SelectCommand="SELECT [PrescriptionID], [DrugName], [Instructions] FROM [Prescriptions] WHERE ([VisitID] = ?)" 
                    UpdateCommand="UPDATE [Prescriptions] SET [DrugName] = ?, [Instructions] = ? WHERE [PrescriptionID] = ?">
                    <DeleteParameters>
                        <asp:Parameter Name="PrescriptionID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="PatientID" Type="Int32" />
                        <asp:Parameter Name="VisitID" Type="Int32" />
                        <asp:Parameter Name="DrugName" Type="String" />
                        <asp:Parameter Name="Instructions" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvVisits" Name="VisitID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DrugName" Type="String" />
                        <asp:Parameter Name="Instructions" Type="String" />
                        <asp:Parameter Name="PrescriptionID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </p>
            <p>
            <asp:Button ID="btnAddPrescriptions" runat="server" Text="입력" OnClick="btnAddPrescriptions_Click" />
                &nbsp;약
            <asp:TextBox ID="txtDrugName" runat="server" Width="75px"></asp:TextBox>
                &nbsp;복용법
            <asp:TextBox ID="txtInstructions" runat="server" Width="170px"></asp:TextBox>
                &nbsp;</p><hr />
        </div>
    </form>
</body>

</html>

