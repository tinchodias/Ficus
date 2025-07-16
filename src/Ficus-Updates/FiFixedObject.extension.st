Extension { #name : #FiFixedObject }

{ #category : #'*Ficus-Updates' }
FiFixedObject >> changeFrom: other [

	| changes |	
	self == other ifTrue: [ ^ FiNoChange new ].
	self class == other class ifFalse: [ ^ other changeOfReplaceBy: self ].

	changes := Set new.
	
	other stepsAndValuesDo: [ :step :otherValue | 
		| value subDifference |
		value := self valueAt: step.
		subDifference := value changeFrom: otherValue.
		
		subDifference isNoChange ifFalse: [
			changes add: 
				(FiFixedObjectUpdate builder
					slotName: step;
					oldValue: otherValue;
					newValue: value;
					child: subDifference;
					new) ] ].

	^ FiChange fromAll: changes
]

{ #category : #'*Ficus-Updates' }
FiFixedObject >> changeOfAcceptSlot: anAcceptSlot [

	| oldValue |
	oldValue := self valueAt: anAcceptSlot slotName.

	^ oldValue = (oldValue resultOf: anAcceptSlot edit)
		ifTrue: [ anAcceptSlot changeNothing ]
		ifFalse: [ anAcceptSlot changeUpdate: oldValue ]
]

{ #category : #'*Ficus-Updates' }
FiFixedObject >> editAt: aSlotName do: aBlockClosure [ 
	
	^ FiFixedObjectAccept
		slotName: aSlotName
		edit: (aBlockClosure value: (self valueAt: aSlotName))
]

{ #category : #'*Ficus-Updates' }
FiFixedObject >> editAt: step equal: value [

	^ FiFixedObjectAccept 
		slotName: step
		edit: (FiEqual value: value)
]

{ #category : #'*Ficus-Updates' }
FiFixedObject >> editFromSimpleChange: aSimpleChange [
	"Convert as edit, assuming the FiSimpleChange applies to myself."
	
	^ self 
		editAt: aSimpleChange path step
		do: [ :oneStepForward |
			aSimpleChange children asArray
				ifEmpty: [ 
					oneStepForward editReplaceBy: aSimpleChange newValue ]
				ifNotEmpty: [ :children | 
					self editAll: (children collect: [ :each | 
						oneStepForward editFromSimpleChange: each ]) ]].
]

{ #category : #'*Ficus-Updates' }
FiFixedObject >> resultOfAcceptSlot: anAcceptSlot [ 

	^ self copy
		resetCachedHash;
		instVarNamed: anAcceptSlot slotName
		put: ((self valueAt: anAcceptSlot slotName) resultOf: anAcceptSlot edit);
		yourself

]
