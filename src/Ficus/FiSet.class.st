"
I represent a set. TODO
"
Class {
	#name : #FiSet,
	#superclass : #FiShot,
	#type : #variable,
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiSet class >> new [

	^ self withValues: #()
]

{ #category : #'instance creation' }
FiSet class >> newFromStepsAndValues: aDictionary [ 
	
	^ self withValues: aDictionary values
]

{ #category : #'instance creation' }
FiSet class >> withValues: aCollection [ 
	
	| aSet |
	aSet := aCollection asSet.

	^ (self basicNew: aSet size)
		initializeWithSet: aSet;
		yourself
]

{ #category : #converting }
FiSet >> asArray [
	
	^ (1 to: self size) collect: [ :index | self at: index ] as: Array
]

{ #category : #edits }
FiSet >> at: step edit: aBlockClosure [ 

	self flag: #todo. "Cloned from FiDictionary"
	
	^ FiAcceptKey 
		key: step
		edit: (aBlockClosure value: (self shotAt: step))
]

{ #category : #edits }
FiSet >> at: step equal: value [

	self flag: #todo. "Cloned from FiDictionary"

	^ FiAcceptKey 
		key: step
		edit: (FiEqual value: value)
]

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| internalEdits |	
	self == other ifTrue: [ ^ self noEdit ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	internalEdits := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			shotAt: key
			ifPresent: [ :value | 
				(otherValue = value) ifFalse: [
					internalEdits add: (other at: key edit: [ :otherValue2 | value differenceFrom: otherValue ]) ] ]
			ifAbsent: [ 
				internalEdits add: (other exclude: key) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key)
			ifFalse: [ internalEdits add: (other include: value) ] ].
	
	^ internalEdits
		ifEmpty: [ self noEdit ]
		ifNotEmpty: [ internalEdits size = 1
			ifTrue: [ internalEdits anyOne ]
			ifFalse: [ self edits: internalEdits ] ]
]

{ #category : #edits }
FiSet >> exclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSet >> include: aValue [

	^ FiInclude value: aValue
]

{ #category : #private }
FiSet >> indexOf: step ifPresent: presentBlock ifAbsent: absentBlock [

	self valuesWithIndexDo: [ :each :index | 
		each defaultStep = step ifTrue: [ ^ presentBlock cull: index ] ].

	^ absentBlock value
]

{ #category : #initialization }
FiSet >> initializeWithSet: aSet [ 

	| index |	
	self initialize.
	
	index := 1.
	aSet do: [ :each | 
		self at: index put: each. 
		index := index + 1 ]
]

{ #category : #printing }
FiSet >> printOn: aStream [

	super printOn: aStream.
	self values printElementsOn: aStream.

]

{ #category : #results }
FiSet >> resultOfExclude: anExclude [ 

	^ self species withValues: (self values copyWithout: anExclude theValue)
]

{ #category : #results }
FiSet >> resultOfInclude: anInclude [ 

	| newValues |
	newValues := self asArray copyWith: anInclude theValue.

	self 
		indexOf: anInclude theValue defaultStep 
		ifPresent: [ :index | newValues := newValues copyWithoutIndex: index ]
		ifAbsent: [ ].
		
	^ self species withValues: newValues
]

{ #category : #accessing }
FiSet >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self 
		indexOf: step 
		ifPresent: [ :index | presentBlock value: (self at: index) ]
		ifAbsent: absentBlock
]

{ #category : #enumerating }
FiSet >> stepCount [
	
	^ self size
]

{ #category : #enumerating }
FiSet >> stepsAndValuesDo: aBlockClosure [ 

	^ self valuesDo: [ :each | 
		aBlockClosure 
			value: each defaultStep 
			value: each ]
]

{ #category : #enumerating }
FiSet >> valuesDo: elementBlock [ 

	^ self valuesWithIndexDo: [ :value :index | elementBlock value: value ]
]

{ #category : #private }
FiSet >> valuesWithIndexDo: elementAndIndexBlock [ 

	1 to: self size do: [ :index |
		elementAndIndexBlock
			value: (self at: index)
			value: index ]
]
