Class {
	#name : #RFiImpact,
	#superclass : #Object,
	#instVars : [
		'oldDependency',
		'newDependency'
	],
	#category : #'FicusImpact-Model'
}

{ #category : #accessing }
RFiImpact >> newDependency [

	^ newDependency
]

{ #category : #accessing }
RFiImpact >> newDependency: anObject [
	newDependency := anObject
]

{ #category : #accessing }
RFiImpact >> oldDependency [

	^ oldDependency
]

{ #category : #accessing }
RFiImpact >> oldDependency: anObject [
	oldDependency := anObject
]
