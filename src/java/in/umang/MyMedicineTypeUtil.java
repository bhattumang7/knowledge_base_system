/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.umang;

/**
 *
 * @author umang
 */
public class MyMedicineTypeUtil
{

    public static MedicineType getMedicineTypeById(long id)
    {
        MedicineType type = MedicineType.injection;
        if (id == 0)
        {
            type = MedicineType.injection;
        }
        else if (id == 1)
        {
            type = MedicineType.liquid;
        }
        else if (id == 2)
        {
            type = MedicineType.tablet;
        }
        return type;
    }

    public static long getIdForMedicineType(MedicineType type)
    {
        long id = 0;
        if (MedicineType.injection == type)
        {
            id = 0;
        }
        else if (type == MedicineType.liquid)
        {
            id = 1;
        }
        else if (type == MedicineType.tablet)
        {
            id = 2;
        }
        return id;
    }
}
