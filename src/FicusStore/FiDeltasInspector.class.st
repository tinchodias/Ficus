"
I'm useful for inspecting FiHistoryNode's deltas.
"
Class {
	#name : #FiDeltasInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'deltasDropListModel',
		'changeInspector'
	],
	#category : #'FicusStore-UI-Widgets'
}

{ #category : #specs }
FiDeltasInspector class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed 
		newColumn: [ :column | 
			column
				add: #deltasDropListModel height: self buttonHeight;
				add: #changeInspector ];
		yourself
]

{ #category : #accessing }
FiDeltasInspector >> changeInspector [ 

	^ changeInspector
]

{ #category : #accessing }
FiDeltasInspector >> deltas: aCollectionOfAssociations [

	deltasDropListModel items: 
		(aCollectionOfAssociations
			ifEmpty: [ { 'No priors' -> FiNoChange new } ]
			ifNotEmpty: [ 
				aCollectionOfAssociations collect: [ :each | 
					'Prior: ', each key origin shortDescription -> each value ] ])
]

{ #category : #accessing }
FiDeltasInspector >> deltasDropListModel [

	^ deltasDropListModel
]

{ #category : #initialization }
FiDeltasInspector >> dragWith: aBlock [
	"Enable drag of selected items using the block to create the transport morph. 
	Follow my senders."
	
	changeInspector dragWith: aBlock
]

{ #category : #initialization }
FiDeltasInspector >> initializePresenter [

	super initializePresenter.

	deltasDropListModel 
		displayBlock: [ :association | association key ];
		whenSelectedItemChanged: [ :association | 
			association ifNotNil: [
				changeInspector rootChange: association value ] ]
]

{ #category : #initialization }
FiDeltasInspector >> initializeWidgets [

	self instantiateModels: #(
		deltasDropListModel DropListModel
		#changeInspector #FiChangeInspector).

]

{ #category : #accessing }
FiDeltasInspector >> plugin: aPlugin [

	changeInspector plugin: aPlugin
]
