Class {
	#name : #RFiLNode,
	#superclass : #Object,
	#instVars : [
		'contents',
		'nodesPointingToMe',
		'nodesPointedByMe'
	],
	#category : #'FicusImpact-LGraph'
}

{ #category : #comparing }
RFiLNode >> = other [

	^ self class = other class and: [ 
		self contents = other contents ]
]

{ #category : #'optimizing space' }
RFiLNode >> compact [
	
	nodesPointedByMe := nodesPointedByMe asArray.
	nodesPointingToMe := nodesPointingToMe asArray.
]

{ #category : #accessing }
RFiLNode >> contents [

	^ contents
]

{ #category : #accessing }
RFiLNode >> contents: anObject [
	
	contents := anObject
]

{ #category : #accessing }
RFiLNode >> ensurePointTo: targetNode [
	"Outer edges are owned by self, unlike inner edges."
	
	nodesPointedByMe add: targetNode.	
	targetNode ensurePointedFrom: self.
]

{ #category : #accessing }
RFiLNode >> ensurePointedFrom: aNode [
	"Inner edges are owned by the source node, unlike outer edges."

	nodesPointingToMe add: aNode
]

{ #category : #comparing }
RFiLNode >> hash [

	^ self class hash bitXor: self contents hash
]

{ #category : #initialization }
RFiLNode >> initialize [

	super initialize.
	
	nodesPointedByMe := IdentitySet new: 1.
	nodesPointingToMe := IdentitySet new: 1.
]

{ #category : #accessing }
RFiLNode >> nodesPointedByMe [
	
	^ nodesPointedByMe asArray
]

{ #category : #accessing }
RFiLNode >> nodesPointingToMe [
	
	^ nodesPointingToMe asArray
]

{ #category : #printing }
RFiLNode >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		print: contents;
		nextPut: $).
]
