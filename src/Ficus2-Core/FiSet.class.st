"
I represent a set. TODO
"
Class {
	#name : #FiSet,
	#superclass : #FiObject,
	#type : #variable,
	#category : #'Ficus2-Core-Model'
}

{ #category : #ston }
FiSet class >> fromSton: stonReader [

	| values |
	values := Array streamContents: [ :stream |
		stonReader parseListDo: [ :each | 
			stream nextPut: each ]].
	
	^ self withValues: values
]

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
	
	^ (self basicNew: aCollection size)
		initializeWithValues: aCollection;
		yourself
]

{ #category : #accessing }
FiSet >> anyOne [
	
	^ self at: 1
]

{ #category : #converting }
FiSet >> asArray [
	
	^ (1 to: self size) collect: [ :index | self at: index ] as: Array
]

{ #category : #converting }
FiSet >> asDictionary [

	| result |
	result := Dictionary new.

	self stepsAndValuesDo: [ :step :value |
		result at: step put: value ].
	
	^ result
]

{ #category : #converting }
FiSet >> asFiSet [
	
	^ self
]

{ #category : #enumerating }
FiSet >> collect: aBlockClosure [ 
	
	^ self collect: aBlockClosure as: Set
]

{ #category : #enumerating }
FiSet >> collect: aBlockClosure as: aClass [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into an instance of aClass. Answer the resulting collection."

	| newCollection |
	newCollection := aClass new: self size.
	self valuesDo: [ :each | newCollection add: (aBlockClosure value: each) ].
	^ newCollection
]

{ #category : #enumerating }
FiSet >> detect: aBlockClosure [ 
	
	self do: [ :each | (aBlockClosure value: each) ifTrue: [ ^ each ] ].
	NotFound signalFor: aBlockClosure.
]

{ #category : #enumerating }
FiSet >> do: aBlockClosure [ 
	
	^ self valuesDo: aBlockClosure
]

{ #category : #private }
FiSet >> indexOf: step ifPresent: presentBlock ifAbsent: absentBlock [

	self valuesWithIndexDo: [ :each :index | 
		each defaultStep = step ifTrue: [ ^ presentBlock cull: index ] ].

	^ absentBlock value
]

{ #category : #initialization }
FiSet >> initializeFromStepsAndValues: aDictionary [

	self shouldNotImplement "Use initializeWithValues:"
]

{ #category : #initialization }
FiSet >> initializeWithValues: aCollection [ 

	| index |	
	self initialize.
	
	index := 1.
	aCollection do: [ :each | 
		self at: index put: each. 
		index := index + 1 ]
]

{ #category : #enumerating }
FiSet >> inject: thisValue into: binaryBlock [ 
	
	^ self values inject: thisValue into: binaryBlock 
]

{ #category : #'new-tools' }
FiSet >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Values'>

	^ self asArray inspectionItems: aBuilder
]

{ #category : #testing }
FiSet >> isEmpty [
	
	^ self stepCount = 0
]

{ #category : #printing }
FiSet >> printOn: aStream [

	super printOn: aStream.
	self values printElementsOn: aStream.

]

{ #category : #enumerating }
FiSet >> select: aBlockClosure [ 
	
	| newSet |
	newSet := Set new: self size.
	
	self valuesDo: [ :each | 
		(aBlockClosure value: each) 
			ifTrue: [ newSet add: each ] ].

	^ newSet

]

{ #category : #accessing }
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

{ #category : #printing }
FiSet >> stonOn: stonWriter [
	"Taken from Collection"

	stonWriter writeObject: self do: [
		stonWriter encodeList: self values ]

]

{ #category : #printing }
FiSet >> storeOn: aStream indent: level [

	self isEmpty ifTrue: [ 
		aStream nextPutAll: '{ } asFiSet'.
		^ self ].

	aStream 
		nextPut: ${;
		cr.
		
	self valuesDo: [ :value |
		aStream 
			tab: level.
		
		value storeOn: aStream indent: level + 1.
		
		aStream 
			nextPut: $.;
			cr. ].
		
	aStream 
		tab: level;
		nextPutAll: '} asFiSet'.
]

{ #category : #accessing }
FiSet >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self 
		indexOf: step 
		ifPresent: [ :index | presentBlock value: (self at: index) ]
		ifAbsent: absentBlock
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
