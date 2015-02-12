Extension { #name : #FiCommentSet }

{ #category : #'*FicusEpicea' }
FiCommentSet classSide >> exampleOmbuStoreFor: store forkFrom: anotherStore [

	| comments commentsStore |
	comments := 	{ 
		FiComment builder 
			target: store historyNodes atRandom origin;
			score: FiCommentAgree new;
			message: 'Superb';
			new.
		FiComment builder 
			target: store historyNodes atRandom origin;
			score: FiCommentDisagree new;
			message: 'Nasty';
			new.
		}.

	commentsStore := FiOmbuStore example.
	commentsStore forkedStore: anotherStore.
	commentsStore 
		commitSnapshot: 
			(FiCommentSet 
				targetStoreName: store name 
				comments: FiSet new)
		priors: anotherStore headHistoryNode priors.

	self assert: commentsStore headHistoryNode snapshot comments isEmpty.

	1 to: comments size do: [ :index |
		commentsStore 
			commitSnapshot: 
				(FiCommentSet 
					targetStoreName: store name
					comments: (comments first: index) asFiSet)
			priors: {commentsStore headHistoryNode} asFiSet.

		self assert: commentsStore headHistoryNode snapshot comments = ((comments first: index) asFiSet).
		].

	^ commentsStore
]
