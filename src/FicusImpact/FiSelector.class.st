"
Caches senders and implementors for a given selector
"
Class {
	#name : #FiSelector,
	#superclass : #Object,
	#instVars : [
		'selector',
		'senders',
		'implementors'
	],
	#category : #'FicusImpact-SendersImplementors'
}

{ #category : #accessing }
FiSelector class >> selector: aSymbol [
	^ self new
		initializeWithSelector: aSymbol;
		yourself
]

{ #category : #comparing }
FiSelector >> = anObject [
	^ self asSymbol = anObject asSymbol
]

{ #category : #private }
FiSelector >> addImplementor: aMethod [
	implementors add: aMethod
]

{ #category : #private }
FiSelector >> addSender: aMethod [
	senders add: aMethod
]

{ #category : #converting }
FiSelector >> asSymbol [
	^ selector
]

{ #category : #comparing }
FiSelector >> hash [
	^ selector hash
]

{ #category : #accessing }
FiSelector >> implementors [
	^ implementors
]

{ #category : #initialization }
FiSelector >> initializeWithSelector: aSymbol [
	selector := aSymbol.
	senders := IdentitySet new.
	implementors := IdentitySet new
]

{ #category : #printing }
FiSelector >> printOn: aStream [
	aStream
		print: selector;
		<< '(imp: ';
		print: implementors size;
		<< ' / snd: ';
		print: senders size;
		<< ')'
]

{ #category : #private }
FiSelector >> removeImplementor: aMethod [
	implementors remove: aMethod
]

{ #category : #private }
FiSelector >> removeSender: aMethod [
	senders remove: aMethod
]

{ #category : #accessing }
FiSelector >> selector [ 
	^ selector
]

{ #category : #accessing }
FiSelector >> senders [
	^ senders
]
