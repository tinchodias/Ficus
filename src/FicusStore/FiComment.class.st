Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'contents',
		'path'
	],
	#category : #'FicusStore-Models'
}

{ #category : #examples }
FiComment class >> exampleStoreFor: store [

	| comments commentsStore |
	comments := { 
		FiComment builder 
			target: store historyNodes first origin;
			path: #contents asFicusPath; 
			contents: 'Good start!';
			new.
		FiComment builder 
			target: store historyNodes first origin;
			path: #contents asFicusPath; 
			contents: 'Rock&roll man!';
			new.
		FiComment builder 
			target: 
				(FiCompositeOrigin withOrigins: {
					store historyNodes third origin.
					store historyNodes fourth origin.
					 });
			path: #contents asFicusPath; 
			contents: 'I like it';
			new.
	 }.

	commentsStore := FiMemoryStore new.
	commentsStore commitSnapshot: FiSet new priors: FiSet new.

	1 to: comments size do: [ :index |
		commentsStore 
			commitSnapshot: (FiSet withValues: (comments first: index)) 
			priors: (FiSet withValues: {commentsStore headHistoryNode}) ].

	^ commentsStore
]

{ #category : #testing }
FiComment >> appliesTo: anOrigin [
	
	^ target contains: anOrigin
]

{ #category : #accessing }
FiComment >> contents [
	
	^ contents
]

{ #category : #accessing }
FiComment >> defaultStep [

	^ ('comment:', target shortDescription, ':', self hash asString) asSymbol
]

{ #category : #accessing }
FiComment >> path [
	
	^ path
]

{ #category : #printing }
FiComment >> printOn: aStream [

	super printOn: aStream. 
	
	aStream 
		nextPut: $(;
	 	print: self hash;
		nextPut:$).
]

{ #category : #accessing }
FiComment >> target [
	
	^ target
]
