package in.umang;

import java.util.LinkedList;
import java.util.List;
import java.util.Stack;

/**
 *
 * @author umang
 */
public class RuleChecker
{

    public static boolean ruleMatches(List<MyStackElement> postfix, List<Long> values)
    {


        // add all the numbers from postfix to the set
        LinkedList<Long> set1 = new LinkedList<Long>();
        for (MyStackElement ele1 : postfix)
        {
            if (ele1.isNumber())
            {
                Long l = Long.parseLong(ele1.getValue().toString());
                set1.add(l);
            }
        }

        boolean matches = false;
        RuleChecker.convertToTrueIfMatch(postfix, values);

        Stack<MyStackElement> aStack = new Stack<MyStackElement>();

        // iterate thru all the elements
        for (MyStackElement postfixElement : postfix)
        {
            // if number
            if (postfixElement.isNumber())
            {
                aStack.push(postfixElement);
            }
            // if is or or
            else if (postfixElement.isAnd() || postfixElement.isOr())
            {
                MyValue firstValue = (MyValue) aStack.pop();
                MyValue secondValue = (MyValue) aStack.pop();

                // if and
                if (postfixElement.isAnd())
                {
                    // calculate value
                    MyValue myVal = new MyValue(0);
                    myVal.present = firstValue.present && secondValue.present;
                    aStack.push(myVal);
                    matches = myVal.present;

                }
                // if it is or
                else if (postfixElement.isOr())
                {
                    // calculate or value
                    MyValue myVal = new MyValue(0);
                    myVal.present = firstValue.present || secondValue.present;
                    aStack.push(myVal);
                    matches = myVal.present;
                }
            }

        }

        // change here to make the subset of both arguments
        // if both sets do not match then return false
        // comment uncommet this if
        if (allMembsersOfSubsetInSuperset(set1, values) == false)
        {
          //  System.out.println("False in if");
            return false;
        }

        return matches;
    }

    private static void convertToTrueIfMatch(List<MyStackElement> postfix, List<Long> values)
    {
        for (int i = 0; i < postfix.size(); i++)
        {
            MyStackElement postfixElement = postfix.get(i);
            if (postfixElement.isNumber())
            {
                long postfixValue = (Long) postfixElement.getValue();
                MyValue myVal = (MyValue) postfixElement;
                if (isPresenetInList(postfixValue, values))
                {
                    myVal.present = true;
                }
            }
        }
    }

    private static boolean isPresenetInList(long number, List<Long> longList)
    {
        boolean present = false;
        for (Long longValue1 : longList)
        {
            long longValue = longValue1;
            if (longValue == number)
            {
                present = true;
            }
        }
        return present;
    }

    // check fi all elements of subset are present in superset of not
    private static boolean allMembsersOfSubsetInSuperset(List<Long> superSet, List<Long> subSet)
    {
        int found = 0;
        int notFound = 0;
        for (Long sub : subSet)
        {
            boolean isFound = false;
            for (Long sup : superSet)
            {
                if (sup.equals(sub))
                {
                    found++;
                    isFound = true;
                    break;
                }
            }
        }
      //  System.out.println(subSet.size() + " " + found);
        return subSet.size() == found;
    }
}
