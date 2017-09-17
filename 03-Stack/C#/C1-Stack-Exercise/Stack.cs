/*
 * Developed by 10Pines SRL
 * License: 
 * This work is licensed under the 
 * Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
 * California, 94041, USA.
 *  
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C1_Stack_Exercise
{
    interface IStack
    {
        IStack push(Object anObject);

        IStack pop(out Object result);

        Object top();

        bool isEmpty();

        int size();
    }


    class StackVacio : IStack
    {
        public static String STACK_EMPTY_DESCRIPTION = "Stack is Empty";

        public StackVacio() { }

        public bool isEmpty()
        {
            return true;
        }

        public IStack pop(out Object result)
        {
            throw new Exception(STACK_EMPTY_DESCRIPTION);
        }

        public IStack push(object anObject)
        {
            return new StackNoVacio(this, anObject, 0 );
        }

        public int size()
        {
            return 0;
        }

        public Object top()
        {
            throw new Exception(STACK_EMPTY_DESCRIPTION);
        }
    }

    class StackNoVacio : IStack
    {
        private IStack _anteriorStack;
        private Object _value;
        private int _size;

        public StackNoVacio(IStack stack, Object value, int size)
        {
            _anteriorStack = stack;
            _value = value;
            _size = size + 1;
        }

        public bool isEmpty()
        {
            return false;
        }

        public IStack pop(out Object result)
        {
            result = _value;
            return _anteriorStack;
        }

        public IStack push(object anObject)
        {
            return new StackNoVacio(this, anObject, _size);
        }

        public int size()
        {
            return _size;
        }

        public Object top()
        {
            return _value;
        }
    }

    class Stack
    {
        public static  String STACK_EMPTY_DESCRIPTION = "Stack is Empty";

        private IStack _stack;

	    public Stack () {
            _stack = new StackVacio();
	    }
	
	    public void push (Object anObject)	{
            _stack = _stack.push(anObject);
	    }
	
	    public Object pop()	{
            Object result;
            _stack = _stack.pop(out result);
            return result;
        }
	
	    public Object top()	{
            Object result = _stack.top();
            return result;
        }

	    public bool isEmpty()	{
            return _stack.isEmpty();
        }

	    public int size() {
            return _stack.size();
        }
   }
}
