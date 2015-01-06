Class {
	#name : #FiRGEnvironmentBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
FiRGEnvironmentBrowser class >> example1 [
	"
	self example1
	"
	
	^ self openOn: FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiRGEnvironmentBrowser class >> example2 [
	"
	self example2
	"
	
	^ self openOn: FiFragileBaseProblemResourcesA new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiRGEnvironmentBrowser class >> example3 [
	"
	self example3
	"
	
	^ self openOn: FiRingTestWithExtensionsResources new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiRGEnvironmentBrowser class >> example4yrupe [
	"
	self example4yrupe
	"
	
	^ self openOn: YrPharoMigrator example1readHead asFiRGEnvironment
]

{ #category : #private }
FiRGEnvironmentBrowser >> classDefinitionIn: a [ 

	a smalltalkCode
		variableBindings: [ :class | 
			{ class name -> class. class superclass name -> class superclass } 
			"Just for highlighting" ];
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
FiRGEnvironmentBrowser >> classSideMethodsIn: a [

	a list 
		title: [ :class  | 'Meta (', class classSide methods size asString, ')' ];
		display: [ :class  | class classSide methods ];
		sorted: [ :x :y | x selector < y selector ];
		filterOn: [ :text :each | each selector includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each protocol} ];
		format: [ :method | method selector ];
		selectionAct: [:each :e | 
			(FiDependenciesBrowser openOn: each selection) extent: 700@600 ] 
			on: $d 
			entitled: 'Dependencies'.
]

{ #category : #private }
FiRGEnvironmentBrowser >> classesIn: a [ 

	a list
		display: [ :package | package definedClasses ];
		sorted: [:x :y | x name < y name ];
		format: [ :class | class name ];
		filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each category} ];
		selectionAct: [:each :e | 
			(FiDependenciesBrowser openOn: each selection) extent: 700@600 ] 
			on: $d 
			entitled: 'Dependencies'.
]

{ #category : #building }
FiRGEnvironmentBrowser >> compose [

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
			andShow: [ :a | self classesIn: a ].

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
FiRGEnvironmentBrowser >> instanceSideMethodsIn: a [

	a list
		title: [ :class  | 'Instance (', class methods size asString, ')' ];
		display: [ :class  | class methods ];
		sorted: [ :x :y | x selector < y selector ];
		filterOn: [ :text :each | each selector includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each protocol} ];
		format: [ :method | method selector ];
		selectionAct: [:each :e | 
			(FiDependenciesBrowser openOn: each selection) extent: 700@600 ] 
			on: $d 
			entitled: 'Dependencies'.
]

{ #category : #private }
FiRGEnvironmentBrowser >> methodDefinitionIn: a [ 

	a smalltalkCode
		smalltalkClass: [ :method | method methodClass ];
		display: [ :method  | method sourceCode ].
]

{ #category : #private }
FiRGEnvironmentBrowser >> packagesIn: a [ 

	a list 
		display: [ :e | e packages ];
		sorted: [ :x :y | x name < y name ];
		filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
		format: [ :package | package name ]
]
