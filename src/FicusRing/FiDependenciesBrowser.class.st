Class {
	#name : #FiDependenciesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #building }
FiDependenciesBrowser >> compose [

	self table
		display: [ :e | e ficusRequisites asSet ];
		column: 'Requisite' evaluated: [ :r | r ];
		column: 'Dependency' evaluated: [ :r |
			FiRequisiteInterpreter new 
				dependencyOf: r 
				in: self entity ];
		sorted: [ :x :y | x asString < y asString ]
]
