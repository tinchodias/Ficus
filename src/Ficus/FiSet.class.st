"
I represent a set. TODO
"
Class {
	#name : #FiSet,
	#superclass : #FiShot,
	#type : #variable,
	#category : #'Ficus-Model-Core'
}

{ #category : #ston }
FiSet class >> fromSton: stonReader [

	| values |
	values := Array streamContents: [ :stream |
		stonReader parseListDo: [ :each | 
			stream nextPut: each ]].
	
	^ self withValues: values
]

{ #category : #'instance creation' }
FiSet class >> new [

	^ self withValues: #()
]

{ #category : #'instance creation' }
FiSet class >> newFromStepsAndValues: aDictionary [ 
	
	^ self withValues: aDictionary values
]

{ #category : #'instance creation' }
FiSet class >> withValues: aCollection [ 
	
	^ (self basicNew: aCollection size)
		initializeWithValues: aCollection;
		yourself
]

{ #category : #converting }
FiSet >> asArray [
	
	^ (1 to: self size) collect: [ :index | self at: index ] as: Array
]

{ #category : #converting }
FiSet >> asDictionary [

	| result |
	result := Dictionary new.

	self stepsAndValuesDo: [ :step :value |
		result at: step put: value ].
	
	^ result
]

{ #category : #enumerating }
FiSet >> collect: aBlockClosure [ 
	
	| newSet |
	newSet := Set new: self size.
	self valuesDo: [ :each | newSet add: (aBlockClosure value: each) ].
	^ newSet
]

{ #category : #differencing }
FiSet >> differenceFrom: other [

	| subEffects |	
	self == other ifTrue: [ ^ FiNoEffect new ].
	self class == other class ifFalse: [ ^ other effectOfReplaceBy: self ].

	subEffects := Set new.
	
	other stepsAndValuesDo: [ :key :otherValue | 
		self
			valueAt: key
			ifPresent: [ :value | 
				| subDifference |
				subDifference := value differenceFrom: otherValue.
				
				subDifference isNoEffect ifFalse: [
					subEffects add: 
						(FiSetUpdate builder
							newValue: value;
							oldValue: otherValue;
							subEffect: subDifference;
							new) ] ]
			ifAbsent: [ 
				subEffects add: 
					(FiSetRemoval builder
						oldValue: otherValue;
						new) ] ].

	self stepsAndValuesDo: [ :key :value |
		(other steps includes: key) ifFalse: [ 
			subEffects add: 
				(FiSetAddition builder
					newValue: value;
					new) ] ].
	
	^ FiEffect fromAll: subEffects
]

{ #category : #enumerating }
FiSet >> do: aBlockClosure [ 
	
	^ self valuesDo: aBlockClosure
]

{ #category : #edits }
FiSet >> editAt: step do: aBlockClosure [ 

	| aShot |
	aShot := self valueAt: step.

	^ self editInclude: (aShot resultOf: (aBlockClosure value: aShot))
]

{ #category : #edits }
FiSet >> editExclude: aValue [

	^ FiExclude value: aValue
]

{ #category : #edits }
FiSet >> editFromSimpleEffect: aSimpleEffect [
	
	| workaroundPath |
	self flag: #fix. "this is horrible..."
	workaroundPath := aSimpleEffect path length isZero
		ifTrue: [ aSimpleEffect path ]
		ifFalse: [ aSimpleEffect path basePath ].
	
	^ self 
		editAtPath: workaroundPath
		do: [ :target |
			aSimpleEffect
				ifAdd: [ target editInclude: aSimpleEffect newValue ] 
				ifRemove: [ target editExclude: aSimpleEffect oldValue ] 
				ifUpdate: [ target editInclude: aSimpleEffect newValue ] ]
]

{ #category : #edits }
FiSet >> editInclude: aValue [

	^ FiInclude value: aValue
]

{ #category : #effects }
FiSet >> effectOfExclude: anExclude [ 

	^ self 
		valueAt: anExclude theValue defaultStep
		ifPresent: [ :aValue | anExclude effectRemove: aValue ]
		ifAbsent: [ anExclude effectNothing ]
]

{ #category : #effects }
FiSet >> effectOfInclude: anInclude [ 

	^ self 
		valueAt: anInclude theValue defaultStep
		ifPresent: [ :aValue | 
			| difference |
			difference := anInclude theValue differenceFrom: aValue.
			
			difference isNoEffect
				ifTrue: [ anInclude effectNothing ]
				ifFalse: [ 
					FiSetUpdate builder
						newValue: anInclude theValue;
						oldValue: aValue;
						subEffect: difference;
						new ] ] 
		ifAbsent: [ anInclude effectAdd ].
]

{ #category : #printing }
FiSet >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ (composite list)
		title: [ :anObject | anObject size asString, ' values' ];
		display: [ :aFiSet | self asArray asSet ];
		showOnly: 50.
]

{ #category : #private }
FiSet >> indexOf: step ifPresent: presentBlock ifAbsent: absentBlock [

	self valuesWithIndexDo: [ :each :index | 
		each defaultStep = step ifTrue: [ ^ presentBlock cull: index ] ].

	^ absentBlock value
]

{ #category : #initialization }
FiSet >> initializeWithValues: aCollection [ 

	| index |	
	self initialize.
	
	index := 1.
	aCollection do: [ :each | 
		self at: index put: each. 
		index := index + 1 ]
]

{ #category : #enumerating }
FiSet >> inject: thisValue into: binaryBlock [ 
	
	^ self values inject: thisValue into: binaryBlock 
]

{ #category : #testing }
FiSet >> isEmpty [
	
	^ self stepCount = 0
]

{ #category : #printing }
FiSet >> printOn: aStream [

	super printOn: aStream.
	self values printElementsOn: aStream.

]

{ #category : #results }
FiSet >> resultOfExclude: anExclude [ 

	^ self species withValues: (self values copyWithout: anExclude theValue)
]

{ #category : #results }
FiSet >> resultOfInclude: anInclude [ 

	| newValues |
	newValues := self asArray copyWith: anInclude theValue.

	self 
		indexOf: anInclude theValue defaultStep 
		ifPresent: [ :index | newValues := newValues copyWithoutIndex: index ]
		ifAbsent: [ ].
		
	^ self species withValues: newValues
]

{ #category : #enumerating }
FiSet >> select: aBlockClosure [ 
	
	| newSet |
	newSet := Set new: self size.
	
	self valuesDo: [ :each | 
		(aBlockClosure value: each) 
			ifTrue: [ newSet add: each ] ].

	^ newSet

]

{ #category : #enumerating }
FiSet >> stepCount [
	
	^ self size
]

{ #category : #enumerating }
FiSet >> stepsAndValuesDo: aBlockClosure [ 

	^ self valuesDo: [ :each | 
		aBlockClosure 
			value: each defaultStep 
			value: each ]
]

{ #category : #printing }
FiSet >> stonOn: stonWriter [
	"Taken from Collection"

	stonWriter writeObject: self do: [
		stonWriter encodeList: self values ]

]

{ #category : #printing }
FiSet >> storeOn: aStream indent: level [

	self isEmpty ifTrue: [ 
		aStream 
			nextPutAll: self className;
			space;
			nextPutAll: #new.
		^ self ].

	aStream 
		nextPut: $(;
		nextPutAll: self className;
		space;
		nextPutAll: #withValues:;
		nextPutAll: ' {';
		cr.
		
	self valuesDo: [ :value |
		aStream 
			tab: level.
		
		value storeOn: aStream indent: level + 1.
		
		aStream 
			nextPut: $.;
			cr. ].
		
	aStream 
		tab: level;
		nextPutAll: '}';
		nextPut: $).
]

{ #category : #accessing }
FiSet >> valueAt: step ifPresent: presentBlock ifAbsent: absentBlock [

	^ self 
		indexOf: step 
		ifPresent: [ :index | presentBlock value: (self at: index) ]
		ifAbsent: absentBlock
]

{ #category : #enumerating }
FiSet >> valuesDo: elementBlock [ 

	^ self valuesWithIndexDo: [ :value :index | elementBlock value: value ]
]

{ #category : #private }
FiSet >> valuesWithIndexDo: elementAndIndexBlock [ 

	1 to: self size do: [ :index |
		elementAndIndexBlock
			value: (self at: index)
			value: index ]
]
