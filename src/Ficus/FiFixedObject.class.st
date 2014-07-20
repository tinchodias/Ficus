"
I represent a fixed object. This means that I have named slots.
"
Class {
	#name : #FiFixedObject,
	#superclass : #FiShot,
	#category : #'Ficus-Model-Core'
}

{ #category : #edits }
FiFixedObject >> at: aSlotName edit: aBlockClosure [ 
	
	^ FiAcceptSlot
		slotName: aSlotName
		edit: (aBlockClosure value: (self shotAt: aSlotName))
]

{ #category : #edits }
FiFixedObject >> at: step equal: value [

	^ FiAcceptSlot 
		slotName: step
		edit: (FiEqual value: value)
]

{ #category : #differencing }
FiFixedObject >> differenceFrom: other [

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		| value subDifference |
		value := self shotAt: step.
		subDifference := value differenceFrom: otherValue.
		
		subDifference isNoEffect ifFalse: [
			subEffects add: 
				(FiSlotUpdateEffect builder
					slotName: step;
					oldValue: otherValue;
					newValue: value;
					subEffect: subDifference;
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
FiFixedObject >> effectOfAcceptSlot: anAcceptSlot [

	| oldValue |
	oldValue := self shotAt: anAcceptSlot slotName.

	^ oldValue = (oldValue resultOf: anAcceptSlot edit)
		ifTrue: [ anAcceptSlot effectNothing ]
		ifFalse: [ anAcceptSlot effectUpdate: oldValue ]
]

{ #category : #accessing }
FiFixedObject >> excludedInstanceVariableNamesForSteps [

	^ #(tag cachedHash)
]

{ #category : #initialization }
FiFixedObject >> initializeFromStepsAndValues: aDictionary [

	self initialize.
	
	aDictionary 
		keysAndValuesDo: [ :slotName :value |
			self instVarNamed: slotName put: value ]
]

{ #category : #results }
FiFixedObject >> resultOfAcceptSlot: anAcceptSlot [ 

	^ self copy
		instVarNamed: anAcceptSlot slotName
		put: ((self instVarNamed: anAcceptSlot slotName) resultOf: anAcceptSlot edit);
		yourself

]

{ #category : #accessing }
FiFixedObject >> shotAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	step isSymbol ifFalse: [ ^ absentBlock value ].

	^ presentBlock value: (self instVarNamed: step)
]

{ #category : #accessing }
FiFixedObject >> stepCount [
	
	^ self class allInstVarNames size - self excludedInstanceVariableNamesForSteps size
]

{ #category : #enumerating }
FiFixedObject >> stepsAndValuesDo: aBlockClosure [ 

	| excludedInstanceVariableNames |
	excludedInstanceVariableNames := self excludedInstanceVariableNamesForSteps.

	^ self class allInstVarNames do: [ :name |
		(excludedInstanceVariableNames includes: name) ifFalse: [
			aBlockClosure 
				value: name 
				value: (self instVarNamed: name)] ]

]
