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

	| internalEdits |	
	self == other ifTrue: [ ^ self noEdit ].
	self class == other class ifFalse: [ self shouldBeImplemented ].

	internalEdits := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		| value edit |
		value := self shotAt: step.
		edit := value differenceFrom: otherValue.
		
		edit isNoEdit ifFalse: [
			internalEdits add: (FiAcceptSlot slotName: step edit: edit) ] ].

	^ internalEdits
		ifEmpty: [ self noEdit ]
		ifNotEmpty: [ internalEdits size = 1
			ifTrue: [ internalEdits anyOne ]
			ifFalse: [ self edits: internalEdits ] ]
]

{ #category : #effects }
FiFixedObject >> effectOfAcceptSlot: anAcceptSlot [

	^ anAcceptSlot effectUpdate: (self instVarNamed: anAcceptSlot slotName)
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

	^ (self respondsTo: step)
		ifTrue: [ presentBlock cull: (self perform: step) ]
		ifFalse: absentBlock
]

{ #category : #accessing }
FiFixedObject >> stepCount [
	
	^ self class allInstVarNames size - 1 "discount #tag"
]

{ #category : #enumerating }
FiFixedObject >> stepsAndValuesDo: aBlockClosure [ 

	^ self class instanceVariableNamesDo: [ :name |
		(name ~= #tag) ifTrue: [
			aBlockClosure 
				value: name asSymbol 
				value: (self instVarNamed: name)] ]

]
