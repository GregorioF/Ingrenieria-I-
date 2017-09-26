using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace C2_PortfolioTreePrinter_Exercise
{
    class Portfolio : SummarizingAccount
    {
        public static String ACCOUNT_NOT_MANAGED = "No se maneja esta cuenta";
        public static String ACCOUNT_ALREADY_MANAGED = "La cuenta ya está manejada por otro portfolio";
        private IList<SummarizingAccount> summarizingAccounts;

        public static Portfolio createWith(SummarizingAccount anAccount)
        {
            Portfolio portfolio = new Portfolio();
            portfolio.add(anAccount);
            
            return portfolio;
        }

        public static Portfolio createWith(SummarizingAccount anAccount1, SummarizingAccount anAccount2)
        {
            Portfolio portfolio = new Portfolio();
            portfolio.add(anAccount1);
            portfolio.add(anAccount2);

            return portfolio;
        }

        public void add(SummarizingAccount account)
        {
            if (manages(account))
                throw new Exception(ACCOUNT_ALREADY_MANAGED);

            this.summarizingAccounts.Add(account);
        }


        public Portfolio()
        {
            this.summarizingAccounts = new List<SummarizingAccount>();
        }

        public double balance()
        {
            return summarizingAccounts.Sum(summarizingAccount => summarizingAccount.balance());
        }

        public bool registers(AccountTransaction transaction)
        {
            return summarizingAccounts.Any(summarizingAccount => summarizingAccount.registers(transaction));
        }

        public bool manages(SummarizingAccount account)
        {
            return this == account || summarizingAccounts.Any(summarizingAccount => summarizingAccount.manages(account));
        }

        public IList<AccountTransaction> transactions()
        {
            List<AccountTransaction> transactions = new List<AccountTransaction>();
            foreach (SummarizingAccount summarizingAccount in summarizingAccounts)
                transactions.AddRange(summarizingAccount.transactions());

            return transactions;

        }
    }
}
