Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> exampleEpiceaFicusStore [
	"
	self exampleEpiceaFicusStore.
	"

	^ self new
		store: (FiEpiceaStore forPackageNamed: #FicusStore);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> exampleEpiceaTetris [
	"
	Gofer it package: #Tetris; load.
	self exampleEpiceaTetris.
	"

	^ self new
		store: (FiEpiceaStore forPackageNamed: #Tetris);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]
