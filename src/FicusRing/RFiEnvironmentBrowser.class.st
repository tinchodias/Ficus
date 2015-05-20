Class {
	#name : #RFiEnvironmentBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
RFiEnvironmentBrowser class >> example1 [
	"
	self example1
	"
	
	^ self openOn: RFiFragileBaseClassProblemResources3 new ringEnvironment
]

{ #category : #examples }
RFiEnvironmentBrowser class >> example2 [
	"
	self example2
	"
	
	^ self openOn: RFiFragileBaseClassProblemResources5A new ringEnvironment
]

{ #category : #examples }
RFiEnvironmentBrowser class >> example3 [
	"
	self example3
	"
	
	^ self openOn: RFiRingTestResources new ringEnvironment
]

{ #category : #actions }
RFiEnvironmentBrowser >> browseImplementorsInHierarchyOf: aRFiMethod [

	| methods |
	methods := aRFiMethod environment 
		implementorsOf: aRFiMethod selector 
		inHierarchyOf: aRFiMethod methodClass.

	RFiMethodsBrowser openOn: methods.
]

{ #category : #actions }
RFiEnvironmentBrowser >> browseImplementorsOf: aRFiMethod [

	| methods |
	methods := aRFiMethod environment implementorsOf: aRFiMethod selector.

	RFiMethodsBrowser openOn: methods.
]

{ #category : #private }
RFiEnvironmentBrowser >> classDefinitionIn: a [ 

	a smalltalkCode
		variableBindings: [ :class | 
			{ class name -> class. class superclass name -> class superclass } 
			"For syntax highlighting" ];
		display: [ :class  | 
			String streamContents: [ :stream |
				stream 
					nextPutAll: class definition;
					nextPut: $.;
					cr; cr;
					nextPutAll: class classSide definition;
					nextPut: $. ] ]
]

{ #category : #private }
RFiEnvironmentBrowser >> classSideMethodsIn: a [

	a list 
		title: [ :class  | 'Meta (', class classSide methods size asString, ')' ];
		display: [ :class  | class classSide methods ];
		in: [ :aList | self sharedSetupForMethodsIn: aList ].
]

{ #category : #private }
RFiEnvironmentBrowser >> classesIn: aList [

	aList
		display: [ :package | package definedClasses ];
		sorted: [:x :y | x name < y name ];
		format: [ :class | class name ];
		filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each category} ]
]

{ #category : #building }
RFiEnvironmentBrowser >> compose [

	self title: 'Ficus Environment Browser'.

	self 
		act: [ :browser | browser entity inspect ] 
		icon: Smalltalk ui icons openIcon
		entitled: 'Inspect'.

	self tabulator with: [ :browser | 
		browser
			row: [ :row |
				row 
				 	column: #packages;
				 	column: #classes;
					column: #methods ];
			row: #sourceCode;
			yourself.

		browser transmit 
			to: #packages; 
			andShow: [ :a | self packagesIn: a ].
			
		browser transmit 
			from: #packages;
			to: #classes;
			andShow: [ :a | self classesIn: a list ].

		browser transmit 
			from: #classes;
			to: #methods;
			andShow: [ :a | 
				self instanceSideMethodsIn: a.
				self classSideMethodsIn: a.
			 ].

		browser transmit 
			from: #classes;
			to: #sourceCode;
			andShow: [ :a | self classDefinitionIn: a ].
				
		browser transmit 
			from: #methods;
			to: #sourceCode;
			andShow: [ :a | self methodDefinitionIn: a ].
				
	]
]

{ #category : #private }
RFiEnvironmentBrowser >> instanceSideMethodsIn: a [

	a list
		title: [ :class  | 'Instance (', class methods size asString, ')' ];
		display: [ :class  | class methods ];
		in: [ :aList | self sharedSetupForMethodsIn: aList ].
]

{ #category : #private }
RFiEnvironmentBrowser >> methodDefinitionIn: a [ 

	a smalltalkCode
		smalltalkClass: [ :method | method methodClass ];
		display: [ :method  | method sourceCode ].
]

{ #category : #private }
RFiEnvironmentBrowser >> packagesIn: a [ 

	a list 
		display: [ :e | e packages ];
		sorted: [ :x :y | x name < y name ];
		filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
		format: [ :package | package name ]
]

{ #category : #private }
RFiEnvironmentBrowser >> sharedSetupForMethodsIn: aList [

	aList
		sorted: [ :x :y | x selector < y selector ];
		filterOn: [ :text :each | each selector includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each protocol} ];
		format: [ :method | method selector ];
		selectionAct: [:each :e | 
			self browseImplementorsOf: each selection ]
			on: $m
			entitled: 'Implementors';
		selectionAct: [:each :e | 
			self browseImplementorsInHierarchyOf: each selection ]
			on: $M
			entitled: 'Implementors in hierarchy'.
]
