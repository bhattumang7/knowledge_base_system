package in.umang;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author umang
 */
public class MedicineForDisease
{
    
    private long id;
    private long diseaseId;
    private long medicineId;
    private long timesADay;
    private float quantity;
    
    public long getId()
    {
        return id;
    }
    
    public void setId(long id)
    {
        this.id = id;
    }
    
    public long getDiseaseId()
    {
        return diseaseId;
    }
    
    public void setDiseaseId(long diseaseId)
    {
        this.diseaseId = diseaseId;
    }
    
    public long getMedicineId()
    {
        return medicineId;
    }
    
    public void setMedicineId(long medicineId)
    {
        this.medicineId = medicineId;
    }
    
    public long getTimesADay()
    {
        return timesADay;
    }
    
    public void setTimesADay(long timesADay)
    {
        this.timesADay = timesADay;
    }
    
    public float getQuantity()
    {
        return quantity;
    }
    
    public void setQuantity(float quantity)
    {
        this.quantity = quantity;
    }
    
    public void save() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();
        String sql = "INSERT INTO  `wdaj`.`medicinefordisease` (`id`,`diseaseId` ,`medicineId` ,`times_a_day` ,`quantity`)VALUES (NULL , '"+ diseaseId +"', '" + medicineId + "',  '" + timesADay + "',  '" + quantity + "')";
        int noOfRowsAffected = insertStatement.executeUpdate(sql);
    }
    
    public void delete() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();
        String sql = "delete from `wdaj`.`medicinefordisease` where `id`=" + this.id;
        int noOfRowsAffected = insertStatement.executeUpdate(sql);
    }
    
    public static List<MedicineForDisease> getMedicineForDiseaseByDiseaseId(long diseaseId) throws SQLException
    {
        List<MedicineForDisease> aList = new LinkedList<MedicineForDisease>();
        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("SELECT * FROM  `medicinefordisease` where diseaseId=" + diseaseId);
        while (aResultSet.next())
        {
            MedicineForDisease m = new MedicineForDisease();
            m.setId(aResultSet.getLong("id"));
            m.setDiseaseId(aResultSet.getLong("diseaseId"));
            m.setMedicineId(aResultSet.getLong("medicineId"));
            m.setTimesADay(aResultSet.getLong("times_a_day"));
            m.setQuantity(aResultSet.getFloat("quantity"));
            aList.add(m);
        }
        return aList;
    }
    public static MedicineForDisease getByd(long id) throws SQLException
    {
         MedicineForDisease m = new MedicineForDisease();
        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("SELECT * FROM  `medicinefordisease` where id=" + id);
        while (aResultSet.next())
        {
            
            m.setId(aResultSet.getLong("id"));
            m.setDiseaseId(aResultSet.getLong("diseaseId"));
            m.setMedicineId(aResultSet.getLong("medicineId"));
            m.setTimesADay(aResultSet.getLong("times_a_day"));
            m.setQuantity(aResultSet.getFloat("quantity"));
         
        }
        return m;
    }
}
