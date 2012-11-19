/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.umang;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

/**
 *
 * @author umang
 */
public class Symptom
{

    private long symptomID;
    private String symptomName;

    public Symptom()
    {
    }

    public long getSymptomID()
    {
        return symptomID;
    }

    public void setSymptomID(long symptomID)
    {
        this.symptomID = symptomID;
    }

    public String getSymptomName()
    {
        return symptomName;
    }

    public void setSymptomName(String symptomName)
    {
        this.symptomName = symptomName;
    }

    public static void deleteById(long id) throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();

        int noOfRowsAffected = insertStatement.executeUpdate("UPDATE  `wdaj`.`symptom` SET  `deleted` =  '1' WHERE  `symptom`.`symptomID` =" + id + " ;");
        aConnection.close();
    }

    public void save() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();

        int noOfRowsAffected = insertStatement.executeUpdate("INSERT INTO  symptom (symptomID ,symptomName)VALUES (NULL ,  '" + symptomName + "')");
        aConnection.close();;
    }

    public static Symptom getSymptomById(long id) throws SQLException, NoSuchRecordException
    {
        Symptom aSymptom = new Symptom();

        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from symptom where symptomID=" + id);
        while (aResultSet.next())
        {
            aSymptom.setSymptomID(aResultSet.getLong("symptomID"));
            aSymptom.setSymptomName(aResultSet.getString("symptomName"));

        }
        if (aSymptom == null)
        {
            throw new NoSuchRecordException();
        }
        return aSymptom;
    }

    public static List<Symptom> getSymptomList() throws SQLException
    {

        List<Symptom> symptomList = new LinkedList<Symptom>();
        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from symptom where deleted=0");
        while (aResultSet.next())
        {
            long symptomId = aResultSet.getLong("symptomID");
            String symptomName = aResultSet.getString("symptomName");

            Symptom aSymptom = new Symptom();

            aSymptom.setSymptomID(symptomId);
            aSymptom.setSymptomName(symptomName);

            symptomList.add(aSymptom);
        }
        aConnection.close();;
        return symptomList;
    }

    public void update() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();

        int noOfRowsAffected = insertStatement.executeUpdate("UPDATE  `wdaj`.`symptom` SET  `symptomName` =  '" + this.symptomName + "' WHERE  `symptom`.`symptomID` =" + this.symptomID);

    }

    public static void main(String args[]) throws SQLException
    {
        Symptom s = new Symptom();
        s.setSymptomName("asdf1");
        s.save();
    }
}
