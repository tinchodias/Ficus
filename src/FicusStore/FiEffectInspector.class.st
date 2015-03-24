"
I am an inspector for instances of FiEffect.
"
Class {
	#name : #FiEffectInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName',
		'diffModel',
		'currentSelection',
		'plugin'
	],
	#category : #'FicusStore-UI-Widgets'
}

{ #category : #specs }
FiEffectInspector class >> defaultSpec [
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
FiEffectInspector class >> defaultSpecAsRow [
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
FiEffectInspector class >> inspect: rootEffect [

	^ (self newWith: rootEffect) 
		open; 
		yourself
]

{ #category : #inspecting }
FiEffectInspector class >> newWith: aRootEffect [

	^ self new
		plugin: FiNullStoreBrowserPlugin new;
		rootEffect: aRootEffect;
		yourself
]

{ #category : #private }
FiEffectInspector >> diffChunkMorphFor: aSimpleEffect [

	| morphBuilder |
	morphBuilder := FiMorphBuilder default.

	^ morphBuilder columnMorphWithAll: { 
		morphBuilder pathMorphWith: aSimpleEffect path.
		morphBuilder diffMorphFrom: aSimpleEffect oldValueString to: aSimpleEffect newValueString }
]

{ #category : #private }
FiEffectInspector >> diffChunkMorphsFor: aSimpleEffect [

	^ Array
		streamContents: [ :stream |
			aSimpleEffect relevantSimpleEffectsDo: [ :each | 
				stream nextPut: (self diffChunkMorphFor: each) ] ] 
		limitedTo: 15
]

{ #category : #accessing }
FiEffectInspector >> diffModel [

	^ diffModel
]

{ #category : #private }
FiEffectInspector >> displayMorphFor: aSimpleEffect [
		
	| morphs |
	morphs := OrderedCollection new.

	morphs add: aSimpleEffect path step asMorph.
	
	self plugin 
		prepareEffectInspectorTreeMorphs: morphs 
		for: aSimpleEffect.
	
	^ FiMorphBuilder default rowMorphWithAll: morphs
]

{ #category : #initialization }
FiEffectInspector >> dragWith: aBlock [
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
FiEffectInspector >> initializePresenter [
	
	super initializePresenter.
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Effects Inspector'.
 
	self initializePresenterTreeModel.

	diffModel
		displayBlock: [ :morph | morph ]
]

{ #category : #initialization }
FiEffectInspector >> initializePresenterTreeModel [
	
	treeModel
		evenRowColor: treeModel oddRowColor;
		displayBlock: [ :aSimpleEffect | self displayMorphFor: aSimpleEffect ];
		childrenBlock: [ :aSimpleEffect | aSimpleEffect children asArray ];
		iconBlock: [ :aSimpleEffect | aSimpleEffect ficusInspectorIcon ];
		autoDeselection:true;
		whenRootsChanged: [ 
			self flag: #fix. "Workaround: Spec in Pharo3 does not trigger that selection changed 
				when it changed due to roots update."
			self showDiffFor: nil ];
		whenSelectedItemChanged: [ :aSimpleEffectOrNil | 
			self showDiffFor: aSimpleEffectOrNil value ].
]

{ #category : #initialization }
FiEffectInspector >> initializeWidgets [ 

	self instantiateModels: #(
		treeModel TreeModel
		diffModel TreeModel )
]

{ #category : #opening }
FiEffectInspector >> open [

	self
		extent: 800@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #accessing }
FiEffectInspector >> plugin [

	^ plugin
]

{ #category : #accessing }
FiEffectInspector >> plugin: aPlugin [

	plugin := aPlugin
]

{ #category : #opening }
FiEffectInspector >> rootEffect: anEffect [

	treeModel roots: (self treeRootsFor: anEffect).

	treeModel expandAll

]

{ #category : #private }
FiEffectInspector >> showDiffFor: anEffectOrNil [ 

	self flag: #fix. "Workaround: Spec in Pharo3 triggers several times the same event."
	currentSelection = anEffectOrNil ifTrue: [ ^ self ].
	currentSelection := anEffectOrNil.

	diffModel roots: 
		(anEffectOrNil 
			ifNil: [ #() ]
			ifNotNil: [ self diffChunkMorphsFor: anEffectOrNil ])
]

{ #category : #accessing }
FiEffectInspector >> treeModel [

	^ treeModel
]

{ #category : #private }
FiEffectInspector >> treeRootsFor: anEffect [

	^ anEffect asSimpleEffects asArray
	
]
