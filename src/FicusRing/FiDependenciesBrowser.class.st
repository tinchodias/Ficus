Class {
	#name : #FiDependenciesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #building }
FiDependenciesBrowser >> compose [

	self flag: #todo. "This class should be in FicusImpact"

	self title: [ 'Ficus Dependencies Browser - ', self entity shortPrintString ].
	
	self table
		display: [ :e | e ficusRequisites asSet ];
		sorted: [ :x :y | x asString < y asString ];
		column: 'Requisite' evaluated: [ :requisite | requisite ];
		column: 'Dependency' evaluated: [ :requisite |
			FiRequisiteInterpreter new 
				dependencyOf: requisite 
				in: self entity ].

]
