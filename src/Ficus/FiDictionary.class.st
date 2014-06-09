Class {
	#name : #FiDictionary,
	#superclass : #FiShot,
	#instVars : [
		'valueByKey'
	],
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiDictionary class >> new [

	^ self newFromStepsAndValues: Dictionary new
]

{ #category : #edits }
FiDictionary >> at: step edit: aBlockClosure [ 
	
	^ FiAcceptKey 
		key: step
		edit: (aBlockClosure value: (self shotAt: step))
]

{ #category : #edits }
FiDictionary >> at: step equal: value [

	^ FiAcceptKey 
		key: step
		edit: (FiEqual value: value)
]

{ #category : #differencing }
FiDictionary >> differenceFrom: other [

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
			ifFalse: [ internalEdits add: (other at: key equal: value) ] ].
	
	^ internalEdits
		ifEmpty: [ self noEdit ]
		ifNotEmpty: [ internalEdits size = 1
			ifTrue: [ internalEdits anyOne ]
			ifFalse: [ self edits: internalEdits ] ]
]

{ #category : #effects }
FiDictionary >> effectOfAcceptKey: anAcceptKey [ 

	self flag: #fix. "theValue"

	^ self valueByKey
		at: anAcceptKey key
		ifPresent: [ :aValue | 
			aValue = anAcceptKey edit theValue
				ifTrue: [ anAcceptKey effectNothing ]
				ifFalse: [ anAcceptKey effectUpdate: aValue ] ] 
		ifAbsent: [ anAcceptKey effectAdd ].
]

{ #category : #effects }
FiDictionary >> effectOfExcludeKey: anExcludeKey [

	^ self valueByKey
		at: anExcludeKey key
		ifPresent: [ :aValue | anExcludeKey effectRemove: aValue ]
		ifAbsent: [ anExcludeKey effectNothing ]
]

{ #category : #edits }
FiDictionary >> exclude: key [

	^ FiExcludeKey key: key
]

{ #category : #enumerating }
FiDictionary >> ficusDeepCollect: aBlock [

	| newValueByKey |
	newValueByKey := Dictionary new.
	
	self stepsAndValuesDo: [ :key :value | 
		newValueByKey 
			at: (key ficusDeepCollect: aBlock)
			put: (value ficusDeepCollect: aBlock) ].

	^ aBlock value: (self species newFromStepsAndValues: newValueByKey)
]

{ #category : #initialization }
FiDictionary >> initializeFromStepsAndValues: aCollection [ 
	
	self initialize.
	
	valueByKey := aCollection.
]

{ #category : #printing }
FiDictionary >> printOn: aStream [

	super printOn: aStream.
	valueByKey printElementsOn: aStream.

]

{ #category : #results }
FiDictionary >> resultOfAcceptKey: anAcceptKey [

	| newValue |
	newValue := self 
		shotAt: anAcceptKey key
		ifPresent: [ :aValue | 
			anAcceptKey edit resultOn: aValue ]
		ifAbsent: [ 
			self flag: #todo. "FIX".
			anAcceptKey edit resultOn: nil ].
		
	^ self species 
		newFromStepsAndValues:
			(valueByKey copy
				at: anAcceptKey key
				put: newValue;
				yourself)
]

{ #category : #results }
FiDictionary >> resultOfExcludeKey: anExcludeKey [

	^ self species 
		newFromStepsAndValues:
			(valueByKey copy
				removeKey: anExcludeKey key;
				yourself)
]

{ #category : #accessing }
FiDictionary >> shotAt: key [
	
	^ valueByKey at: key
]

{ #category : #accessing }
FiDictionary >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ valueByKey 
		at: step
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #enumerating }
FiDictionary >> stepCount [
	
	^ valueByKey size
]

{ #category : #enumerating }
FiDictionary >> stepsAndValuesDo: aBlock [

	^ valueByKey keysAndValuesDo: aBlock
]

{ #category : #pruning }
FiDictionary >> untaggedPruned [

	| newValueByKey |
	newValueByKey := Dictionary new.
	
	self stepsAndValuesDo: [ :key :value | 
		newValueByKey 
			at: key pruned
			put: value pruned ].

	^ self species newFromStepsAndValues: newValueByKey
]

{ #category : #accessing }
FiDictionary >> valueByKey [
	^ valueByKey
]
