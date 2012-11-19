package in.umang;


/**
 *
 * @author umang
 */
public class StringOperations
{
    public static String removeAllSpaces(String originalString )
    {
        String newString = new String();
        for(int i =0 ; i < originalString.length(); i++ )
        {
            if(originalString.charAt(i)!=' ' )
            {
                newString += originalString.charAt(i);
            }
            
        }
        return newString;
    }
}

