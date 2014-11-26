"
I represent a fixed object. This means that I have named slots.
"
Class {
	#name : #FiFixedObject,
	#superclass : #FiShot,
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiFixedObject class >> builder [
	
	^ FiShotBuilder forClass: self
]

{ #category : #differencing }
FiFixedObject >> differenceFrom: other [

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ ^ other effectOfReplaceBy: self ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		| value subDifference |
		value := self valueAt: step.
		subDifference := value differenceFrom: otherValue.
		
		subDifference isNoEffect ifFalse: [
			subEffects add: 
				(FiSlotUpdate builder
					slotName: step;
					oldValue: otherValue;
					newValue: value;
					subEffect: subDifference;
					new) ] ].

	^ FiEditEffect fromAll: subEffects
]

{ #category : #edits }
FiFixedObject >> editAt: aSlotName do: aBlockClosure [ 
	
	^ FiAcceptSlot
		slotName: aSlotName
		edit: (aBlockClosure value: (self valueAt: aSlotName))
]

{ #category : #edits }
FiFixedObject >> editAt: step equal: value [

	^ FiAcceptSlot 
		slotName: step
		edit: (FiEqual value: value)
]

{ #category : #convenience }
FiFixedObject >> editor [
	
	^ FiFixedObjectEditor for: self
]

{ #category : #effects }
FiFixedObject >> effectOfAcceptSlot: anAcceptSlot [

	| oldValue |
	oldValue := self valueAt: anAcceptSlot slotName.

	^ oldValue = (oldValue resultOf: anAcceptSlot edit)
		ifTrue: [ anAcceptSlot effectNothing ]
		ifFalse: [ anAcceptSlot effectUpdate: oldValue ]
]

{ #category : #initialization }
FiFixedObject >> initializeFromStepsAndValues: aDictionary [

	| excludedInstanceVariableNames |
	excludedInstanceVariableNames := self class excludedInstanceVariableNamesForSteps.
	self initialize.
	
	aDictionary 
		keysAndValuesDo: [ :slotName :value |
			(excludedInstanceVariableNames includes: slotName)
				ifTrue: [ self error ].

			self instVarNamed: slotName put: value ]
]

{ #category : #accessing }
FiFixedObject >> resetCachedHash [

	cachedHash := nil
]

{ #category : #results }
FiFixedObject >> resultOfAcceptSlot: anAcceptSlot [ 

	^ self copy
		resetCachedHash;
		instVarNamed: anAcceptSlot slotName
		put: ((self instVarNamed: anAcceptSlot slotName) resultOf: anAcceptSlot edit);
		yourself

]

{ #category : #summary }
FiFixedObject >> resultOfHierarchicalSummary: aHierarchicalSummary [
	"Each item in aHierarchicalSummary is an update."
	
	| result |
	result := aHierarchicalSummary 
		inject: self 
		into: [ :aShot :aSummary |
			| edit |
			edit := aShot 
				editAt: aSummary path step 
				equal: aSummary newValue.
			aShot resultOf: edit ].
		
	^ result
]

{ #category : #accessing }
FiFixedObject >> stepCount [
	
	^ self class allInstVarNames size - self class excludedInstanceVariableNamesForSteps size
]

{ #category : #enumerating }
FiFixedObject >> stepsAndValuesDo: aBlockClosure [ 

	| excludedInstanceVariableNames |
	excludedInstanceVariableNames := self class excludedInstanceVariableNamesForSteps.

	^ self class allInstVarNames do: [ :name |
		(excludedInstanceVariableNames includes: name) ifFalse: [
			aBlockClosure 
				value: name 
				value: (self instVarNamed: name)] ]

]

{ #category : #printing }
FiFixedObject >> storeOn: aStream indent: level [

	self stepCount isZero ifTrue: [ 
		aStream 
			nextPutAll: self className;
			space;
			nextPutAll: #new.
		^ self ].

	aStream 
		nextPut: $(;
		nextPutAll: self className;
		space;
		nextPutAll: #builder;
		cr.
	
	self stepsAndValuesDo: [ :step :value |
		aStream 
			tab: level;
			nextPutAll: step;
			nextPutAll: ': '.
			
		value storeOn: aStream indent: level + 1.
		
		aStream 
			nextPutAll: ';';
			cr. ].
		
	aStream 
		tab: level;
		nextPutAll: #new;
		nextPut: $).
]

{ #category : #accessing }
FiFixedObject >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	step isSymbol ifFalse: [ ^ absentBlock value ].

	^ presentBlock value: (self instVarNamed: step)
]
