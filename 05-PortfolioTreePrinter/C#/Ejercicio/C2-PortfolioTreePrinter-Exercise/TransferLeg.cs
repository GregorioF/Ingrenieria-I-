using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    interface TransferLeg: AccountTransaction
    {
        Transfer transfer();
    }
}
