using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class Transfer 
    {
        private double m_value;
        private ReceptiveAccount _fromAccount;
        private ReceptiveAccount _toAccount;
        private WithdrawTransferLeg _withdrawTransferLeg;
        private DepositTransferLeg _depositTransferLeg;

        public Transfer(double value, ReceptiveAccount fromAccount,
                ReceptiveAccount toAccount)
        {
            m_value = value;
            _fromAccount = fromAccount;
            _toAccount = toAccount;
        }

        public static Transfer registerFor(double value, ReceptiveAccount fromAccount,
                ReceptiveAccount toAccount)
        {
            Transfer transfer = new Transfer(value, fromAccount, toAccount);
            transfer._withdrawTransferLeg = WithdrawTransferLeg.registerForOn(value, fromAccount, transfer);
            transfer._depositTransferLeg = DepositTransferLeg.registerForOn(value, toAccount, transfer);
            return transfer;
        }

        public double value()
        {
            return m_value;
        }

        public TransferLeg depositLeg()
        {
            return _depositTransferLeg;
        }

        public TransferLeg withdrawLeg()
        {
            return _withdrawTransferLeg;
        }
    }
}
