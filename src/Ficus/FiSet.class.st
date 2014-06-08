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

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| internalEdits selfValues |	
	self == other ifTrue: [ ^ self noEdit ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	selfValues := self values.
	internalEdits := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		(selfValues includes: otherValue) ifFalse: [
			internalEdits add: (other exclude: otherValue) ] ].

	self stepsAndValuesDo: [ :step :value |
		(other values includes: value) ifFalse: [ 
			internalEdits add: (other include: value) ] ].
	
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

{ #category : #enumerating }
FiSet >> ficusDeepCollect: aBlock [

	^ aBlock value: 
		(self species withValues: (self values collect: [ :each | each ficusDeepCollect: aBlock ]))
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
FiSet >> shotAt: step [

	^ self 
		indexOf: step 
		ifPresent: [ :index | self at: index ]
		ifAbsent: [ NotFound signal ]
]

{ #category : #enumerating }
FiSet >> stepCount [
	
	^ self size
]

{ #category : #enumerating }
FiSet >> stepsAndValuesDo: aBlockClosure [ 
	"Each value is both step and value"

	^ self valuesWithIndexDo: [ :each :index | aBlockClosure value: each defaultStep value: each ]
]

{ #category : #pruning }
FiSet >> untaggedPruned [

	^ self species withValues: (self values collect: [ :each | each pruned ])
]

{ #category : #accessing }
FiSet >> values [
	
	^ (1 to: self size) collect: [ :index | self at: index ] as: Set

]

{ #category : #enumerating }
FiSet >> valuesDo: elementBlock [ 

	1 to: self size do:
		[:index |
		elementBlock
			value: (self at: index) ]
]

{ #category : #enumerating }
FiSet >> valuesWithIndexDo: elementAndIndexBlock [ 

	1 to: self size do:
		[:index |
		elementAndIndexBlock
			value: (self at: index)
			value: index]
]
