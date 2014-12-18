"
I know how to create set of Ficus Metalevel entities that exemplify the Fragile Base Problem.
"
Class {
	#name : #FiFragileBaseProblemResources,
	#superclass : #Object,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseProblemResources >> classClass [

	^ FiClass builder 
		theName: #Class;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {} asFiSet;
		new
]

{ #category : #resources }
FiFragileBaseProblemResources >> classCollection [

	^ FiClass builder 
		theName: #Collection;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: { 
			FiMethod sourceCode: 'add: anObject  self subclassResponsibility'.
			FiMethod sourceCode: 'do: aBlock  self subclassResponsibility'. 
			FiMethod sourceCode: 'isEmpty  ^ self size = 0'. 
			FiMethod sourceCode: 'size
	| tally |
	tally := 0.
	self do: [:each | tally := tally + 1].
	^ tally'
			} asFiSet;
		new.
]

{ #category : #resources }
FiFragileBaseProblemResources >> classLinkedList [

	^ FiClass builder 
		theName: #LinkedList;
		superclassName: #Collection;
		layout: (FiFixedLayout withInstanceVariables: #(firstLink lastLink));
		methods: (self methodsFor: { 
'add: anObject
	|aLink|
	aLink := ValueLink value: anObject.
	self isEmpty
		ifTrue: [firstLink := aLink]
		ifFalse: [lastLink nextLink: aLink].
	lastLink := aLink.
	^aLink'.
'removeFirst
	| oldLink |
	self isEmpty ifTrue: [self error].
	oldLink := firstLink.
	firstLink == lastLink
		ifTrue: [firstLink := nil. lastLink := nil]
		ifFalse: [firstLink := oldLink nextLink].
	oldLink nextLink: nil.
	^oldLink value'.
'do: aBlock
	| aLink |
	aLink := firstLink.
	[aLink == nil] whileFalse:
		[aBlock value: aLink value.
		 aLink := aLink nextLink]'.
		});
		new.
]

{ #category : #resources }
FiFragileBaseProblemResources >> classLog [

	^ FiClass builder 
		theName: #Log;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(collection));
		methods: {
			FiMethod sourceCode: 'log: aMessage  
	collection add: aMessage'. 
			FiMethod sourceCode: 'logAll: messages  
	messages do: [:each | self log: each ]'. 
			FiMethod sourceCode: 'initialize  
	super initialize.
	collection := LinkedList new.'.
			} asFiSet;
		new
]

{ #category : #resources }
FiFragileBaseProblemResources >> classObject [ 

	^ FiClass builder 
		theName: #Object;
		superclassName: FiClass nullSuperclassName;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'initialize '. 
			FiMethod sourceCode: 'yourself  ^ self'. 
			FiMethod sourceCode: 'subclassResponsibility  self error'. 
			FiMethod sourceCode: 'notYetImplemented  self error'. 
			FiMethod sourceCode: 'error  0/0'. 
			} asFiSet;
		metaclass: 
			(FiMetaclass builder
				methods: {
					FiMethod sourceCode: 'new  ^ self basicNew initialize; yourself'. 
					FiMethod sourceCode: 'basicNew  <primitive: 70>'. 
				} asFiSet;
				new);
		new
]

{ #category : #resources }
FiFragileBaseProblemResources >> classValueLink [

	^ FiClass builder 
		theName: #ValueLink;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(value nextLink));
		methods: (self methodsFor: { 
'value: anObject
	value := anObject'.
'value
	^ value'.
'nextLink: aLink
	nextLink := aLink'.
'nextLink
	^ nextLink'.
		});
		new.
]

{ #category : #resources }
FiFragileBaseProblemResources >> environmentWithAll [

	^ { self packageKernel. self packageCollections. self packageLog. } asFiSet
]

{ #category : #private }
FiFragileBaseProblemResources >> methodsFor: sourceCodes [ 
			
	^ (sourceCodes collect: [ :each | FiMethod sourceCode: each ]) asFiSet
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageCollections [

	^ FiPackage builder
		theName: #Collections;
		contents: { self classCollection. self classLinkedList. self classValueLink } asFiSet;
		new	
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageKernel [

	^ FiPackage builder
		theName: #Kernel;
		contents: { self classObject. self classClass } asFiSet;
		new	
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageLog [

	^ FiPackage builder
		theName: #Log;
		contents: { self classLog } asFiSet;
		new
]
