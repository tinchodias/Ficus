"
I am an editor for an instance of FiComment.


self new openWithSpec.
"
Class {
	#name : #FiCommentEditor,
	#superclass : #ComposableModel,
	#instVars : [
		'scoreDropListModel',
		'contentsTextModel',
		'targetHistoryNode'
	],
	#category : #'FicusStore-Comments-UI'
}

{ #category : #specs }
FiCommentEditor class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #scoreDropListModel height: self buttonHeight;
				add: #contentsTextModel ]
		yourself
]

{ #category : #accessing }
FiCommentEditor >> contentsTextModel [

	^ contentsTextModel
]

{ #category : #initialization }
FiCommentEditor >> initializePresenter [

	self title: 'Ficus Comments Editor'.

	scoreDropListModel 
		items: {FiCommentAgree new. FiCommentDisagree new};
		displayBlock: [ :item | item prettyPrintString ].
		
	contentsTextModel 
		text: 'write a message';
		autoAccept: true.
]

{ #category : #initialization }
FiCommentEditor >> initializeWidgets [

	self instantiateModels: #(
		contentsTextModel 		TextModel
		scoreDropListModel 	DropListModel).

]

{ #category : #accessing }
FiCommentEditor >> resultModel [
	
	^ FiComment builder 
		target: targetHistoryNode origin;
		score: scoreDropListModel selectedItem;
		message: contentsTextModel text;
		new
]

{ #category : #accessing }
FiCommentEditor >> scoreDropListModel [

	^ scoreDropListModel
]

{ #category : #accessing }
FiCommentEditor >> targetHistoryNode: aNode [

	targetHistoryNode := aNode
]
