using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class DepositTransferLeg : TransferLeg
    {

        private Transfer _transfer;

        public static DepositTransferLeg registerForOn(double value, ReceptiveAccount toAccount, Transfer transfer)
        {
            DepositTransferLeg deposit = new DepositTransferLeg(transfer);
            toAccount.register(deposit);
            return deposit;
        }

        public DepositTransferLeg(Transfer transfer)
        {
            _transfer = transfer;
        }

        public double value()
        {
            return _transfer.value();
        }

        public double AfectAccountBalanceIn()
        {
            return _transfer.value();
        }

        public Transfer transfer()
        {
            return _transfer;
        }
    }
}
