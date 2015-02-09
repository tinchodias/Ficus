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

{ #category : #accessing }
FiFixedObject class >> excludedInstanceVariableNamesForSteps [

	^ #(cachedHash)
]

{ #category : #accessing }
FiFixedObject class >> steps [

	^ self allInstVarNames copyWithoutAll: self excludedInstanceVariableNamesForSteps 
]

{ #category : #comparing }
FiFixedObject >> = another [
	"The difference with the super-implementation is that my #stepCount is fixed."
	
	self == another ifTrue: [ ^ true ].
	self class = another class ifFalse: [ ^ false ].
	self hash = another hash ifFalse: [ ^ false ].
	
	self stepsAndValuesDo: [ :step :value | 
		((another valueAt: step) = value) ifFalse: [ ^ false ] ].
		
	^ true	

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
				(FiFixedObjectUpdate builder
					slotName: step;
					oldValue: otherValue;
					newValue: value;
					subEffect: subDifference;
					new) ] ].

	^ FiEffect fromAll: subEffects
]

{ #category : #edits }
FiFixedObject >> editAt: aSlotName do: aBlockClosure [ 
	
	^ FiFixedObjectAccept
		slotName: aSlotName
		edit: (aBlockClosure value: (self valueAt: aSlotName))
]

{ #category : #edits }
FiFixedObject >> editAt: step equal: value [

	^ FiFixedObjectAccept 
		slotName: step
		edit: (FiEqual value: value)
]

{ #category : #edits }
FiFixedObject >> editFromSimpleEffect: aSimpleEffect basePath: basePath [
	
	| forwardPath newBasePath |
	self assert: 
		(basePath length isZero or: [ 
		aSimpleEffect path steps beginsWith: basePath steps ]).

	forwardPath := (aSimpleEffect path steps allButFirst: basePath length) asFiPath. 
	newBasePath := (aSimpleEffect path steps first: basePath length) asFiPath.

	^ self 
		editAtPath: forwardPath
		do: [ :shot |
			aSimpleEffect children asArray
				ifEmpty: [ shot editReplaceBy: aSimpleEffect newValue ]
				ifNotEmpty: [ :children | 
					shot 
						editFromSimpleEffects: children
						basePath: newBasePath ] ]
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

{ #category : #printing }
FiFixedObject >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite table
		title: [ :anObject | anObject stepCount asString, ' steps' ];
		display: [ :each | each stepsAndValues ];
		column: 'Step' evaluated: #key width: 120;
		column: 'Value' evaluated: #value;
		send: #value.
]

{ #category : #initialization }
FiFixedObject >> initializeFromStepsAndValues: aDictionary [

	| availableSteps |
	availableSteps := self class steps.
	self initialize.
	
	aDictionary 
		keysAndValuesDo: [ :slotName :value |
			(availableSteps includes: slotName) ifFalse: [ self error ].

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

{ #category : #accessing }
FiFixedObject >> stepCount [
	
	^ self class steps size
]

{ #category : #enumerating }
FiFixedObject >> stepsAndValuesDo: aBlockClosure [ 

	^ self class steps do: [ :name |
		aBlockClosure 
			value: name 
			value: (self instVarNamed: name) ]

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

	| stepValue |
	stepValue := self instVarAt: 
		(self class
			instVarIndexFor: step asString
			ifAbsent: [ ^ absentBlock value ]).

	^ presentBlock value: stepValue

]
