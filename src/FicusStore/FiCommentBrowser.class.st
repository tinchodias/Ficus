Class {
	#name : #FiCommentBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'commentsTreeModel',
		'plugin',
		'addButtonModel',
		'removeButtonModel',
		'targetHistoryNode'
	],
	#category : #'FicusStore-Comments-UI'
}

{ #category : #specs }
FiCommentBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #commentsTreeModel;
				newRow: [ :toolBar |
					toolBar 
						add: #addButtonModel;
						add: #removeButtonModel ] 
				height: self toolbarHeight ];
		yourself
]

{ #category : #accessing }
FiCommentBrowser >> addButtonModel [

	^ addButtonModel
]

{ #category : #accessing }
FiCommentBrowser >> commentsTreeModel [

	^ commentsTreeModel
]

{ #category : #initialization }
FiCommentBrowser >> initializePresenter [

	super initializePresenter.

	self title: 'Ficus Comments Browser'.

	commentsTreeModel 
		displayBlock: [ :aComment | self morphFor: aComment ].
		
	addButtonModel 
		label: 'Add';
		action: [ 
			| editor |
			editor := FiCommentEditor new 
				targetHistoryNode: targetHistoryNode;
				yourself.
				
			editor openDialogWithSpec 
				okAction: [ 
					plugin addComment: editor resultModel.
					self refresh ];
				modalRelativeTo: self window ].
		
	removeButtonModel 
		label: 'Remove';
		action: [ 
			commentsTreeModel selectedItems do: [ :each | 
				plugin removeComment: each content ].
			self refresh ].
	
]

{ #category : #initialization }
FiCommentBrowser >> initializeWidgets [

	self instantiateModels: #(
		commentsTreeModel 	TreeModel
		addButtonModel		ButtonModel
		removeButtonModel	ButtonModel).

]

{ #category : #private }
FiCommentBrowser >> morphFor: aComment [

	^ ((aComment score prettyPrintString asText 
			addAttribute: (TextFontChange fontNumber: 3); "bigger than normal"
"			addAttribute: (TextColor color: Color gray);"
			yourself), 
			String cr, 
			aComment contents) asText asMorph 
				lock: true; 
				yourself
]

{ #category : #accessing }
FiCommentBrowser >> plugin [

	^ plugin
]

{ #category : #accessing }
FiCommentBrowser >> plugin: aPlugin [

	plugin := aPlugin
]

{ #category : #refreshing }
FiCommentBrowser >> refresh [
	
	commentsTreeModel roots: (plugin commentsFor: targetHistoryNode).
]

{ #category : #accessing }
FiCommentBrowser >> removeButtonModel [

	^ removeButtonModel
]

{ #category : #accessing }
FiCommentBrowser >> targetHistoryNode: aNode [

	targetHistoryNode := aNode.
	self refresh.
]
