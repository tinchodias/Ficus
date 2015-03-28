Class {
	#name : #FiMethodsBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #actions }
FiMethodsBrowser >> browseDependenciesOf: aFiRGObject [

	(FiDependenciesBrowser openOn: aFiRGObject) extent: 700@600
]

{ #category : #building }
FiMethodsBrowser >> compose [

	self title: 'Ficus Methods Browser'.

	self 
		act: [ :browser | browser entity inspect ] 
		icon: Smalltalk ui icons openIcon
		entitled: 'Inspect Environment'.

	self tabulator with: [ :browser | 
		browser
			row: #methods;
			row: #sourceCode;
			yourself.

		browser transmit 
			to: #methods;
			andShow: [ :a | self methodsIn: a ].

		browser transmit 
			from: #methods;
			to: #sourceCode;
			andShow: [ :a | self methodDefinitionIn: a ].
	]
]

{ #category : #private }
FiMethodsBrowser >> methodDefinitionIn: a [ 

	a smalltalkCode
		smalltalkClass: [ :method | method methodClass ];
		display: [ :method | method sourceCode ].
]

{ #category : #private }
FiMethodsBrowser >> methodsIn: a [

	a list
		sorted: [ :x :y | x selector < y selector ];
		filterOn: [ :text :each | each shortPrintString includesSubstring: text caseSensitive: false ];
		tags: [ :each | {each protocol} ];
		format: [ :method | method shortPrintString ];
		selectionAct: [:each :e | 
			self browseDependenciesOf: each selection ] 
			on: $d 
			entitled: 'Dependencies'.
]
