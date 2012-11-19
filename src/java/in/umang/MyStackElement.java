/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.umang;

/**
 *
 * @author umang
 */
public interface MyStackElement
{
    boolean isOpeningBrace();
    boolean isNumber();
    boolean isSymbol();
    boolean isAnd();
    boolean isOr();
    boolean isClosingBrace();
    char getCharValue();
    Object getValue();
}
