Class {
	#name : #FiPrunedTest,
	#superclass : #TestCase,
	#instVars : [
		'shot'
	],
	#category : #FicusProxy
}

{ #category : #tests }
FiPrunedTest >> testAlreadyTagged [

	shot := FiSet new tag: 42; yourself.
	
	self deny: shot isProxy.
	self assert: shot pruned isProxy.
	self assert: shot pruned tag equals: 42.

]

{ #category : #tests }
FiPrunedTest >> testAlreadyTaggedCollaborator [

	shot := { (FiClass named: #A) tag: 42; yourself } asFiSet.
	
"	self deny: shot pruned = shot.  ?? "

	self deny: shot pruned isProxy.
	self assert: shot pruned values anyOne isProxy.
]

{ #category : #tests }
FiPrunedTest >> testNotTagged [

	shot := #(1 2 3 5) asFiSet.
	
"	self assert: shot pruned = shot.  ?? "
	
	self deny: shot pruned isProxy.
	self assert: shot pruned values asSet equals: #(1 2 3 5) asSet.
]
