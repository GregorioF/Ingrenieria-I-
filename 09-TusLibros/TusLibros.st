!classDefinition: #CardTest category: #TusLibros!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:55:21'!
test01CantCreateCardWithoutOwner

	self should:[Card newFor: '' expires: (Date newDay: 01 month: 11 year: 2022 ) number: 1234]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:error | self assert: Card emptyOwnerMessage = error messageText]! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:53:30'!
test02ANewCardHasAOwnerAndExpiration
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ) number: 1234.
	self assert:[tarjeta expiration = (Date newDay: 01 month: 11 year: 2022 )].
	self assert:[tarjeta owner = 'Luis'].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:21'!
test03aCardIsExpiredAfterACertainDate
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ) number: 1234.
	self assert:[tarjeta isExpired: (Date newDay: 01 month: 11 year: 2022 )].
	self assert:[tarjeta isExpired: (Date newDay: 01 month: 12 year: 2022 )].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:29'!
test04aCardIsNotExpiredBeforeACertainDate
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ) number: 1234.
	self assert:[(tarjeta isExpired: (Date newDay: 01 month: 10 year: 2022 )) = false]! !


!classDefinition: #CartManagerTest category: #TusLibros!
TestCase subclass: #CartManagerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartManagerTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:00:10'!
test01ReturnsAnIdWhenAskedForANewCart
	|cartManager id |
	cartManager := CartManager withCatalog: TestFactory catalogABC123 timer: ThreeOPTimer.
	id := cartManager createCart.
	self assert: [id = 1].! !

!CartManagerTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:37:31'!
test02ACartOperatesIfNotExpired
	| cartManager id carrito |
	cartManager _ CartManager
		withCatalog: TestFactory catalogABC123
		timer: ThreeOPTimer.
	id _ cartManager createCart.
	cartManager
		makeCart: id
		do: [ :aCart |
			aCart
				add: 2
				item: 'A' ].
	cartManager
		makeCart: id
		do: [ :aCart |
			aCart
				add: 1
				item: 'B' ].
	carrito _ cartManager carts at: id.
	self assert: [ (carrito items at: 'A') = 2 ].
	self assert: [ (carrito items at: 'B') = 1 ].! !

!CartManagerTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:37:45'!
test03FailWhenAExpiredCartOperates
	|cartManager id |
	cartManager := CartManager withCatalog: (TestFactory catalogABC123) timer: ThreeOPTimer.
	id := cartManager createCart.
	cartManager makeCart: id do: [:aCart | aCart add: 2 item: 'A'].
	cartManager makeCart: id do: [:aCart | aCart add: 2 item: 'B'].
	self should:  [cartManager makeCart: id do: [:aCart | aCart add: 1 item: 'C'].
			self fail]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error|
			self assert: CartManager cartExpiredMessage = error messageText ].
	^ self.! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 16:10:53'!
test01CreatedCartIsEmpty
	|carrito|
	carrito := Cart withCatalog: #().
	self assert: carrito isEmpty
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:24:45'!
test02CanAddBooksInCatalog
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.
	carrito add: 1 item: 'A'.
	self assert: [carrito items includesKey: 'A'].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:25:58'!
test03CantAddItemsNotInCatalog
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.
	self 
		should: [ 
			carrito add: 1 item: 'D'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart notInCatalogMessage =
			error messageText ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:25:23'!
test04CanAddMoreThanOneBookWithSameISBN
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.	carrito add: 4 item: 'A'.
	self assert: [(carrito items at: 'A') = 4]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:25:40'!
test05CanAddMoreOfTheSameBook
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.	carrito add: 4 item: 'A'.
	carrito add: 2 item: 'A'.
	self assert: [(carrito items at: 'A') = 6]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:26:11'!
test06CantAddNegativeNumberOfBooks
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.
	
	self 
		should: [ 
			carrito add: -1 item: 'A'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart cantAddNegativeQuantityMessage =
			error messageText ].
	self assert: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:26:27'!
test07CantAddNonIntegerNumberOfBooks
	|carrito|
	carrito := Cart withCatalog: TestFactory catalogABC123.
	
	self 
		should: [ 
			carrito add: 1.22 item: 'A'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart cantAddNonIntegerMessage =
			error messageText ].
	self assert: carrito isEmpty.! !


!classDefinition: #ClerkTest category: #TusLibros!
TestCase subclass: #ClerkTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:45:44'!
test01cantCheckOutEmptyCart
	| carrito cajero |
	carrito _ TestFactory emptyCart.
	cajero _ Clerk new.
	self
		should: [
			cajero checkout: carrito with: (Date newDay: 1 month: 11 year: 2017).
			self fail ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk emptyCartOnCheckoutMessage = error messageText ].! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:58:05'!
test02canCheckOutProductsIfCardIsNotExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123 
		merchantProcessor: MerchProcSim new.
	tarjeta := TestFactory notExpiredCard.
	cajero checkout: carrito with: tarjeta.
! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:00:07'!
test03cantCheckOutProductsIfCardIsExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	tarjeta := TestFactory expiredCard.
	self 
		should: [
			cajero checkout: carrito with: tarjeta.
			self fail]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk expiredCardMessage = error messageText ].

! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:00:13'!
test04ClerkMustKnowTheSameCatalogAsTheCartForCheckout
	| carrito cajero tarjeta |
	carrito _ TestFactory diferentCatalogCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	tarjeta := TestFactory notExpiredCard.
	self 
		should: [
			cajero checkout: carrito with: tarjeta.
			self fail]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk notValidCatalogMessage = error messageText ].

! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:00:19'!
test05ValueOfReturnsTheCorrectCost
	| carrito cajero value |
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	value := (cajero valueOf: carrito).
	self assert: [ value = 7 ].! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:00:34'!
test06CheckoutReturnsATransactionIDIfCorrect
	| carrito cajero tarjeta id |
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	tarjeta := TestFactory notExpiredCard.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	id := (cajero checkout: carrito with: tarjeta).
	self assert: [id = '0001']! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:12:55'!
test07CheckoutRisesExceptionIfCardIsLost
	| carrito cajero tarjeta |
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	tarjeta := TestFactory lostCard.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	
	self should:
			[cajero checkout: carrito with: tarjeta.
			self fail.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :error |
			self assert: Clerk lostCardReturnMessage =
			error messageText ]
	
	! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:22:36'!
test08CheckoutRisesExceptionIfCardHasNoCredit
	| carrito cajero tarjeta |
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	tarjeta := TestFactory creditlessCard.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	
	self should:
			[cajero checkout: carrito with: tarjeta.
			self fail.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :error |
			self assert: Clerk noCreditReturnMessage =
			error messageText ]
	
	! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:29:53'!
test09CheckoutExpiredCardShouldntRiseTheReturnException
	| carrito cajero tarjeta |
	"este test esta para ver si el error que tira es el de la cajera diciendo que esta expirada ANTES de enviar al servidor el mensaje. presupone que el processor hace lo mismo que la cajera."
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	tarjeta := TestFactory expiredCard.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123
		merchantProcessor: MerchProcSim new.
	
	self should:
			[cajero checkout: carrito with: tarjeta.
			self fail.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[ :error |
			self assert: (Clerk expiredCardReturnMessage =
			error messageText) not 
		]
	
	! !


!classDefinition: #InterfazTest category: #TusLibros!
TestCase subclass: #InterfazTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:26:37'!
test01ListPurchasesFailsOnIncorrectPassword
	| interfaz|
	
	interfaz := Interfaz carts: TestFactory fullCartManager 
		clerk: TestFactory basicClerk 
		users: TestFactory userBase.
	
	self should: [interfaz listPurchasesFor: 'Test' password: 'NotTest'] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self assert: Interfaz incorrectPasswordMessage = error messageText ].
	! !

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:51:07'!
test02ListPurchasesReturnsPurchasesOnCorrectPassword
	| interfaz users |
	users := TestFactory userBase.
	interfaz := Interfaz carts: TestFactory fullCartManager 
		clerk: TestFactory basicClerk 
		users: users.
	
	self assert: [(interfaz listPurchasesFor: 'Test' password: 'Test') = (users purchasesOf: 'Test')]
	! !

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:10:50'!
test03AddToCartAddsItemsToTheCart
	| interfaz carts |
	carts := TestFactory fullCartManager.
	interfaz := Interfaz carts: carts
		clerk: TestFactory basicClerk 
		users: TestFactory userBase.
	
	interfaz addToCart: 1 bookISBN:  'A' bookQuantity: 3.
	self assert: [ 5 = ((carts carts at: 1) items at:'A')]
	! !

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:26:32'!
test04CreateCartReturnsAnID
	| interfaz carts |
	carts := TestFactory fullCartManager.
	interfaz := Interfaz carts: carts
		clerk: TestFactory basicClerk 
		users: TestFactory userBase.
	
	self assert: [ (interfaz createCartFor: 'Test' password: 'Test') = 2]
	! !

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:21:09'!
test05ListCartReturnsTheCartList
	| interfaz carts |
	carts := TestFactory fullCartManager.
	interfaz := Interfaz carts: carts
		clerk: TestFactory basicClerk 
		users: TestFactory userBase.
	
	self assert: [ (interfaz listCart: 1) = (carts carts at:1) items]
	! !

!InterfazTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:30:44'!
test06CheckoutCartReturnsPurchaseID
	| interfaz carts |
	carts := TestFactory fullCartManager.
	interfaz := Interfaz carts: carts
		clerk: TestFactory basicClerk 
		users: TestFactory userBase.
	
	self assert: [ (interfaz checkoutCart: 1 card: 1234 expires: (Date newDay: 01 month: 11 year: 2022) owner: 'Luis') = '0001']
	! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:19:26'!
expiration
	^expiration! !

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:52:34'!
for: aString expires: aDate number: aNumber
	expiration := aDate.
	owner := aString.
	number := aNumber.! !

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:35:45'!
isExpired: aDate 
	^(expiration < aDate) or: (expiration = aDate).! !

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:46:02'!
number
	^number! !

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:19:36'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:12:54'!
emptyOwnerMessage
	^ 'No se puede crear una tarjeta sin dueño'.! !

!Card class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:07'!
newFor: aString expires: aDate number: aSmallInteger 
	aString isEmpty ifTrue: [ self error: Card emptyOwnerMessage ].
	^self new for: aString  expires: aDate number: aSmallInteger! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:22:35'!
add: aQuantity item: anISBN
	|suma|
	(catalog includesKey: anISBN) ifFalse: [self error: Cart notInCatalogMessage].
	(aQuantity > 0) ifFalse: [self error: Cart cantAddNegativeQuantityMessage].
	(aQuantity isInteger) ifFalse: [self error: Cart cantAddNonIntegerMessage].
	
	
	suma := items at: anISBN ifAbsent: 0.
	items at: anISBN put: aQuantity + suma.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:17:42'!
catalog
	^catalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 16:35:58'!
initializeWithCatalog: aCatalog 
	items := Dictionary new.
	catalog := aCatalog.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:53:57'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:11:46'!
items
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:55:19'!
cantAddNegativeQuantityMessage
	^'Cantidad debe ser  positiva'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 12:00:34'!
cantAddNonIntegerMessage
	^'Cantidad debe ser entera'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:56:39'!
notInCatalogMessage
	^'Libro no es de la editorial'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:08:20'!
withCatalog: aCatalog
	^self new initializeWithCatalog: aCatalog! !


!classDefinition: #CartManager category: #TusLibros!
Object subclass: #CartManager
	instanceVariableNames: 'carts catalog nextId timer lastUses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 21:38:28'!
carts
	^carts! !

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:02:45'!
createCart
	|id|
	id := self nextId.
	carts at: id put: (Cart withCatalog: catalog).
	lastUses at: id put: (timer getTime).
	^id! !

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:24:02'!
listCart: aCart
	^(carts at: aCart) items! !

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:55:11'!
makeCart: anId do: aBlockClosure 
	|cart lastUse currentTime|
	lastUse := lastUses at: anId.
	currentTime := timer getTime.
	((currentTime - lastUse) < (Duration minutes: 30)) 
		ifFalse: [self error: CartManager cartExpiredMessage].
	lastUses at: anId put: currentTime.
	cart := carts at: anId.
	aBlockClosure value: cart.! !

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 20:18:42'!
nextId
	|response|
	response := nextId value.
	nextId := nextId + 1.
	^response! !

!CartManager methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:34:21'!
withCatalog: aCatalog timer: aTimer
	catalog _ aCatalog.
	carts _ Dictionary new.
	lastUses _ Dictionary new.
	nextId _ 1.
	timer _ aTimer new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartManager class' category: #TusLibros!
CartManager class
	instanceVariableNames: ''!

!CartManager class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:57:31'!
cartExpiredMessage
	^'Pasaron 30 minutos desde el ultimo uso de este carro'! !

!CartManager class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:00:30'!
withCatalog: aCatalog timer: aTimer
	^ self new
		withCatalog: aCatalog
		timer: aTimer.! !


