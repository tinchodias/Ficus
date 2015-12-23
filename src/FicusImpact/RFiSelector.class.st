"
Caches senders and implementors for a given selector
"
Class {
	#name : #RFiSelector,
	#superclass : #Object,
	#instVars : [
		'selector',
		'senders',
		'implementors'
	],
	#category : #'FicusImpact-Old-SendersImplementors'
}

{ #category : #accessing }
RFiSelector class >> selector: aSymbol [

	^ self new
		initializeWithSelector: aSymbol;
		yourself
]

{ #category : #comparing }
RFiSelector >> = anObject [
	^ self asSymbol = anObject asSymbol
]

{ #category : #private }
RFiSelector >> addImplementor: aMethod [
	implementors add: aMethod
]

{ #category : #private }
RFiSelector >> addSender: aMethod [
	senders add: aMethod
]

{ #category : #converting }
RFiSelector >> asSymbol [
	^ selector
]

{ #category : #comparing }
RFiSelector >> hash [
	^ selector hash
]

{ #category : #accessing }
RFiSelector >> implementors [
	^ implementors
]

{ #category : #initialization }
RFiSelector >> initializeWithSelector: aSymbol [
	selector := aSymbol.
	senders := IdentitySet new.
	implementors := IdentitySet new
]

{ #category : #printing }
RFiSelector >> printOn: aStream [
	aStream
		print: selector;
		<< '(imp: ';
		print: implementors size;
		<< ' / snd: ';
		print: senders size;
		<< ')'
]

{ #category : #private }
RFiSelector >> removeImplementor: aMethod [
	implementors remove: aMethod
]

{ #category : #private }
RFiSelector >> removeSender: aMethod [
	senders remove: aMethod
]

{ #category : #accessing }
RFiSelector >> selector [ 
	^ selector
]

{ #category : #accessing }
RFiSelector >> senders [
	^ senders
]
