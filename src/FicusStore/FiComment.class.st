Class {
	#name : #FiComment,
	#superclass : #FiFixedObject,
	#instVars : [
		'target',
		'contents',
		'path',
		'score'
	],
	#category : #'FicusStore-Comments-Model'
}

{ #category : #examples }
FiComment class >> exampleStoreFor: store [

	| comments commentsStore |
	comments := { 
		FiComment builder 
			target: store historyNodes first origin;
			path: #(contents) asFiPath; 
			score: FiCommentAgree new;
			contents: 'Good start!';
			new.
		FiComment builder 
			target: store historyNodes first origin;
			path: #(contents) asFiPath; 
			score: FiCommentDisagree new;
			contents: 'Should be splitted';
			new.
		FiComment builder 
			target: store historyNodes third origin;
"				(FiCompositeOrigin withOrigins: {
					store historyNodes third origin.
					store historyNodes fourth origin.
					 });
"			path: #(contents) asFiPath; 
			score: FiCommentAgree new;
			contents: 'Rock&roll :)';
			new.
	 }.

	commentsStore := FiMemoryStore new.
	commentsStore commitSnapshot: FiSet new priors: FiSet new.

	1 to: comments size do: [ :index |
		commentsStore 
			commitSnapshot: (comments first: index) asFiSet 
			priors: {commentsStore headHistoryNode} asFiSet ].

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
FiComment >> score [
	
	^ score
]

{ #category : #accessing }
FiComment >> target [
	
	^ target
]
