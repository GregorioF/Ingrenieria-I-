using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class Deposit : AccountTransaction
    {

        private double m_value;

        public static Deposit registerForOn(double value, ReceptiveAccount account)
        {
            Deposit deposit = new Deposit(value);

            account.register(deposit);

            return deposit;
        }

        public Deposit(double value)
        {
            m_value = value;

        }

        public double value()
        {
            return m_value;
        }

        public double AfectAccountBalanceIn()
        {
            return m_value;
        }

        public string Description()
        {
            return "Depósito por " + ((double)m_value).ToString() + ".0";
        }
    }
}
