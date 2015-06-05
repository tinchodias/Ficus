"
I represent an immutable object which must not form cycles (i.e. a Directed Acyclic Graph). 

A shot has #steps, which are Symbol names which can be used to access corresponding #values.

Each shot provides an #edits protocol that builds ""edits"", i.e. instances of a class in the hierarchy of FiEdit.

Then, an edit can be used to calculate either:
- the result of the application of the edit, with: aShot resultOf: anEdit.
- the effect of the application of the edit, with: aShot effectOf: anEdit.


"
Class {
	#name : #FiObject,
	#superclass : #Object,
	#instVars : [
		'cachedHash'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiObject class >> newFromStepsAndValues: aCollection [ 
	
	^ self basicNew
		initializeFromStepsAndValues: aCollection;
		yourself
]

{ #category : #accessing }
FiObject class >> steps [
	"Answer the collection of steps that all of my instances must have."
	
	^ #()
]

{ #category : #comparing }
FiObject >> = another [
	
	self == another ifTrue: [ ^ true ].
	self class = another class ifFalse: [ ^ false ].
	self hash = another hash ifFalse: [ ^ false ].
	self stepCount = another stepCount ifFalse: [ ^ false ].
	
	self stepsAndValuesDo: [ :step :value | 
		another 
			valueAt: step 
			ifPresent: [ :otherValue | value = otherValue ifFalse: [ ^ false ] ]
			ifAbsent: [ ^ false ] ].
		
	^ true	

]

{ #category : #differencing }
FiObject >> differenceFrom: other [

	^ self subclassResponsibility 
]

{ #category : #edits }
FiObject >> editAll: aCollectionOfEdits [
	
	^ FiEdit fromAll: aCollectionOfEdits
]

{ #category : #edits }
FiObject >> editAt: step do: aBlockClosure [ 

	^ self subclassResponsibility
]

{ #category : #edits }
FiObject >> editAtPath: aPath do: aBlockClosure [

	| target edit |
	target := aPath resolvedOn: self.
	edit := aBlockClosure value: target.

	^ aPath length isZero
		ifTrue: [ edit ]
		ifFalse: [ FiSubEdit path: aPath edit: edit ]
]

{ #category : #edits }
FiObject >> editFromSimpleEffects: simpleEffects [
	"Convert as edit, assuming the FiSimpleEffect applies to myself *as root*."

	^ self editAll: (simpleEffects collect: [ :each | 
		self 
			editAtPath: each path basePath "skip the last step of the path of the simple effect"
			do: [ :target | target editFromSimpleEffect: each ]])
]

{ #category : #effects }
FiObject >> effectOf: anEdit [ 

	^ anEdit effectOn: self
]

{ #category : #effects }
FiObject >> effectOfCompositeEdit: aCompositeEdit [ 

	^ FiCompositeEffect builder
		children: (aCompositeEdit children values collect: [ :anEdit | anEdit effectOn: self ]) asFiSet;
		new
]

{ #category : #effects }
FiObject >> effectOfSubEdit: aSubEdit [ 

	self flag: #fix. "inefficient".
	
	^ (self resultOf: aSubEdit) differenceFrom: self
]

{ #category : #enumerating }
FiObject >> ficusDeepCollect: aBlock basePath: aPath [

	| collectionFromChildren |
	collectionFromChildren := 
		Array streamContents: [ :stream |	
			self stepsAndValuesDo: [ :step :value | 
				stream nextPut: (value ficusDeepCollect: aBlock basePath: (aPath / step)) ]].

	^ aBlock 
		value: self 
		value: aPath 
		value: collectionFromChildren
]

{ #category : #enumerating }
FiObject >> ficusDeepDo: aBlock [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock ].

	^ aBlock value: self
]

{ #category : #enumerating }
FiObject >> ficusDeepDo: aBlock basePath: aPath [

	self stepsAndValuesDo: [ :step :value |
		value ficusDeepDo: aBlock basePath: (aPath / step) ].

	^ aBlock 
		value: self 
		value: aPath
]

{ #category : #testing }
FiObject >> hasValueAt: step [

	^ self 
		valueAt: step 
		ifPresent: [ :v | true ]
		ifAbsent: [ false ]
]

{ #category : #comparing }
FiObject >> hash [
	
	^ cachedHash ifNil: [ cachedHash := self uncachedHash ]
]

{ #category : #initialization }
FiObject >> initializeFromStepsAndValues: aDictionary [

	self subclassResponsibility 
]

{ #category : #testing }
FiObject >> isFiObject [
	
	^ true
]

{ #category : #accessing }
FiObject >> resetCachedHash [

	cachedHash := nil
]

{ #category : #results }
FiObject >> resultOfCompositeEdit: aCompositeEdit [ 

	^ aCompositeEdit children values
		inject: self
		into: [ :copy :edit | copy resultOf: edit ]
]

{ #category : #results }
FiObject >> resultOfSubEdit: aSubEdit [ 
	
	^ self 
		resultOfSubEdit: aSubEdit
		steps: (aSubEdit path asPathOn: self) steps
]

{ #category : #results }
FiObject >> resultOfSubEdit: aSubEdit steps: anArrayOfSteps [
	
	| anEdit |
	anEdit := anArrayOfSteps 
		ifEmpty: [ aSubEdit edit ]
		ifNotEmpty: [ 
			self 
				editAt: anArrayOfSteps first
				do: [ :aValue | 
					FiEqual value: 
						(aValue 
							resultOfSubEdit: aSubEdit 
							steps: anArrayOfSteps allButFirst) ] ].
					
	^ self resultOf: anEdit
]

{ #category : #accessing }
FiObject >> stepCount [
	
	^ self steps size
]

{ #category : #accessing }
FiObject >> steps [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step ].

	^ result
]

{ #category : #enumerating }
FiObject >> stepsAndValues [

	| result |
	result := Set new.

	self stepsAndValuesDo: [ :step :value |
		result add: step -> value ].

	^ result
]

{ #category : #enumerating }
FiObject >> stepsAndValuesDo: aBlockClosure [ 

	^ self subclassResponsibility 
]

{ #category : #printing }
FiObject >> stonOn: stonWriter [

	stonWriter 
		writeObject: self 
		streamMap: [ :dictionary | 
			self stepsAndValuesDo: [ :step :value | 
				dictionary at: step put: value ] ]
]

{ #category : #printing }
FiObject >> storeOn: aStream [

	self storeOn: aStream indent: 1
]

{ #category : #printing }
FiObject >> storeOn: aStream indent: level [

	self subclassResponsibility 
]

{ #category : #comparing }
FiObject >> uncachedHash [
	
	| hash |
	hash := self class hash.
	
	self stepsAndValuesDo: [ :step :value | 
		hash := (hash bitXor: step hash) bitXor: value hash ].
		
	^ hash
]

{ #category : #accessing }
FiObject >> valueAt: step [

	^ self 
		valueAt: step 
		ifPresent: [ :shot | shot ]
		ifAbsent: [ StepNotFound signalFor: step in: self ]
]

{ #category : #accessing }
FiObject >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiObject >> values [
	
	^ Array streamContents: [ :stream |
		self valuesDo: [ :each | stream nextPut: each ] ]

]

{ #category : #enumerating }
FiObject >> valuesDo: elementBlock [
	"Evaluates the block on each value of this object"
	
	^ self stepsAndValuesDo: [ :step :value | elementBlock value: value ]
]
