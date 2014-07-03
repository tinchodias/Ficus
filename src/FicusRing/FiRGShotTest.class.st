Class {
	#name : #FiRGShotTest,
	#superclass : #TestCase,
	#instVars : [
		'ringShotResource'
	],
	#category : #'FicusRing-Tests'
}

{ #category : #running }
FiRGShotTest >> setUp [

	super setUp.
	
	ringShotResource := FiRGShotResource new
]
