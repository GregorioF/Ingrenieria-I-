using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise.Extensiones
{
    static class InvestemtsExtensions
    {
        

        static public double AfectInvestmentBy(this AccountTransaction transaction)
        {
            Type type = transaction.GetType();
            if (type == typeof(CertificateOfDeposit) )
            {
                return transaction.value();
            }
            else
            {
                return 0;
            }
        }

        static public double AfectInvestmentEarningBy(this AccountTransaction transaction)
        {
            Type type = transaction.GetType();
            if (type == typeof(CertificateOfDeposit))
            {
                return ((CertificateOfDeposit)transaction).earnings();
            }
            else
            {
                return 0;
            }
        }
        


    }
    
}
