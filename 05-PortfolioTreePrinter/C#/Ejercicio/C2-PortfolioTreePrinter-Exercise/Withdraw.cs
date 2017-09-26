using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class Withdraw : AccountTransaction
    {
        private double m_value;

        public static Withdraw registerForOn(double value, ReceptiveAccount account)
        {
            Withdraw withdraw = new Withdraw(value);
            account.register(withdraw);

            return withdraw;
        }

        public Withdraw(double value)
        {
            m_value = value;
        }

        public double value()
        {
            return m_value;
        }

        public double AfectAccountBalanceIn()
        {
            return m_value * -1;
        }
    }
}
