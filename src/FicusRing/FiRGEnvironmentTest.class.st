Class {
	#name : #FiRGEnvironmentTest,
	#superclass : #FiRGShotTest,
	#category : #FicusRing
}

{ #category : #tests }
FiRGEnvironmentTest >> testAllClasses [

	self assert: pshotResource environmentWithClassesAB allClasses size equals: 2
]

{ #category : #tests }
FiRGEnvironmentTest >> testClassNamed [

	self assert: (pshotResource environmentWithClassesAB classNamed: #A) name equals: #A 
]
