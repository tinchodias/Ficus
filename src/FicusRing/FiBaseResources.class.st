"
Resource with diverse Ficus metalevel objects. I answer basic elements like Object, Class and Collection.
"
Class {
	#name : #FiBaseResources,
	#superclass : #Object,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiBaseResources >> classBlockClosure [

	^ FiClass builder 
		theName: #BlockClosure;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'value  <primitive>'. 
			FiMethod sourceCode: 'whileFalse: aBlock  
	self value ifFalse: [ aBlock value. self whileFalse: aBlock ]'.
			FiMethod sourceCode: 'whileTrue: aBlock  
	self value ifTrue: [ aBlock value. self whileTrue: aBlock ]'.
			} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classBoolean [

	^ FiClass builder 
		theName: #Boolean;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  self subclassResponsibility'. 
			FiMethod sourceCode: 'ifFalse: aBlock  self subclassResponsibility'.
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	self subclassResponsibility'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classClass [

	^ FiClass builder 
		theName: #Class;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classCollection [

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
FiBaseResources >> classFalse [

	^ FiClass builder 
		theName: #False;
		superclassName: #Boolean;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  ^ nil'. 
			FiMethod sourceCode: 'ifFalse: aBlock  ^ aBlock value'. 
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	^ falseAlternativeBlock value'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classLinkedList [

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
FiBaseResources >> classObject [ 

	^ FiClass builder 
		theName: #Object;
		superclassName: FiClass nullSuperclassName;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'initialize '. 
			FiMethod sourceCode: '= other  ^ self = other'. 
			FiMethod sourceCode: '== other  <primitive>'. 
			FiMethod sourceCode: 'hash   <primitive>'. 
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
FiBaseResources >> classSmallInteger [

	^ FiClass builder 
		theName: #SmallInteger;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: '+ other  <primitive>'. 
			FiMethod sourceCode: '/ other  <primitive>'. 
			FiMethod sourceCode: '> other  <primitive>'. 
			FiMethod sourceCode: '= other  <primitive>'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classTrue [

	^ FiClass builder 
		theName: #True;
		superclassName: #Boolean;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  ^ aBlock value'. 
			FiMethod sourceCode: 'ifFalse: aBlock  ^ nil'. 
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	^ trueAlternativeBlock value'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiBaseResources >> classValueLink [

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
FiBaseResources >> environmentWithAll [

	^ { self packageKernel. self packageCollections. } asFiSet
]

{ #category : #private }
FiBaseResources >> methodsFor: sourceCodes [ 
			
	^ (sourceCodes collect: [ :each | FiMethod sourceCode: each ]) asFiSet
]

{ #category : #resources }
FiBaseResources >> packageCollections [

	^ FiPackage builder
		theName: #Collections;
		contents: { self classCollection. self classLinkedList. self classValueLink } asFiSet;
		new	
]

{ #category : #resources }
FiBaseResources >> packageKernel [

	^ FiPackage builder
		theName: #Kernel;
		contents: { self classObject. self classClass. self classBoolean. self classTrue. self classFalse. self classSmallInteger. self classBlockClosure } asFiSet;
		new	
]
