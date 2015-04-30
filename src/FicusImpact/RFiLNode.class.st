Class {
	#name : #RFiLNode,
	#superclass : #Object,
	#instVars : [
		'contents',
		'outgoingNodes',
		'incomingNodes'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #'instance creation' }
RFiLNode class >> with: anObject [

	^ self basicNew
		initializeWith: anObject;
		yourself
]

{ #category : #comparing }
RFiLNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #'optimizing space' }
RFiLNode >> compact [
	
	outgoingNodes := outgoingNodes asArray.
	incomingNodes := incomingNodes asArray.
]

{ #category : #accessing }
RFiLNode >> contents [

	^ contents
]

{ #category : #accessing }
RFiLNode >> ensurePointTo: targetNode [
	"Outer edges are owned by self, unlike inner edges."
	
	outgoingNodes add: targetNode.	
	targetNode ensurePointedFrom: self.
]

{ #category : #accessing }
RFiLNode >> ensurePointedFrom: aNode [
	"Inner edges are owned by the source node, unlike outer edges."

	incomingNodes add: aNode
]

{ #category : #comparing }
RFiLNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #accessing }
RFiLNode >> incomingNodes [
	
	^ incomingNodes asArray
]

{ #category : #initialization }
RFiLNode >> initializeWith: anObject [
	
	self initialize.
	
	contents := anObject.
	outgoingNodes := IdentitySet new: 1.
	incomingNodes := IdentitySet new: 1.
]

{ #category : #accessing }
RFiLNode >> outgoingNodes [
	
	^ outgoingNodes asArray
]

{ #category : #printing }
RFiLNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
