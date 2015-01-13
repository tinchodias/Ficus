Extension { #name : #FiStoreBrowser }

{ #category : #'*FicusMonticello' }
FiStoreBrowser classSide >> exampleMonticello [
	"
	self exampleMonticello
	"


	^ self new
		store: (FiMonticelloStore forPackageNamed: #Tetris);
		plugin: FiNullStoreBrowserPlugin new;
		refresh;
		openWithSpec;
		yourself


]
