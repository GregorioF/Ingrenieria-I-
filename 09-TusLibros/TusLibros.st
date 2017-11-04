!classDefinition: #CardTest category: #TusLibros!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:03:46'!
test01CantCreateCardWithoutOwner

	self should:[Card newFor: '' expires: (Date newDay: 01 month: 11 year: 2022 )]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[:error | self assert: Card emptyOwnerMessage = error messageText]! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:18:34'!
test02ANewCardHasAOwnerAndExpiration
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ).
	self assert:[tarjeta expiration = (Date newDay: 01 month: 11 year: 2022 )].
	self assert:[tarjeta owner = 'Luis'].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:21:49'!
test03aCardIsExpiredAfterACertainDate
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ).
	self assert:[tarjeta isExpired: (Date newDay: 01 month: 11 year: 2022 )].
	self assert:[tarjeta isExpired: (Date newDay: 01 month: 12 year: 2022 )].! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:42:35'!
test04aCardIsNotExpiredBeforeACertainDate
	|tarjeta|
	tarjeta := Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022 ).
	self assert:[(tarjeta isExpired: (Date newDay: 01 month: 10 year: 2022 )) = false]! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:51:06'!
test01CreatedCartIsEmpty
	|carrito|
	carrito := Cart new.
	self assert: carrito isEmpty
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:43:45'!
test02CanAddBooksInCatalog
	|carrito|
	carrito := Cart withCatalog: #('123').
	carrito add: 1 item: '123'.
	self assert: [carrito items includesKey: '123'].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:30:52'!
test03CantAddItemsNotInCatalog
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').
	self 
		should: [ 
			carrito add: 1 item: '1234'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart notInCatalogMessage =
			error messageText ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:39:35'!
test04CanAddMoreThanOneBookWithSameISBN
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').	carrito add: 4 item: '123'.
	self assert: [(carrito items at: '123') = 4]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:44:43'!
test05CanAddMoreOfTheSameBook
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').	carrito add: 4 item: '123'.
	carrito add: 2 item: '123'.
	self assert: [(carrito items at: '123') = 6]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:53:07'!
test06CantAddNegativeNumberOfBooks
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').
	
	self 
		should: [ 
			carrito add: -1 item: '123'.
			self fail]
		raise: Error 
		withExceptionDo: [ :error |
			self assert: Cart cantAddNegativeQuantityMessage =
			error messageText ].
	self assert: carrito isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 11:58:32'!
test07CantAddNonIntegerNumberOfBooks
	|carrito|
	carrito := Cart withCatalog: #('123' '133' '7565').
	
	self 
		should: [ 
			carrito add: 1.22 item: '123'.
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

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:29:40'!
test02canCheckOutProductsIfCardIsNotExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017).
	tarjeta := TestFactory notExpiredCard.
	
	
	cajero checkout: carrito with: tarjeta.
! !

!ClerkTest methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:36:33'!
test03cantCheckOutProductsIfCardIsExpired
	| carrito cajero tarjeta |
	carrito _ TestFactory fullCart.
	cajero _ Clerk withDate: (Date newDay: 1 month: 11 year: 2017).
	tarjeta := TestFactory expiredCard.
	self 
		should: [
			cajero checkout: carrito with: tarjeta.
			self fail]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Clerk expiredCardMessage = error messageText ].

! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:19:26'!
expiration
	^expiration! !

!Card methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:19:11'!
for: aString expires: aDate 
	expiration := aDate.
	owner := aString.! !

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

!Card class methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 15:15:39'!
newFor: aString expires: aDate
	aString isEmpty ifTrue: [ self error: Card emptyOwnerMessage ].
	^ self new for: aString expires: aDate.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 12:00:00'!
add: aQuantity item: anISBN
	|suma|
	(catalog includes: anISBN) ifFalse: [self error: Cart notInCatalogMessage].
	(aQuantity > 0) ifFalse: [self error: Cart cantAddNegativeQuantityMessage].
	(aQuantity isInteger) ifFalse: [self error: Cart cantAddNonIntegerMessage].
	
	
	suma := items at: anISBN ifAbsent: 0.
	items at: anISBN put: aQuantity + suma.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 19:56:23'!
initialize
	items := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'LIC 11/2/2017 20:15:00'!
initializeWithCatalog: anArray 
	items := Dictionary new.
	catalog := Bag new addAll: anArray.! !

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


!classDefinition: #Clerk category: #TusLibros!
Object subclass: #Clerk
	instanceVariableNames: 'date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clerk methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:38:05'!
checkout: aCart with: aCard 
	(aCart isEmpty) ifTrue: [self error: Clerk emptyCartOnCheckoutMessage].
	(aCard isExpired: date) ifTrue:[self error: Clerk expiredCardMessage].
	! !

!Clerk methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 13:35:19'!
withDate: aDate 
	date := aDate.! !

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

!Clerk class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 13:56:18'!
withDate: aDate 
	^self new withDate: aDate! !


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

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 12:22:08'!
emptyCart
	^Cart new.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:37:04'!
expiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2010)! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'cLI 11/4/2017 13:33:48'!
fullCart
	| carrito |
	carrito :=Cart withCatalog: #('123' '133' '7565').
	carrito add: 4 item: '123'.
	^carrito.! !

!TestFactory class methodsFor: 'as yet unclassified' stamp: 'Lic 11/4/2017 16:12:52'!
notExpiredCard
	^Card newFor: 'Luis' expires: (Date newDay: 01 month: 11 year: 2022)! !
