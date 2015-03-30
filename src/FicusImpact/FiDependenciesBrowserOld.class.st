Class {
	#name : #FiDependenciesBrowserOld,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusImpact-UI'
}

{ #category : #building }
FiDependenciesBrowserOld >> compose [

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