!classDefinition: #Clerk category: #TusLibros!
Object subclass: #Clerk
	instanceVariableNames: 'date catalog processor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:21:15'!
checkout: aCart with: aCard 
	|value id|
	(aCart isEmpty) ifTrue: [self error: Clerk emptyCartOnCheckoutMessage].
	(aCard isExpired: date) ifTrue:[self error: Clerk expiredCardMessage].
	(catalog = aCart  catalog) ifFalse:[self error: Clerk notValidCatalogMessage].
	value := self valueOf: aCart.
	id := processor debitCard: (aCard number) expiration: (aCard expiration) owner: (aCard owner) amount: value.
	
	id := id findTokens:'|'.
	((id at: 1) = '0') ifTrue: [^id at: 2.].
	((id at: 2) = 'Tarjeta_perdida') ifTrue: [self error: Clerk lostCardReturnMessage].
	((id at: 2) = 'Tarjeta_sin_credito') ifTrue: [self error: Clerk noCreditReturnMessage].
	((id at: 2) = 'Tarjeta_expirada') ifTrue: [self error: Clerk expiredCardReturnMessage].
	self error: Clerk unknownError.! !

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:27:32'!
valueOf: aCart 
	|suma|
	suma := 0.
	aCart items keysAndValuesDo: [:aKey :aValue | suma := suma + (catalog at: aKey) * aValue].
	^suma! !

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:56:03'!
withDate: aDate catalog: aCatalog merchantProcessor: aProcessor
	date := aDate.
	catalog := aCatalog.
	processor := aProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clerk class' category: #TusLibros!
Clerk class
	instanceVariableNames: ''!

!Clerk class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 12:57:49'!
emptyCartOnCheckoutMessage
	^ 'No se puede hacer checkout de un carrito vacio'.! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:40:05'!
expiredCardMessage
	^'No se puede hacer checkout porque la tarjeta esta expirada'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:26:54'!
expiredCardReturnMessage
	'La tarjeta esta marcada como expirada en el processor'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:18:12'!
lostCardReturnMessage
	^'La tarjeta esta marcada como perdida en el processor'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:23:11'!
noCreditReturnMessage
	^'La tarjeta esta marcada como sin credito en el processor'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:34:17'!
notValidCatalogMessage
	^'El catalogo del carrito no corresponde a el del cajero'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:16:35'!
unknownError
	^'El mensaje de retorno era de un tipo no conocido'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:13:54'!
withDate: aDate catalog: aCatalog
	^self new withDate: aDate catalog: aCatalog! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:59:07'!
withDate: aDate catalog: aDictionary merchantProcessor: aMerchProcSim 
	^self new withDate: aDate catalog: aDictionary merchantProcessor: aMerchProcSim ! !


!classDefinition: #Clients category: #TusLibros!
Object subclass: #Clients
	instanceVariableNames: 'passwords sells clients purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clients methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:48:50'!
add: aClient withPassword: aPassword 
	clients at: aClient put: aPassword.
	purchases at: aClient put: Bag new.! !

!Clients methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:36:01'!
client: clientId hasPassword: aPassword
	^(clients at: clientId ifAbsent:[self error: Clients noSuchClientMessage]) = aPassword! !

!Clients methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:45:59'!
initialize
	clients := Dictionary new.
	purchases := Dictionary new.! !

!Clients methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:49:11'!
purchases
	^purchases! !

!Clients methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:45:24'!
purchasesOf: aString 
	purchases at: aString.! !


!classDefinition: #Interfaz category: #TusLibros!
Object subclass: #Interfaz
	instanceVariableNames: 'carts clerk users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:06:55'!
addToCart: aCartId bookISBN: aISBN bookQuantity: aBookQuantity
	carts makeCart: aCartId do: [:aCart| aCart add: aBookQuantity item: aISBN ]! !

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:32:06'!
carts: aCartManager clerk: aClerk users: aUsersDictionary
	carts := aCartManager.
	clerk := aClerk.
	users := aUsersDictionary.
	! !

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:36:38'!
checkoutCart: aCartId card: idTarjeta expires: adate owner: aOwner
	|tarjeta carrito|
	tarjeta := Card newFor: aOwner  expires: adate  number: idTarjeta.
	carrito := carts carts at: aCartId.
	^clerk checkout: carrito with: tarjeta! !

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:17:58'!
createCartFor: aClientId password: aPassword 
	(users client: aClientId hasPassword: aPassword) ifFalse: [self error: Interfaz incorrectPasswordMessage].
	^carts createCart.! !

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 17:24:16'!
listCart: aCartId
	^carts listCart: aCartId! !

