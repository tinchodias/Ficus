Class {
	#name : #FiCommit,
	#superclass : #FiShot,
	#instVars : [
		'priors',
		'timestamp',
		'root',
		'editEffect'
	],
	#category : #'Ficus-Model-Store'
}

{ #category : #accessing }
FiCommit >> editEffect [
	
	^ editEffect
]

{ #category : #accessing }
FiCommit >> editEffect: anObject [
	
	editEffect := anObject
]

{ #category : #accessing }
FiCommit >> priors [
	
	^ priors
]

{ #category : #accessing }
FiCommit >> priors: anObject [
	
	priors := anObject
]

{ #category : #accessing }
FiCommit >> root [
	
	^ root
]

{ #category : #accessing }
FiCommit >> root: anObject [
	
	root := anObject
]

{ #category : #accessing }
FiCommit >> timestamp [
	
	^ timestamp
]

{ #category : #accessing }
FiCommit >> timestamp: anObject [
	
	timestamp := anObject
]
