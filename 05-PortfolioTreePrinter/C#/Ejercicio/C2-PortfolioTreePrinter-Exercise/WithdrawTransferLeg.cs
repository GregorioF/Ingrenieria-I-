using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class WithdrawTransferLeg : TransferLeg
    {

        private Transfer _transfer;

        public static WithdrawTransferLeg registerForOn(double value, ReceptiveAccount fromAccount, Transfer transfer)
        {
            WithdrawTransferLeg deposit = new WithdrawTransferLeg(transfer);
            fromAccount.register(deposit);
            return deposit;
        }

        public WithdrawTransferLeg(Transfer transfer)
        {
            _transfer = transfer;
        }

        public double value()
        {
            return _transfer.value();
        }

        public double AfectAccountBalanceIn()
        {
            return _transfer.value() * -1 ;
        }

        public Transfer transfer()
        {
            return _transfer;
        }
    }
}
