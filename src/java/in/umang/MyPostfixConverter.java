package in.umang;

import java.util.LinkedList;
import java.util.List;

public class MyPostfixConverter
{

    private static int precedence(MyStackElement operator)
    {
        int precedence = 0;
        if (operator.equals("&") || operator.equals("|"))
        {
            precedence = 1;
        }
        return precedence;
    }

    /* refer to the typical postfix conversion from popular datastructure book*/
    public static List<MyStackElement> convert(List<MyStackElement> infix)
    {
        java.util.Stack<MyStackElement> stack = new java.util.Stack<MyStackElement>();
        List<MyStackElement> postfix = new LinkedList<MyStackElement>();
        String space = " ";
        //java.util.StringTokenizer st=new java.util.StringTokenizer(infix);
        for (int i = 0; i < infix.size(); i++)
        {
            MyStackElement token = infix.get(i);

            // if is number
            if (token.isNumber())
            {
                postfix.add(token);

            } // if opening brace
            else if (token.isOpeningBrace())
            {
                //  postfix.add(token);
//                stack.push(token);
            } // if operator
            else if (token.isAnd() || token.isOr())
            {
                while (!stack.empty() && precedence(stack.peek()) >= precedence(token))
                {
                    MyStackElement e = stack.pop();
                    if (!e.isOpeningBrace())
                    {
                        postfix.add(e);
                    }
                }
                stack.push(token);
            }
            else if (token.isClosingBrace())
            {
                do
                {
                    if (stack.isEmpty())
                    {
                        break;
                    }
                    postfix.add(stack.pop());
                }
                while ((!stack.isEmpty()) && !stack.peek().isOpeningBrace());

            }
        }

        while (!stack.empty())
        {
            postfix.add(stack.pop());
        }
        return postfix;
    }
}