using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise.Extensiones
{
    static class TransfersExtensions
    {
        

        static public double AfectNetBy(this AccountTransaction transaction)
        {
            Type type = transaction.GetType();
            if (type == typeof(DepositTransferLeg) || type == typeof(WithdrawTransferLeg))
            {
                return transaction.AfectAccountBalanceIn();
            }
            else
            {
                return 0;
            }
        }
        


    }
    
}
