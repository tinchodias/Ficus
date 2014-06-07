Class {
	#name : #FiPrunedTest,
	#superclass : #TestCase,
	#instVars : [
		'shot'
	],
	#category : #'Ficus-Tests'
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

	shot := FiSet withValues: { FiSet new tag: 42; yourself }.
	
"	self deny: shot pruned = shot.  ?? "

	self deny: shot pruned isProxy.
	self assert: shot pruned values anyOne isProxy.
]

{ #category : #tests }
FiPrunedTest >> testNotTagged [

	shot := FiSet withValues: #(1 2 3 5) asSet.
	
"	self assert: shot pruned = shot.  ?? "
	
	self deny: shot pruned isProxy.
	self assert: shot pruned values equals: #(1 2 3 5) asSet.
]
