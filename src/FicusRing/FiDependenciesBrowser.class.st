Class {
	#name : #FiDependenciesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #building }
FiDependenciesBrowser >> compose [

	self list 
		display: [ :e | e ficusDependencyInterpretations ];
		sorted: [ :x :y | x asString < y asString ];
		format: [ :e | e asString ].
]
