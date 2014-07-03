Class {
	#name : #FiRGShotTest,
	#superclass : #TestCase,
	#instVars : [
		'pshotResource'
	],
	#category : #FicusRing
}

{ #category : #running }
FiRGShotTest >> setUp [

	super setUp.
	
	pshotResource := FiRGShotResource new
]
