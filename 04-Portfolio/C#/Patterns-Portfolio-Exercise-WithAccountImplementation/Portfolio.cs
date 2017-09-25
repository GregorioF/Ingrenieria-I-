using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Patterns_Portfolio_Exercise_WithAccountImplementation
{
    class Portfolio: SummarizingAccount
    {

    	public static String ACCOUNT_NOT_MANAGED = "No se maneja esta cuenta";
	    public static String ACCOUNT_ALREADY_MANAGED = "La cuenta ya estÃ¡ manejada por otro portfolio";

        private List<SummarizingAccount> m_accounts ;
	
	    public static Portfolio createWith(SummarizingAccount anAccount1, SummarizingAccount anAccount2) {
            List<SummarizingAccount> accounts = new List<SummarizingAccount>() { anAccount1, anAccount2 };
            return Portfolio.createWith(accounts);
	    }

    	public static Portfolio createWith(List<SummarizingAccount> summarizingAccounts) {
            bool hayDuplicados = false;
            summarizingAccounts.ForEach( account1 => hayDuplicados = hayDuplicados || summarizingAccounts.Where(account2 => account2.manages(account1)).ToList().Count > 1);

            if (hayDuplicados) throw new Exception(ACCOUNT_ALREADY_MANAGED);



            Portfolio res = new Portfolio();
            res.m_accounts = new List<SummarizingAccount>(summarizingAccounts);
            return res;
        }
	
    	public double balance() {
            return m_accounts.Sum(account => account.balance());
	    }
	
	    public bool registers(AccountTransaction transaction) {
            bool res = false;
            m_accounts.ForEach(acount => res = acount.registers(transaction) || res);
            return res;
    	}

        public bool manages(SummarizingAccount account)
        {
            if (account == this) return true;

            bool res = false;
            m_accounts.ForEach(acount => res = acount.manages(account) || res);
            return res;
        }

        public List<AccountTransaction> transactionsOf(SummarizingAccount account) {
            if( !manages(account))
            {
                throw new Exception(ACCOUNT_NOT_MANAGED);
            }
            return account.transactions();
	    }
	
	
	    public List<AccountTransaction> transactions() {
            List<AccountTransaction> res = new List<AccountTransaction>();
            m_accounts.ForEach(account => res.AddRange(account.transactions()));
            return res;
    	}
    }
}
