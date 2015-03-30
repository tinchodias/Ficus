Class {
	#name : #FiDependenciesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusImpact-UI'
}

{ #category : #building }
FiDependenciesBrowser >> compose [

	self title: 'Ficus Dependencies Browser'.
	
	self tabulator with: [ :browser | 
		browser
			row: #dependencies;
			row: #definition;
			yourself.

		browser transmit 
			to: #dependencies;
			andShow: [ :a | self dependenciesIn: a ].

		browser transmit 
			from: #dependencies;
			to: #definition;
			andShow: [ :a | self definitionIn: a ].
	]
]

{ #category : #building }
FiDependenciesBrowser >> definitionIn: a [ 

	a text
"		smalltalkClass: [ :method | method methodClass ];"
		display: [ :dependency | dependency asString ].
]

{ #category : #building }
FiDependenciesBrowser >> dependenciesIn: a [

	a list
		format: [ :dependency | dependency shortPrintString ];
		sorted: [ :x :y | x shortPrintString < y shortPrintString ];
		filterOn: [ :text :each | each shortPrintString includesSubstring: text caseSensitive: false ].

]
