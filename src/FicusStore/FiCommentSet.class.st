Class {
	#name : #FiCommentSet,
	#superclass : #FiFixedObject,
	#instVars : [
		'comments',
		'targetStoreName'
	],
	#category : #'FicusStore-Comments-Model'
}

{ #category : #examples }
FiCommentSet class >> exampleFlatStoreFor: store [

	| comments |
	comments := { 
		FiComment builder 
			target: store historyNodes first origin;
			score: FiCommentAgree new;
			message: 'Good start!';
			new.
		FiComment builder 
			target: store historyNodes first origin;
			score: FiCommentDisagree new;
			message: 'Should be splitted';
			new.
		FiComment builder 
			target: store historyNodes third origin;
			score: FiCommentAgree new;
			message: 'Rock&roll :)';
			new.
	 }.

	^ FiFlatStore new
		fileReference: 'comments_example.txt' asFileReference;
		commitSnapshot: 
			(FiCommentSet 
				targetStoreName: store name 
				comments: comments asFiSet)
		priors: FiSet new;
		yourself.

]

{ #category : #examples }
FiCommentSet class >> exampleStoreFor: store [

	| comments commentsStore |
	comments := { 
		FiComment builder 
			target: store historyNodes first origin;
			score: FiCommentAgree new;
			message: 'Good start!';
			new.
		FiComment builder 
			target: store historyNodes first origin;
			score: FiCommentDisagree new;
			message: 'Should be splitted';
			new.
		FiComment builder 
			target: store historyNodes third origin;
			score: FiCommentAgree new;
			message: 'Rock&roll :)';
			new.
	 }.

	commentsStore := FiMemoryStore new.
	commentsStore 
		commitSnapshot: 
			(FiCommentSet 
				targetStoreName: store name 
				comments: FiSet new)
		priors: FiSet new.

	1 to: comments size do: [ :index |
		commentsStore 
			commitSnapshot: 
				(FiCommentSet 
					targetStoreName: store name
					comments: (comments first: index) asFiSet)
			priors: {commentsStore headHistoryNode} asFiSet ].

	^ commentsStore
]

{ #category : #'instance creation' }
FiCommentSet class >> targetStoreName: aName comments: aFiSet [
	
	^ self builder
		targetStoreName: aName;
		comments: aFiSet;
		new
]

{ #category : #accessing }
FiCommentSet >> comments [

	^ comments
]

{ #category : #accessing }
FiCommentSet >> targetStoreName [
	
	^ targetStoreName
]
