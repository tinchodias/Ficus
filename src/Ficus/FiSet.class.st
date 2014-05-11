Class {
	#name : #FiSet,
	#superclass : #FiShot,
	#instVars : [
		'values'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| internalEdits |	
	self == other ifTrue: [ ^ self noEdit ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	internalEdits := Set new.

	other stepsAndValuesDo: [ :step :otherValue | 
		(values includes: otherValue) ifFalse: [
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
		(self copy
			values: (self values collect: [ :each | each ficusDeepCollect: aBlock ]);
			yourself)
]

{ #category : #edits }
FiSet >> include: aValue [

	^ FiInclude value: aValue
]

{ #category : #initialize }
FiSet >> initialize [
	super initialize.

	values := #()
]

{ #category : #printing }
FiSet >> printOn: aStream [

	super printOn: aStream.
	self values printElementsOn: aStream.

]

{ #category : #results }
FiSet >> resultOfExclude: anExclude [ 

	^ self copy
		values: (self values copyWithout: anExclude theValue);
		yourself

]

{ #category : #results }
FiSet >> resultOfInclude: anInclude [ 

	^ self copy
		values: (self values copyWith: anInclude theValue);
		yourself

]

{ #category : #accessing }
FiSet >> shotAt: step [

	self assert: (values includes: step).

	^ step
]

{ #category : #enumerating }
FiSet >> stepCount [
	
	^ self values size
]

{ #category : #enumerating }
FiSet >> stepsAndValuesDo: aBlockClosure [ 
	"Each value is both step and value"

	^ self values do: [ :each | aBlockClosure value: each value: each ]
]

{ #category : #pruning }
FiSet >> untaggedPruned [

	^ self copy
		values: (self values collect: [ :each | each pruned ]);
		yourself
]

{ #category : #accessing }
FiSet >> values [
	^ values
]

{ #category : #accessing }
FiSet >> values: anObject [
	values := anObject
]
