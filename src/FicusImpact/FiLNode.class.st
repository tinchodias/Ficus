Class {
	#name : #FiLNode,
	#superclass : #Object,
	#instVars : [
		'contents',
		'nodesPointingToMe',
		'nodesPointedByMe'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #comparing }
FiLNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #'optimizing space' }
FiLNode >> compact [
	
	nodesPointedByMe := nodesPointedByMe asArray.
	nodesPointingToMe := nodesPointingToMe asArray.
]

{ #category : #accessing }
FiLNode >> contents [

	^ contents
]

{ #category : #accessing }
FiLNode >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
FiLNode >> ensurePointTo: targetNode [
	"Outer edges are owned by self, unlike inner edges."
	
	nodesPointedByMe add: targetNode.	
	targetNode ensurePointedFrom: self.
]

{ #category : #accessing }
FiLNode >> ensurePointedFrom: aNode [
	"Inner edges are owned by the source node, unlike outer edges."

	nodesPointingToMe add: aNode
]

{ #category : #comparing }
FiLNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #initialization }
FiLNode >> initialize [

	super initialize.
	
	nodesPointedByMe := IdentitySet new: 1.
	nodesPointingToMe := IdentitySet new: 1.
]

{ #category : #accessing }
FiLNode >> nodesPointedByMe [
	
	^ nodesPointedByMe asArray
]

{ #category : #accessing }
FiLNode >> nodesPointingToMe [
	
	^ nodesPointingToMe asArray
]

{ #category : #printing }
FiLNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
