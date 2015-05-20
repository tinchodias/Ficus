Extension { #name : #FiCommentStoreBrowserPlugin }

{ #category : #'*FicusMonticelloStore' }
FiCommentStoreBrowserPlugin classSide >> exampleMonticelloStore [
	"
	self exampleMonticelloStore.
	"

	| store pluginStore pluginWorkingCopy |
	store := FiMonticelloStore example.
	pluginStore := FiCommentSet exampleStoreFor: store.
	pluginWorkingCopy := 
		pluginStore newWorkingCopy
			name: 'Comments to ', store name;
			yourself.

	FiWorkingCopyRegistryBrowser openWith: 
		(FiWorkingCopyRegistry new 
			addWorkingCopy: store newWorkingCopy; 
			addWorkingCopy: pluginWorkingCopy; 
			yourself)
]
