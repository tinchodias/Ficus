Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusEpicea' }
FiStoreBrowser classSide >> example2 [
	"
	Gofer it package: #Tetris; load.
	self example2.
	"

	^ self new
		store: (FiEpiceaStore forPackageNamed: #Tetris);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]
