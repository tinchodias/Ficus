Class {
	#name : #FiFragileBaseProblemResources,
	#superclass : #Object,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiFragileBaseProblemResources >> classCollection [

	^ FiClass builder 
		theName: #Collection;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: { 
			FiMethod sourceCode: 'add: anObject  self subclassResponsibility'.
			FiMethod sourceCode: 'do: aBlock  self subclassResponsibility'. 
			FiMethod sourceCode: 'size
	| tally |
	tally := 0.
	self do: [:each | tally := tally + 1].
	^ tally'
			} asFiSet;
		new.
]

{ #category : #resources }
FiFragileBaseProblemResources >> classObject [ 

	^ FiClass builder 
		theName: #Object;
		superclassName: FiClass nullSuperclassName;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: {
			FiMethod sourceCode: 'subclassResponsibility  "empty"'. 
			FiMethod sourceCode: 'notYetImplemented  "empty"'. 
			} asFiSet;
		new
]

{ #category : #resources }
FiFragileBaseProblemResources >> classOrderedCollection [

	^ FiClass builder 
		theName: #OrderedCollection;
		superclassName: #Collection;
		layout: (FiFixedLayout withInstanceVariables: #(array firstIndex lastIndex));
		methods: { 
			FiMethod sourceCode: 'add: newObject  
	lastIndex = array size ifTrue: [self notYetImplemented].
	lastIndex := lastIndex + 1.
	array at: lastIndex put: newObject.
	^ newObject'.

			FiMethod sourceCode: 'do: aBlock  
	firstIndex to: lastIndex do: [ :index | 
		aBlock value: (array at: index) ]'. 

			FiMethod sourceCode: 'size  ^ lastIndex - firstIndex + 1'.

			} asFiSet;
		new.
]

{ #category : #resources }
FiFragileBaseProblemResources >> environmentInitial [

	^ { self packageKernel. self packageCollections. self packageLogInitial. } asFiSet
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageCollections [

	^ FiPackage builder
		theName: #Collections;
		contents: { self classCollection. self classOrderedCollection. } asFiSet;
		new	
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageKernel [

	^ FiPackage builder
		theName: #Kernel;
		contents: { self classObject } asFiSet;
		new	
]

{ #category : #resources }
FiFragileBaseProblemResources >> packageLogInitial [

	^ FiPackage builder
		theName: #Log;
		contents: { } asFiSet;
		new
]
