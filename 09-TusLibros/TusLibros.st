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

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:29:21'!
test02canCheckOutProductsIfCardIsNotExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) catalog: TestFactory catalogABC123.
	tarjeta := TestFactory notExpiredCard.
	cajero checkout: carrito with: tarjeta.
! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:32:03'!
test03cantCheckOutProductsIfCardIsExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) catalog: TestFactory catalogABC123.
	tarjeta := TestFactory expiredCard.
	self 
		should: [
			cajero checkout: carrito with: tarjeta.
			self fail]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk expiredCardMessage = error messageText ].

! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:32:49'!
test04ClerkMustKnowTheSameCatalogAsTheCartForCheckout
	| carrito cajero tarjeta |
	carrito _ TestFactory diferentCatalogCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) catalog: TestFactory catalogABC123.
	tarjeta := TestFactory notExpiredCard.
	self 
		should: [
			cajero checkout: carrito with: tarjeta.
			self fail]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk notValidCatalogMessage = error messageText ].

! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:12:11'!
test05CheckoutReturnsTheCorrectCost
	| carrito cajero tarjeta value |
	carrito _ TestFactory emptyCart.
	carrito add: 1 item: 'A'.
	carrito add: 2 item: 'C'.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017) catalog: TestFactory catalogABC123.
	tarjeta _ TestFactory notExpiredCard.
	value := (cajero checkout: carrito with: tarjeta).
	self assert: [ value = 7 ].! !


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
	instanceVariableNames: 'date catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:12:38'!
checkout: aCart with: aCard 
	|suma|
	(aCart isEmpty) ifTrue: [self error: Clerk emptyCartOnCheckoutMessage].
	(aCard isExpired: date) ifTrue:[self error: Clerk expiredCardMessage].
	(catalog = aCart  catalog) ifFalse:[self error: Clerk notValidCatalogMessage].
	suma := 0.
	aCart items keysAndValuesDo: [:aKey :aValue | suma := suma + (catalog at: aKey) * aValue].
	^suma! !

!Clerk methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 13:35:19'!
withDate: aDate 
	date := aDate.! !

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:14:58'!
withDate: aDate catalog: aCatalog
	date := aDate.
	catalog := aCatalog.! !

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

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:34:17'!
notValidCatalogMessage
	^'El catalogo del carrito no corresponde a el del cajero'! !

!Clerk class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:13:54'!
withDate: aDate catalog: aCatalog
	^self new withDate: aDate catalog: aCatalog! !


!classDefinition: #MerchantProcessorSim category: #TusLibros!
Object subclass: #MerchantProcessorSim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSim methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 19:36:13'!
debitCard: aCardNumber expiration: aCardExpiration owner: aCardOwner amount: anAmount
	(aCardNumber = 1) ifTrue: [^'1|Tarjeta_sin_credito'].
	(aCardNumber = 2) ifTrue: [^'1|Tarjeta_robada'].
	(aCardNumber = 3) ifTrue: [^'1|Tarjeta_expirada'].
	^'0|0001'! !


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

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:14:16'!
catalogABC123
	|diccionario|
	diccionario := Dictionary new.
	diccionario at: 'A' put: 1.
	diccionario at: 'B' put: 2.
	diccionario at: 'C' put: 3.
	^diccionario! !

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

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:45'!
expiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2010) number: 1234! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 17:31:20'!
fullCart
	| carrito |
	carrito :=Cart withCatalog: TestFactory catalogABC123.
	carrito add: 4 item: 'A'.
	^carrito.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/5/2017 18:56:40'!
notExpiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022) number: 1234! !


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
