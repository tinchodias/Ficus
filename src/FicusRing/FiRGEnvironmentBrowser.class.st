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
	
	^ self openOn: (FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment)
]

{ #category : #'instance creation' }
FiRGEnvironmentBrowser class >> newBrowser [ 

	| browser |
	browser := GLMTabulator new
		row: [ :row |
			row 
			 	column: #classes;
				column: #methods ];
		row: #sourceCode;
		yourself.
		
	browser transmit 
		to: #classes;
		andShow: [ :a | 
			a list
				display: [ :classes | classes sorted: [ :x :y | x name < y name ]];
				format: [ :class | class name ];
				filterOn: [ :text :each | each name beginsWith: text ];
				tags: [ :each | { each package name. each category } ] ].

	browser transmit 
		from: #classes;
		to: #methods;
		andShow: [ :a | 
			a list
				title: [ :class  | 'Instance (', class methods size asString, ')' ];
				display: [ :class  | class methods sorted: [ :x :y | x selector < y selector ] ];
				format: [ :method | method selector ].
			a list 
				title: [ :class  | 'Meta (', class classSide methods size asString, ')' ];
				display: [ :class  | class classSide methods sorted: [ :x :y | x selector < y selector ] ];
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

	^ self newBrowser openOn: aFiRGEnvironment allClassesAndTraits
]
