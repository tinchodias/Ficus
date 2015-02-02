Class {
	#name : #FiDeltasInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'deltasDropListModel',
		'effectInspector'
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
				add: #effectInspector ];
		yourself
]

{ #category : #accessing }
FiDeltasInspector >> deltas: aCollectionOfAssociations [

	deltasDropListModel items: 
		(aCollectionOfAssociations
			ifEmpty: [ { 'No priors' -> FiNoEffect new } ]
			ifNotEmpty: [ 
				aCollectionOfAssociations collect: [ :each | 
					'Prior: ', each key origin shortDescription -> each value ] ])
]

{ #category : #accessing }
FiDeltasInspector >> deltasDropListModel [

	^ deltasDropListModel
]

{ #category : #accessing }
FiDeltasInspector >> effectInspector [ 

	^ effectInspector
]

{ #category : #initialization }
FiDeltasInspector >> initializePresenter [

	super initializePresenter.

	deltasDropListModel 
		displayBlock: [ :association | association key ];
		whenSelectedItemChanged: [ :association | 
			association ifNotNil: [
				effectInspector rootEffect: association value ] ]
]

{ #category : #initialization }
FiDeltasInspector >> initializeWidgets [

	self instantiateModels: #(
		deltasDropListModel DropListModel
		effectInspector FiEffectInspector).

]

{ #category : #accessing }
FiDeltasInspector >> plugin: aPlugin [

	effectInspector plugin: aPlugin
]
