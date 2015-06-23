"
I am an inspector for instances of FiChange.
"
Class {
	#name : #FiChangeInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'diffModel',
		'currentSelection',
		'plugin'
	],
	#category : #'FicusStore-UI-Widgets'
}

{ #category : #specs }
FiChangeInspector class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel origin: 0@0 corner: 1@0.6;
				addSplitter;
				add: #diffModel origin: 0@0.6 corner: 1@1];
		yourself.

]

{ #category : #specs }
FiChangeInspector class >> defaultSpecAsRow [
	<spec>
	
	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #treeModel origin: 0@0 corner: 0.3@1;
				addSplitter;
				add: #diffModel origin: 0.3@0 corner: 1@1];
		yourself.

]

{ #category : #inspecting }
FiChangeInspector class >> inspect: aChange [

	^ (self newWith: aChange) 
		open; 
		yourself
]

{ #category : #inspecting }
FiChangeInspector class >> newWith: aChange [

	^ self new
		plugin: FiNullStoreBrowserPlugin new;
		rootChange: aChange;
		yourself
]

{ #category : #private }
FiChangeInspector >> diffChunkMorphFor: aSimpleChange [

	| morphBuilder |
	morphBuilder := FiMorphBuilder default.

	^ morphBuilder columnMorphWithAll: { 
		morphBuilder pathMorphWith: aSimpleChange path.
		morphBuilder diffMorphFrom: aSimpleChange oldValueString to: aSimpleChange newValueString }
]

{ #category : #private }
FiChangeInspector >> diffChunkMorphsFor: aSimpleChange [

	^ Array
		streamContents: [ :stream |
			aSimpleChange relevantSimpleChangesDo: [ :each | 
				stream nextPut: (self diffChunkMorphFor: each) ] ] 
		limitedTo: 15
]

{ #category : #accessing }
FiChangeInspector >> diffModel [

	^ diffModel
]

{ #category : #private }
FiChangeInspector >> displayMorphFor: aSimpleChange [
		
	| morphs |
	morphs := OrderedCollection new.

	morphs add: aSimpleChange path step asMorph.
	
	self plugin 
		prepareChangeDescriptionMorphs: morphs 
		for: aSimpleChange.
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #initialization }
FiChangeInspector >> dragWith: aBlock [
	"Enable drag of selected items using the block to create the transport morph. 
	Follow my senders."
	
	treeModel
		dragEnabled: true;
		dropEnabled: false;
		transferBlock: [ :passenger :source | 
			aBlock 
				value: passenger 
				value: source 
				value: (treeModel selectedItems collect: #content) ].

]

{ #category : #initialization }
FiChangeInspector >> initializePresenter [
	
	super initializePresenter.
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Change Inspector'.
 
	self initializePresenterTreeModel.

	diffModel
		displayBlock: [ :morph | morph ]
]

{ #category : #initialization }
FiChangeInspector >> initializePresenterTreeModel [
	
	treeModel
		evenRowColor: treeModel oddRowColor;
		displayBlock: [ :aSimpleChange | self displayMorphFor: aSimpleChange ];
		childrenBlock: [ :aSimpleChange | aSimpleChange children asArray ];
		iconBlock: [ :aSimpleChange | aSimpleChange ficusInspectorIcon ];
		whenSelectedItemChanged: [ :aSimpleChangeOrNil | 
			self selected: aSimpleChangeOrNil value ];
		menu: [ :aMenu | self prepareMenu: aMenu ].
]

{ #category : #initialization }
FiChangeInspector >> initializeWidgets [ 

	self instantiateModels: #(
		treeModel TreeModel
		diffModel TreeModel )
]

{ #category : #opening }
FiChangeInspector >> open [

	self
		extent: 800@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #accessing }
FiChangeInspector >> plugin [

	^ plugin
]

{ #category : #accessing }
FiChangeInspector >> plugin: aPlugin [

	plugin := aPlugin.
	
	aPlugin announcer weak
		when: FiStoreBrowserPluginRefreshed 
		send: #pluginRefreshed
		to: self.
]

{ #category : #accessing }
FiChangeInspector >> pluginRefreshed [
	
	treeModel updateTree
]

{ #category : #private }
FiChangeInspector >> prepareMenu: aMenu [

	treeModel selectedItems ifNotEmpty: [ 
		self plugin prepareChangeMenu: aMenu ]
]

{ #category : #opening }
FiChangeInspector >> rootChange: anChange [

	treeModel deselectAll.
	treeModel roots: (self treeRootsFor: anChange).

	"treeModel expandRoots."
]

{ #category : #private }
FiChangeInspector >> selected: aChangeOrNil [ 

	self flag: #fix. "Workaround: Spec in Pharo3 triggers several times the same event."
	currentSelection = aChangeOrNil ifTrue: [ ^ self ].
	currentSelection := aChangeOrNil.

	"Transmit to plugin"
	self plugin selectedChange: aChangeOrNil. 
	self flag: #todo. "fix?"
	
	diffModel roots: 
		(aChangeOrNil 
			ifNil: [ #() ]
			ifNotNil: [ self diffChunkMorphsFor: aChangeOrNil ])
]

{ #category : #accessing }
FiChangeInspector >> treeModel [

	^ treeModel
]

{ #category : #private }
FiChangeInspector >> treeRootsFor: aChange [

	^ aChange asSimpleChanges asArray
	
]
