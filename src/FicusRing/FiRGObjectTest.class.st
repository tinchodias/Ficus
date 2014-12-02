Class {
	#name : #FiRGObjectTest,
	#superclass : #TestCase,
	#instVars : [
		'ringObjectResource'
	],
	#category : #'FicusRing-Tests'
}

{ #category : #running }
FiRGObjectTest >> setUp [

	super setUp.
	
	ringObjectResource := FiRGObjectResource new
]
