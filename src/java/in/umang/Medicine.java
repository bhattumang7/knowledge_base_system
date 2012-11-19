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
enum MedicineType
{

    tablet, liquid, injection
}

public class Medicine
{

    private long medicineId;
    private String medicineName;
    private MedicineType medicineType;

    public long getMedicineId()
    {
        return medicineId;
    }

    public void setMedicineId(long medicineId)
    {
        this.medicineId = medicineId;
    }

    public String getMedicineName()
    {
        return medicineName;
    }

    public void setMedicineName(String medicineName)
    {
        this.medicineName = medicineName;
    }

    public MedicineType getMedicineType()
    {
        return medicineType;
    }

    public void setMedicineType(MedicineType medicineType)
    {
        this.medicineType = medicineType;
    }

    public static Medicine getMedicineById(long medicineId) throws SQLException, NoSuchRecordException
    {
        Medicine aMedicine = new Medicine();

        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from medicine where medicineId=" + medicineId);
        while (aResultSet.next())
        {
            aMedicine.setMedicineId(aResultSet.getLong("medicineId"));
            aMedicine.setMedicineName(aResultSet.getString("medicineName"));
          //  aMedicine.setQuantity(aResultSet.getFloat("quantity"));
            aMedicine.setMedicineType(MyMedicineTypeUtil.getMedicineTypeById(aResultSet.getLong("MedicineType")));
        }
        if (aMedicine == null)
        {
            throw new NoSuchRecordException();
        }
        return aMedicine;
    }

    public static List<Medicine> getMedicineList() throws SQLException
    {
        List<Medicine> aMedicineList = new LinkedList<Medicine>();

        Connection aConnection = Database.getConnection();
        Statement getAllStatement = aConnection.createStatement();
        ResultSet aResultSet = getAllStatement.executeQuery("select * from medicine where deleted=0");
        while (aResultSet.next())
        {
            Medicine aMedicine = new Medicine();
            aMedicine.setMedicineId(aResultSet.getLong("medicineId"));
            aMedicine.setMedicineName(aResultSet.getString("medicineName"));
         //   aMedicine.setQuantity(aResultSet.getFloat("quantity"));
            aMedicine.setMedicineType(MyMedicineTypeUtil.getMedicineTypeById(aResultSet.getLong("MedicineType")));
            aMedicineList.add(aMedicine);
        }
        return aMedicineList;
    }

    public void update() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();
        String sql = "UPDATE  `wdaj`.`medicine` SET  `medicineName` =  '" + medicineName + "', `medicineType` =  '" + MyMedicineTypeUtil.getIdForMedicineType(medicineType) + "' WHERE  `medicine`.`medicineId` =" + medicineId + ";";
        int noOfRowsAffected = insertStatement.executeUpdate(sql);

    }

    public void save() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        String sql = "INSERT INTO  `wdaj`.`medicine` (`medicineId` ,`medicineName` , `medicineType`, deleted)VALUES (NULL ,  '" + this.medicineName + "',  '" + MyMedicineTypeUtil.getIdForMedicineType(medicineType) + "', 0);";
        Statement insertStatement = aConnection.createStatement();

        int noOfRowsAffected = insertStatement.executeUpdate(sql);


    }
    
    public void delete() throws SQLException
    {
        Connection aConnection = Database.getConnection();
        Statement insertStatement = aConnection.createStatement();
        String sql = "UPDATE medicine SET  deleted =  '1' WHERE  medicineId =" + medicineId ;
        int noOfRowsAffected = insertStatement.executeUpdate(sql);


    }
}
