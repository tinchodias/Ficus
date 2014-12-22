Class {
	#name : #FiRGEnvironmentBrowser,
	#superclass : #Object,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
FiRGEnvironmentBrowser class >> example1 [
	"
	self example1
	"
	
	^ self openOn: FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment
]

{ #category : #'instance creation' }
FiRGEnvironmentBrowser class >> newBrowser [ 

	| browser |
	browser := GLMTabulator new
		row: [ :row |
			row 
			 	column: #packages;
			 	column: #classes;
				column: #methods ];
		row: #sourceCode;
		yourself.

	browser transmit 
		to: #packages; 
		andShow: [ :a | 
			a list 
				display: [ :list | list sorted: [ :x :y | x name < y name ] ];
				filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
				format: [ :package | package name ] ].
		
	browser transmit 
		from: #packages;
		to: #classes;
		andShow: [ :a | 
			a list
				display: [ :package | package definedClasses sorted: [:x :y | x name < y name ]];
				format: [ :class | class name ];
				filterOn: [ :text :each | each name includesSubstring: text caseSensitive: false ];
				tags: [ :each | {each category} ] ].

	browser transmit 
		from: #classes;
		to: #methods;
		andShow: [ :a | 
			a list
				title: [ :class  | 'Instance (', class methods size asString, ')' ];
				display: [ :class  | class methods sorted: [ :x :y | x selector < y selector ] ];
				filterOn: [ :text :each | each selector includesSubstring: text caseSensitive: false ];
				tags: [ :each | {each protocol} ];
				format: [ :method | method selector ].
			a list 
				title: [ :class  | 'Meta (', class classSide methods size asString, ')' ];
				display: [ :class  | class classSide methods sorted: [ :x :y | x selector < y selector ] ];
				filterOn: [ :text :each | each selector includesSubstring: text caseSensitive: false ];
				tags: [ :each | {each protocol} ];
				format: [ :method | method selector ].
		 ].

	browser transmit 
		from: #classes;
		to: #sourceCode;
		andShow: [ :a | 
			a smalltalkCode
				display: [ :class  | class definition ] ].
			
	browser transmit 
		from: #methods;
		to: #sourceCode;
		andShow: [ :a | 
			a smalltalkCode
				smalltalkClass: [ :method | method methodClass ];
				display: [ :method  | method sourceCode ] ].
			
	^ browser
]

{ #category : #convenience }
FiRGEnvironmentBrowser class >> openOn: aFiRGEnvironment [

	^ self newBrowser openOn: aFiRGEnvironment packages
]
