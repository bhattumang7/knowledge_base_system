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
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author umang
 */
public class Disease
{

    private long diseaseId;
    private String diseaseName;
    private Set<Medicine> medicines;
    private String rule;

    public Set<Medicine> getMedicines()
    {
        return medicines;
    }

    public void setMedicines(Set<Medicine> medicines)
    {
        this.medicines = medicines;
    }

    public String getDiseaseName()
    {
        return diseaseName;
    }

    public void setDiseaseName(String diseaseName)
    {
        this.diseaseName = diseaseName;
    }

    public long getDiseaseId()
    {
        return diseaseId;
    }

    public void setDiseaseId(long diseaseId)
    {
        this.diseaseId = diseaseId;
    }

    public String getRule()
    {
        return rule;
    }

    public void setRule(String rule)
    {
        this.rule = rule;
    }

    public void save() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();
        String sql = "INSERT INTO  `wdaj`.`disease` (`diseaseId` ,`diseaseName` ,`rule`)VALUES (NULL ,  '" + diseaseName + "',  '" + rule + "');";
        int noOfRowsAffected = insertStatement.executeUpdate(sql);
    }

    public void update()
    {
        throw new RuntimeException("not yet supported");
    }

    public static Disease getDiseaseById(long diseaseId) throws SQLException, NoSuchRecordException
    {
        Disease aDisease = new Disease();

        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from disease where diseaseId=" + diseaseId);
        while (aResultSet.next())
        {
            aDisease.setDiseaseId(aResultSet.getLong("	diseaseId"));
            aDisease.setDiseaseName(aResultSet.getString("diseaseName"));
            aDisease.setRule(aResultSet.getString("rule"));
        }
        if (aDisease == null)
        {
            throw new NoSuchRecordException();
        }
        return aDisease;
    }

    public static List<Disease> getDiseaseList() throws SQLException
    {
        List<Disease> aDiseaseList = new LinkedList<Disease>();

        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from disease where deleted=0");
        while (aResultSet.next())
        {
            Disease aDisease = new Disease();
            aDisease.setDiseaseId(aResultSet.getLong("diseaseId"));
            aDisease.setDiseaseName(aResultSet.getString("diseaseName"));
            aDisease.setRule(aResultSet.getString("rule"));
            aDiseaseList.add(aDisease);
        }
        return aDiseaseList;
    }

    private List<Long> getSymptomIdsFromRule(String rule)
    {
        List<Long> aLongList = new LinkedList<Long>();
        Pattern p = Pattern.compile("[0-9]+");
        Matcher m = p.matcher(rule);
        while (m.find())
        {
            aLongList.add(new Long(m.group()));
        }
        return aLongList;
    }

    
    public String getSymptomAsViewableString()
    {
        String aString = rule;
        List<Long> symptomIdList = getSymptomIdsFromRule(rule);
        for (Long symptomId : symptomIdList)
        {
            try
            {
                aString = aString.replaceAll(symptomId.toString(), Symptom.getSymptomById(symptomId).getSymptomName());
            }
            catch (SQLException ex)
            {
                Logger.getLogger(Disease.class.getName()).log(Level.SEVERE, null, ex);
            }
            catch (NoSuchRecordException ex)
            {
                Logger.getLogger(Disease.class.getName()).log(Level.SEVERE, null, ex);
            }
            System.out.println(aString);
        }

        return aString;
    }
    public void delete() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement updateStatement = aConnection.createStatement();
        String sql = "UPDATE  `wdaj`.`disease` SET  `deleted` =  '1' WHERE  `disease`.`diseaseId` ="+ diseaseId ;
        int noOfRowsAffected = updateStatement.executeUpdate(sql);
    }
}
