Class {
	#name : #FiDependenciesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'FicusRing-UI'
}

{ #category : #examples }
FiDependenciesBrowser class >> example1 [
	"
	self example1
	"
	
	^ self openOn: FiFragileBaseProblemResources new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiDependenciesBrowser class >> example2 [
	"
	self example2
	"
	
	^ self openOn: FiFragileBaseProblemResourcesA new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiDependenciesBrowser class >> example3 [
	"
	self example3
	"
	
	^ self openOn: FiRingTestWithExtensionsResources new environmentWithAll asFiRGEnvironment
]

{ #category : #examples }
FiDependenciesBrowser class >> example4yrupe [
	"
	self example4yrupe
	"
	
	^ self openOn: YrPharoMigrator example1readHead asFiRGEnvironment
]

{ #category : #building }
FiDependenciesBrowser >> compose [

	self list 
		display: [ :e | e ficusDependencyInterpretations ];
		sorted: [ :x :y | x asString < y asString ];
		format: [ :e | e asString ].
]
