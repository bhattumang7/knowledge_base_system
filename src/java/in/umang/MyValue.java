/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.umang;

/**
 *
 * @author umang
 */
public class MyValue implements MyStackElement
{

    public long value;
    public boolean present ;
    
    public void setPresent(boolean present)
    {
        this.present = present;
    }
    public boolean isPresent()
    {
        return this.present;
    }
           
    
    public MyValue(long value)
    {
        this.value = value;
    }

    @Override
    public boolean isOpeningBrace()
    {
        return false;
    }

    @Override
    public boolean isNumber()
    {
        return true;
    }

    @Override
    public boolean isSymbol()
    {
        return false ;
    }

    @Override
    public boolean isAnd()
    {
        return false ;
    }

    @Override
    public boolean isOr()
    {
        return false ;
    }

    @Override
    public boolean isClosingBrace()
    {
        return false ;
    }
    
    @Override
    public Object getValue()
    {
        return new Long(value);
    }
     @Override
    public char getCharValue()
    {
        return '0';
    }
    @Override
    public String toString()
    {
        return new Long(value).toString();
    }
}
