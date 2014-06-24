Class {
	#name : #FiCommit,
	#superclass : #FiFixedObject,
	#instVars : [
		'priors',
		'timestamp',
		'root',
		'editEffect'
	],
	#category : #'FicusStore-Model'
}

{ #category : #accessing }
FiCommit >> editEffect [
	
	^ editEffect
]

{ #category : #accessing }
FiCommit >> priors [
	
	^ priors
]

{ #category : #accessing }
FiCommit >> root [
	
	^ root
]

{ #category : #accessing }
FiCommit >> timestamp [
	
	^ timestamp
]
