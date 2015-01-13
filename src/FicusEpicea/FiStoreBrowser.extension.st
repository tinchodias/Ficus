Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> exampleEpicea [
	"
	Gofer it package: #Tetris; load.
	self exampleEpicea.
	"

	^ self new
		store: (FiEpiceaStore forPackageNamed: #Tetris);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]
