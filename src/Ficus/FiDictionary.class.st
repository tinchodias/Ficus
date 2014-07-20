"
I represent a dictionary.
"
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

	^ self builder new
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

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			shotAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value differenceFrom: otherValue.
				
				subDifference isNoEffect ifFalse: [
					subEffects add: 
						(FiDictionaryUpdateEffect builder
							key: key;
							newValue: value;
							oldValue: otherValue;
							subEffect: subDifference;
							new) ] ]
			ifAbsent: [ 
				subEffects add: 
					(FiDictionaryRemoveEffect builder
						key: key;
						oldValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			subEffects add: 
				(FiDictionaryAddEffect builder
					key: key;
					newValue: value;
					new) ] ].
	
	^ subEffects
		ifEmpty: [ FiNoEffect new ]
		ifNotEmpty: [ subEffects size = 1
			ifTrue: [ subEffects anyOne ]
			ifFalse: [ 
				FiCompositeEffect builder
					subEffects: (FiSet withValues: subEffects);
					new ] ]
]

{ #category : #effects }
FiDictionary >> effectOfAcceptKey: anAcceptKey [ 

	^ self 
		shotAt: anAcceptKey key
		ifPresent: [ :aValue | 
			aValue = (anAcceptKey edit resultOn: aValue)
				ifTrue: [ anAcceptKey effectNothing ]
				ifFalse: [ anAcceptKey effectUpdate: aValue ] ] 
		ifAbsent: [ anAcceptKey effectAdd ].
]

{ #category : #effects }
FiDictionary >> effectOfExcludeKey: anExcludeKey [

	^ self 
		shotAt: anExcludeKey key
		ifPresent: [ :aValue | anExcludeKey effectRemove: aValue ]
		ifAbsent: [ anExcludeKey effectNothing ]
]

{ #category : #edits }
FiDictionary >> exclude: key [

	^ FiExcludeKey key: key
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

{ #category : #accessing }
FiDictionary >> valueByKey [
	^ valueByKey
]
