
package in.umang;

import java.util.LinkedList;
import java.util.List;

/**
 * @author umang
 */
public class Rule
{

    private String rule;
    private List<MyStackElement> asList;

    public Rule(String rule)
    {
        rule = StringOperations.removeAllSpaces(rule);
        this.rule = rule;
        asList = getAsList();
    }

    public String getRule()
    {
        return rule;
    }

    public List<MyStackElement> getAsList()
    {
        List<MyStackElement> aList = new LinkedList<MyStackElement>();
        String ruleString = rule;
        for (int i = 0; i < ruleString.length(); i++)
        {
            if (ruleString.charAt(i) == '(' || ruleString.charAt(i) == ')'
                    || ruleString.charAt(i) == '|' || ruleString.charAt(i) == '&')
            {
                aList.add(new MySymbol(ruleString.charAt(i)));
            } else
            {

                String numberString = "";
                try
                {
                    while (Character.isDigit(ruleString.charAt(i)))
                    {
                        numberString += ruleString.charAt(i);
                        i++;
                    }
                } catch (java.lang.StringIndexOutOfBoundsException e)
                {
                }
                i--;

                aList.add(new MyValue(new Long(numberString)));
            }
        }
        return aList;
    }

    public static void main(String args[])
    {
        //Rule r = new Rule("(((10|28) & 14) | 18 ) & 14");
         Rule r = new Rule("(2|3)");
        List<MyStackElement> infix = r.getAsList();
        List<MyStackElement> postfix = MyPostfixConverter.convert(infix);
        /*System.out.println("POstfix: " );
        for(MyStackElement e : postfix)
        {
            System.out.println(e.getValue());
        }
        System.out.println("\nendPOstfix: " );*/
        LinkedList<Long> alist = new LinkedList<Long>();
        //alist.add(10L);
        //alist.add(14L);
        alist.add(1L);
        alist.add(3L);
        System.out.println(RuleChecker.ruleMatches(postfix, alist));
    }
}
