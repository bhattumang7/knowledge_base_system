/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.umang;

/**
 *
 * @author umang
 */
public class MySymbol implements MyStackElement
{

    char symbol;

    public MySymbol(char symbol)
    {
        this.symbol = symbol;
    }

    @Override
    public boolean isOpeningBrace()
    {
        return symbol == '(';
    }

    @Override
    public boolean isNumber()
    {
        return false;
    }

    @Override
    public boolean isSymbol()
    {
        return symbol == '&' || symbol == '|';
    }

    @Override
    public boolean isAnd()
    {
        return symbol == '&';
    }

    @Override
    public boolean isOr()
    {
        return symbol == '|';
    }

    @Override
    public boolean isClosingBrace()
    {
        return symbol == ')';
    }

    @Override
    public Object getValue()
    {
        return symbol;
    }
    
    @Override
    public char getCharValue()
    {
        return symbol;
    }
    
    @Override
    public String toString()
    {
        return symbol + "";
    }
}
