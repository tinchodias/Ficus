Extension { #name : #LGitRevwalk }

{ #category : #'*EpiceaFicus' }
LGitRevwalk >> pushCommit: aCommit [
	self withReturnHandlerDo: [
		self
			revwalk_push: self 
			commit_id: aCommit id ]
]

{ #category : #'*EpiceaFicus' }
LGitRevwalk >> revwalk_push: walk commit_id: commitId [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	^ self
		call: #(LGitReturnCodeEnum git_revwalk_push(self, LGitId * commitId))
		options: #(  )
]