!Interfaz methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:49:55'!
listPurchasesFor: aClientId password: aPassword
	(users client: aClientId hasPassword: aPassword) ifFalse: [self error: Interfaz incorrectPasswordMessage].
	^users purchasesOf: aClientId. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interfaz class' category: #TusLibros!
Interfaz class
	instanceVariableNames: ''!

!Interfaz class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:30:37'!
carts: aCartManager clerk: aClerk users: aClass 
	^self new carts: aCartManager clerk: aClerk users: aClass ! !

!Interfaz class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:41:30'!
incorrectPasswordMessage
	^ 'La contraseña ingresada es incorrecta'.! !


!classDefinition: #MerchProcSim category: #TusLibros!
Object subclass: #MerchProcSim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchProcSim methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:07:25'!
debitCard: aCardNumber expiration: aCardExpiration owner: aCardOwner amount: anAmount
	(aCardNumber = 1) ifTrue: [^'1|Tarjeta_sin_credito'].
	(aCardNumber = 2) ifTrue: [^'1|Tarjeta_perdida'].
	(aCardNumber = 3) ifTrue: [^'1|Tarjeta_expirada'].
	^'0|0001'! !


!classDefinition: #StopedTimer category: #TusLibros!
Object subclass: #StopedTimer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StopedTimer methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:18:12'!
getTime
	^Time hour: 10 minute: 00  second: 00! !


!classDefinition: #TestFactory category: #TusLibros!
Object subclass: #TestFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestFactory class' category: #TusLibros!
TestFactory class
	instanceVariableNames: ''!

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:15:58'!
basicClerk
	^Clerk withDate: (Date newDay: 1 month: 11 year: 2017) 
		catalog: TestFactory catalogABC123 
		merchantProcessor: MerchProcSim new.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:14:16'!
catalogABC123
	|diccionario|
	diccionario := Dictionary new.
	diccionario at: 'A' put: 1.
	diccionario at: 'B' put: 2.
	diccionario at: 'C' put: 3.
	^diccionario! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:09:05'!
creditlessCard
	^ Card
		newFor: 'Luis'
		expires:
			(Date
				newDay: 1
				month: 11
				year: 2022)
		number: 1.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:37:47'!
diferentCatalogCart
	| carrito catalogo|
	catalogo := Dictionary new.
	catalogo at: 'A' put: 1.
	carrito :=Cart withCatalog: catalogo.
	carrito add: 4 item: 'A'.
	^carrito.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:20:24'!
emptyCart
	^Cart withCatalog: TestFactory catalogABC123.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 14:39:47'!
expiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2010) number: 03! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:31:20'!
fullCart
	| carrito |
	carrito :=Cart withCatalog: TestFactory catalogABC123.
	carrito add: 4 item: 'A'.
	^carrito.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:20:14'!
fullCartManager
|cartManager id |
	cartManager := CartManager withCatalog: (TestFactory catalogABC123) timer: StopedTimer.
	id := cartManager createCart.
	cartManager makeCart: id do: [:aCart | aCart add: 2 item: 'A'].
	cartManager makeCart: id do: [:aCart | aCart add: 2 item: 'B'].
	^cartManager! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 15:08:40'!
lostCard
	^ Card
		newFor: 'Luis'
		expires:
			(Date
				newDay: 1
				month: 11
				year: 2022)
		number: 2.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:40'!
notExpiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022) number: 1234! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/6/2017 16:31:28'!
userBase
	| clients |
	clients := Clients new.
	clients add: 'Test' withPassword: 'Test'.
	^clients! !


!classDefinition: #ThreeOPTimer category: #TusLibros!
Object subclass: #ThreeOPTimer
	instanceVariableNames: 'array timesCalled'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ThreeOPTimer methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:37:00'!
getTime
	timesCalled := timesCalled +1.
	^ array at: timesCalled. ! !

!ThreeOPTimer methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 22:35:54'!
initialize
	array := OrderedCollection new.
	array add: (Time hour: 10 minute: 00  second: 00).
	array add: (Time hour: 10 minute:25  second: 00).
	array add: (Time hour: 10 minute:30  second: 00).
	array add: (Time hour: 11 minute:30  second: 00).
	timesCalled := 0! !
