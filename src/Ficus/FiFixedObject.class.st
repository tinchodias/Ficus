"
I represent a fixed object. This means that I have named slots.
"
Class {
	#name : #FiFixedObject,
	#superclass : #FiObject,
	#category : #'Ficus-Model-Core'
}

{ #category : #'instance creation' }
FiFixedObject class >> builder [
	
	^ FiObjectBuilder forClass: self
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

{ #category : #changes }
FiFixedObject >> changeOfAcceptSlot: anAcceptSlot [

	| oldValue |
	oldValue := self valueAt: anAcceptSlot slotName.

	^ oldValue = (oldValue resultOf: anAcceptSlot edit)
		ifTrue: [ anAcceptSlot changeNothing ]
		ifFalse: [ anAcceptSlot changeUpdate: oldValue ]
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

	self initialize.
	
	aDictionary keysAndValuesDo: [ :slotName :value |
		[ self instVarNamed: slotName put: value ]
			on: Error 
			do: [ :e | 
				self error: slotName asString, ' not found in ', self asString ] ]
]

{ #category : #results }
FiFixedObject >> resultOfAcceptSlot: anAcceptSlot [ 

	^ self copy
		resetCachedHash;
		instVarNamed: anAcceptSlot slotName
		put: ((self valueAt: anAcceptSlot slotName) resultOf: anAcceptSlot edit);
		yourself

]

{ #category : #accessing }
FiFixedObject >> steps [
	
	^ self class steps
]

{ #category : #enumerating }
FiFixedObject >> stepsAndValuesDo: aBlockClosure [ 

	^ self steps do: [ :name |
		aBlockClosure 
			value: name 
			value: (self valueAt: name) ]

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
