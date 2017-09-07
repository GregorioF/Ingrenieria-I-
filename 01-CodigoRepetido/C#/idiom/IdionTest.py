#
# Developed by 10Pines SRL
# License: 
# This work is licensed under the 
# Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ 
# or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, 
# California, 94041, USA.
#  
import unittest
import time

            
def assertRunningCodeTakesLessThan(test, runningCode, timeLimit):
    timeBeforeRunning = time.time()
    runningCode()
    timeAfterRunning = time.time()
    return test.assertTrue( (timeAfterRunning - timeBeforeRunning)*1000 < timeLimit )

def assertCannotDoCode(test, aCodeShouldNotWork, kindOfError, aMessageError, aCodeForGaranteeInvariant):
	try:
		aCodeShouldNotWork()
		test.fail()
	except kindOfError as exception:
		test.assertEquals(exception.message,aMessageError)
		aCodeForGaranteeInvariant(test)

class CustomerBook:
    
    CUSTOMER_NAME_CAN_NOT_BE_EMPTY = 'Customer name can not be empty'
    CUSTOMER_ALREADY_EXIST = 'Customer already exists'
    INVALID_CUSTOMER_NAME = 'Invalid customer name'
    
    def __init__(self):
        self.customerNames = set()
    
    def addCustomerNamed(self,name):
        #El motivo por el cual se hacen estas verificaciones y se levanta esta excepcion es por motivos del
        #ejercicio - Hernan.
        if not name:
            raise ValueError(self.__class__.CUSTOMER_NAME_CAN_NOT_BE_EMPTY)
        if self.includesCustomerNamed(name):
            raise ValueError(self.__class__.CUSTOMER_ALREADY_EXIST)
        
        self.customerNames.add(name)
        
    def isEmpty(self):
        return self.numberOfCustomers()==0
    
    def numberOfCustomers(self):
        return len(self.customerNames)
    
    def includesCustomerNamed(self,name): 
        return name in self.customerNames
    
    def removeCustomerNamed(self,name):
        #Esta validacion mucho sentido no tiene, pero esta puesta por motivos del ejericion - Hernan
        if not self.includesCustomerNamed(name):
            raise KeyError(self.__class__.INVALID_CUSTOMER_NAME)
        
        self.customerNames.remove(name)

class IdionTest(unittest.TestCase):
    def testAddingCustomerShouldNotTakeMoreThan50Milliseconds(self):
        customerBook = CustomerBook()
        
        def runningCode():
			return customerBook.addCustomerNamed('John Lennon')
        assertRunningCodeTakesLessThan(self, runningCode, 50)

    def testRemovingCustomerShouldNotTakeMoreThan100Milliseconds(self):
        customerBook = CustomerBook()
        paulMcCartney = 'Paul McCartney'
        customerBook.addCustomerNamed(paulMcCartney)
        def runningCode():
			return customerBook.removeCustomerNamed(paulMcCartney)
        assertRunningCodeTakesLessThan(self, runningCode, 100)

    def testCanNotAddACustomerWithEmptyName(self):
        customerBook = CustomerBook()
        
        def aCodeShouldNotWork():
            customerBook.addCustomerNamed('')
        def aCodeForGaranteeInvariant(test):
			test.assertTrue(customerBook.isEmpty())
        assertCannotDoCode(self, aCodeShouldNotWork, ValueError, customerBook.CUSTOMER_NAME_CAN_NOT_BE_EMPTY, aCodeForGaranteeInvariant)
                 
    def testCanNotRemoveNotAddedCustomer(self):
        customerBook = CustomerBook()
        customerBook.addCustomerNamed('Paul McCartney')
        
        def aCodeShouldNotWork():
            customerBook.removeCustomerNamed('John Lennon')
        def aCodeForGaranteeInvariant(test):
            test.assertTrue(customerBook.numberOfCustomers()==1)
            test.assertTrue(customerBook.includesCustomerNamed('Paul McCartney'))
        assertCannotDoCode(self, aCodeShouldNotWork, KeyError, customerBook.INVALID_CUSTOMER_NAME, aCodeForGaranteeInvariant)

 

		
		




      
if __name__ == "__main__":
    unittest.main()


