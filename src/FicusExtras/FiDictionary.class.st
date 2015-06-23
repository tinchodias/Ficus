"
I represent a dictionary.
"
Class {
	#name : #FiDictionary,
	#superclass : #FiObject,
	#instVars : [
		'valueByKey'
	],
	#category : #'FicusExtras-Model-Core'
}

{ #category : #'instance creation' }
FiDictionary class >> new [

	^ self newFromStepsAndValues: Dictionary new
]

{ #category : #differencing }
FiDictionary >> changeFrom: other [

	| changes |	
	self == other ifTrue: [ ^ FiNoChange new ].
	self class == other class ifFalse: [ ^ other changeOfReplaceBy: self ].

	changes := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			valueAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value changeFrom: otherValue.
				
				subDifference isNoChange ifFalse: [
					changes add: 
						(FiDictionaryUpdate builder
							key: key;
							newValue: value;
							oldValue: otherValue;
							child: subDifference;
							new) ] ]
			ifAbsent: [ 
				changes add: 
					(FiDictionaryRemoval builder
						key: key;
						oldValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			changes add: 
				(FiDictionaryAddition builder
					key: key;
					newValue: value;
					new) ] ].
	
	^ FiChange fromAll: changes
]

{ #category : #changes }
FiDictionary >> changeOfAcceptKey: anAcceptKey [ 

	^ self 
		valueAt: anAcceptKey key
		ifPresent: [ :aValue | 
			aValue = (anAcceptKey edit resultOn: aValue)
				ifTrue: [ anAcceptKey changeNothing ]
				ifFalse: [ anAcceptKey changeUpdate: aValue ] ] 
		ifAbsent: [ anAcceptKey changeAdd ].
]

{ #category : #changes }
FiDictionary >> changeOfExcludeKey: anExcludeKey [

	^ self 
		valueAt: anExcludeKey key
		ifPresent: [ :aValue | anExcludeKey changeRemove: aValue ]
		ifAbsent: [ anExcludeKey changeNothing ]
]

{ #category : #edits }
FiDictionary >> editAt: step do: aBlockClosure [ 
	
	^ FiAcceptKey 
		key: step
		edit: (aBlockClosure value: (self valueAt: step))
]

{ #category : #edits }
FiDictionary >> editAt: step equal: value [

	^ FiAcceptKey 
		key: step
		edit: (FiEqual value: value)
]

{ #category : #edits }
FiDictionary >> editExclude: key [

	^ FiExcludeKey key: key
]

{ #category : #edits }
FiDictionary >> editFromSimpleChange: aSimpleChange [
	"Convert as edit, assuming the FiSimpleChange applies to myself."
	
	aSimpleChange
		ifAdd: [ ^ self editAt: aSimpleChange path step equal: aSimpleChange newValue ] 
		ifRemove: [ ^ self editExclude: aSimpleChange path step ] 
		ifUpdate: [ ].
	
	^ aSimpleChange children asArray
		ifEmpty: [ self editAt: aSimpleChange path step equal: aSimpleChange newValue ]
		ifNotEmpty: [ :children | 
			self 
				editAt: aSimpleChange path step
				do: [ :oneStepForward |
					self editAll: (children collect: [ :each | 
						oneStepForward editFromSimpleChange: each ]) ]].
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
		valueAt: anAcceptKey key
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
FiDictionary >> stepCount [
	
	^ valueByKey size
]

{ #category : #enumerating }
FiDictionary >> stepsAndValuesDo: aBlock [

	^ valueByKey keysAndValuesDo: aBlock
]

{ #category : #accessing }
FiDictionary >> valueAt: key [
	
	^ valueByKey at: key
]

{ #category : #accessing }
FiDictionary >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ valueByKey 
		at: step
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #accessing }
FiDictionary >> valueByKey [

	^ valueByKey
]
