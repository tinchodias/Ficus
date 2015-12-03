"
Resource with diverse Ficus metalevel objects. I answer basic elements like Object, Class and Collection.
"
Class {
	#name : #RFiBaseResources,
	#superclass : #Object,
	#instVars : [
		'cachedFicusEnvironment',
		'cachedRFiEnvironment'
	],
	#category : #'FicusMetamodel-Examples'
}

{ #category : #resources }
RFiBaseResources >> categoryNameCollection [

	^ 'Collection'
]

{ #category : #resources }
RFiBaseResources >> categoryNameKernel [

	^ 'Kernel'
]

{ #category : #resources }
RFiBaseResources >> classBlockClosure [

	^ FiClass builder 
		name: #BlockClosure;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
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
RFiBaseResources >> classBoolean [

	^ FiClass builder 
		name: #Boolean;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  self subclassResponsibility'. 
			FiMethod sourceCode: 'ifFalse: aBlock  self subclassResponsibility'.
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	self subclassResponsibility'. 
			} asFiSet;
		new
]

{ #category : #resources }
RFiBaseResources >> classClass [

	^ FiClass builder 
		name: #Class;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {} asFiSet;
		new
]

{ #category : #resources }
RFiBaseResources >> classCollection [

	^ FiClass builder 
		name: #Collection;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameCollection;
		methods: { 
			FiMethod sourceCode: 'add: anObject  self subclassResponsibility'.
			FiMethod sourceCode: 'addAll: aCollection 
	aCollection do: [:each | self add: each].
	^ aCollection'.
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
RFiBaseResources >> classFalse [

	^ FiClass builder 
		name: #False;
		superclassName: #Boolean;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  ^ nil'. 
			FiMethod sourceCode: 'ifFalse: aBlock  ^ aBlock value'. 
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	^ falseAlternativeBlock value'. 
			} asFiSet;
		new
]

{ #category : #resources }
RFiBaseResources >> classLinkedList [

	^ FiClass builder 
		name: #LinkedList;
		superclassName: #Collection;
		layout: (FiFixedLayout withInstanceVariableNames: #(firstLink lastLink));
		category: self categoryNameCollection;
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
RFiBaseResources >> classObject [ 

	^ FiClass builder 
		name: #Object;
		superclassName: FiClass nullSuperclassName;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {
			FiMethod sourceCode: 'initialize '. 
			FiMethod sourceCode: '= other  ^ self = other'. 
			FiMethod sourceCode: '== other  <primitive>'. 
			FiMethod sourceCode: 'hash   <primitive>'. 
			FiMethod sourceCode: 'yourself  ^ self'. 
			FiMethod sourceCode: 'subclassResponsibility  self error'. 
			FiMethod sourceCode: 'notYetImplemented  self error'. 
			FiMethod sourceCode: 'assert: aBoolean  aBoolean ifFalse: [self error]'. 
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
RFiBaseResources >> classSmallInteger [

	^ FiClass builder 
		name: #SmallInteger;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {
			FiMethod sourceCode: '+ other  <primitive>'. 
			FiMethod sourceCode: '/ other  <primitive>'. 
			FiMethod sourceCode: '> other  <primitive>'. 
			FiMethod sourceCode: '= other  <primitive>'. 
			} asFiSet;
		new
]

{ #category : #resources }
RFiBaseResources >> classTrue [

	^ FiClass builder 
		name: #True;
		superclassName: #Boolean;
		layout: (FiFixedLayout withInstanceVariables: #());
		category: self categoryNameKernel;
		methods: {
			FiMethod sourceCode: 'ifTrue: aBlock  ^ aBlock value'. 
			FiMethod sourceCode: 'ifFalse: aBlock  ^ nil'. 
			FiMethod sourceCode: 'ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock 
	^ trueAlternativeBlock value'. 
			} asFiSet;
		new
]

{ #category : #resources }
RFiBaseResources >> classValueLink [

	^ FiClass builder 
		name: #ValueLink;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariableNames: #(value nextLink));
		category: self categoryNameCollection;
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
RFiBaseResources >> ficusEnvironment [

	^ cachedFicusEnvironment ifNil: [
		cachedFicusEnvironment := self newFicusEnvironment ]
]

{ #category : #private }
RFiBaseResources >> methodsFor: sourceCodes [ 
			
	^ (sourceCodes collect: [ :each | FiMethod sourceCode: each ]) asFiSet
]

{ #category : #private }
RFiBaseResources >> newFicusEnvironment [

	^ FiEnvironment withAll: { self packageKernel. self packageCollections. }
]

{ #category : #resources }
RFiBaseResources >> packageCollections [

	^ FiPackage builder
		name: #Collections;
		contents: { self classCollection. self classLinkedList. self classValueLink } asFiSet;
		new	
]

{ #category : #resources }
RFiBaseResources >> packageKernel [

	^ FiPackage builder
		name: #Kernel;
		contents: { self classObject. self classClass. self classBoolean. self classTrue. self classFalse. self classSmallInteger. self classBlockClosure } asFiSet;
		new	
]
