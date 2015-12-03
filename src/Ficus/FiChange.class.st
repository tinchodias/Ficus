"
I represent an abstract change in the Ficus model. 

See class comment of FiObject.
"
Class {
	#name : #FiChange,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #convenience }
FiChange class >> fromAll: changes [

	^ changes
		ifEmpty: [ FiNoChange new ]
		ifNotEmpty: [ changes size = 1
			ifTrue: [ changes anyOne ]
			ifFalse: [ 
				FiCompositeChange builder
					children: changes asFiSet;
					new ] ]
]

{ #category : #converting }
FiChange >> asSimpleChanges [

	^ self asSimpleChangesAt: FiPath root
]

{ #category : #converting }
FiChange >> asSimpleChangesAt: aBasePath [

	^ self subclassResponsibility
]

{ #category : #accessing }
FiChange >> edit [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiChange >> inverse [

	^ self subclassResponsibility 
]

{ #category : #testing }
FiChange >> isNoChange [

	^ false
]
