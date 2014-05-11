Class {
	#name : #FiDictionary,
	#superclass : #FiShot,
	#instVars : [
		'valueByKey'
	],
	#category : #'Ficus-Model-Core'
}

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
	
	other valueByKey keysAndValuesDo: [ :key :otherValue | 
		self valueByKey
			at: key
			ifPresent: [ :value | 
				(otherValue = value) ifFalse: [
					internalEdits add: (other at: key equal: value) ] ]
			ifAbsent: [ 
				internalEdits add: (other exclude: key) ] ].

	self valueByKey keysAndValuesDo: [ :key :value |
		(other valueByKey includesKey: key)
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

	| copy newValueByKey |
	copy := self copy.
	
	newValueByKey := self valueByKey species new.
	
	self valueByKey keysAndValuesDo: [ :key :value | 
		newValueByKey 
			at: (key ficusDeepCollect: aBlock)
			put: (value ficusDeepCollect: aBlock) ].

	copy valueByKey: newValueByKey.
		
	^ aBlock value: copy
]

{ #category : #initialize }
FiDictionary >> initialize [

	super initialize.

	valueByKey := Dictionary new.
]

{ #category : #printing }
FiDictionary >> printOn: aStream [

	super printOn: aStream.
	self valueByKey printElementsOn: aStream.

]

{ #category : #results }
FiDictionary >> resultOfAcceptKey: anAcceptKey [

	self flag: #fix.

	^ self copy
		valueByKey:
			(self valueByKey copy
				at: anAcceptKey key
				put: anAcceptKey edit theValue; "Assume it is a FiEqual..."
				yourself);
		yourself

]

{ #category : #results }
FiDictionary >> resultOfExcludeKey: anExcludeKey [

	^ self copy
		valueByKey:
			(self valueByKey copy
				removeKey: anExcludeKey key;
				yourself);
		yourself

]

{ #category : #accessing }
FiDictionary >> shotAt: key [
	
	^ self valueByKey at: key
]

{ #category : #enumerating }
FiDictionary >> stepCount [
	
	^ self valueByKey size
]

{ #category : #enumerating }
FiDictionary >> stepsAndValuesDo: aBlock [

	^ self valueByKey keysAndValuesDo: aBlock
]

{ #category : #pruning }
FiDictionary >> untaggedPruned [

	| copy newValueByKey |
	copy := self copy.
	
	newValueByKey := self valueByKey species new.
	
	self valueByKey keysAndValuesDo: [ :key :value | 
		newValueByKey 
			at: key pruned
			put: value pruned ].

	^ copy 
		valueByKey: newValueByKey;
		yourself
]

{ #category : #accessing }
FiDictionary >> valueByKey [
	^ valueByKey
]

{ #category : #accessing }
FiDictionary >> valueByKey: anObject [
	valueByKey := anObject
]
