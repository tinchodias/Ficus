Extension { #name : #FiCommentStoreBrowserPlugin }

{ #category : #'*FicusEpicea' }
FiCommentStoreBrowserPlugin classSide >> exampleOmbuStore [
	"
	self exampleOmbuStore.
	"

	| store mainPluginStore forkedPluginStore pluginWorkingCopy |
	store := FiMemoryStore exampleFragileBaseProblem.

	mainPluginStore := FiCommentSet exampleStoreFor: store.

	forkedPluginStore := 
		FiCommentSet 
			exampleOmbuStoreFor: store 
			forkFrom: mainPluginStore.

	pluginWorkingCopy := 
		forkedPluginStore newWorkingCopy
			name: 'Comments to ', store name;
			yourself.

	FiWorkingCopyRegistryBrowser openWith: 
		(FiWorkingCopyRegistry new 
			addWorkingCopy: store newWorkingCopy; 
			addWorkingCopy: pluginWorkingCopy; 
			yourself)
]
