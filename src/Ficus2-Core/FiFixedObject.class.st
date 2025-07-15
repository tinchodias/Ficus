"
I represent a fixed object. This means that I have named slots.
"
Class {
	#name : #FiFixedObject,
	#superclass : #FiObject,
	#category : #'Ficus2-Core-Model'
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

{ #category : #initialization }
FiFixedObject >> initializeFromStepsAndValues: aDictionary [
	| selector |
	self initialize.
	aDictionary
		keysAndValuesDo: [ :slotName :value | 
			selector := (slotName , ':') asSymbol.
			
			(self respondsTo: selector)
				ifTrue: [ self perform: selector with: value ]
				ifFalse: [ [ self instVarNamed: slotName put: value ]
						on: Error
						do: [ :e | self error: slotName asString , ' not found in ' , self asString ] ] ]
]

{ #category : #'new-tools' }
FiFixedObject >> inspectionTree: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Steps and Values'>

	^ aBuilder newTable
		  items: self stepsAndValues asArray sorted;
		  addColumn: (SpStringTableColumn title: 'Step' evaluated: #key);
		  addColumn: (SpStringTableColumn title: 'Value' evaluated: #value);
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
