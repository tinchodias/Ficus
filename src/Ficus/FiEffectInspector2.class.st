Class {
	#name : #FiEffectInspector2,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName',
		'diffModel'
	],
	#category : #'Ficus-UI'
}

{ #category : #specs }
FiEffectInspector2 class >> defaultSpec [
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
FiEffectInspector2 class >> defaultSpecAsRow [
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
FiEffectInspector2 class >> inspect: rootEffect [

	^ (self newWith: rootEffect) open; yourself
]

{ #category : #inspecting }
FiEffectInspector2 class >> newWith: aRootEffect [

	^ self new
		rootEffect: aRootEffect;
		yourself
]

{ #category : #private }
FiEffectInspector2 >> columnMorphWithAll: someMophs [

	^ PanelMorph new
		changeTableLayout;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		listDirection: #topToBottom;
		cellPositioning: #topLeft;
		cellInset: 8;
		addAllMorphs: someMophs;
		yourself
]

{ #category : #private }
FiEffectInspector2 >> diffChunkMorphFor: aSummary at: aPath [ 

	^ self columnMorphWithAll: { 
		self pathMorphWith: aPath.
		self diffMorphFrom: aSummary oldValueString to: aSummary newValueString.
		}
]

{ #category : #accessing }
FiEffectInspector2 >> diffModel [

	^ diffModel
]

{ #category : #private }
FiEffectInspector2 >> diffMorphFrom: aString to: otherString [

"	^ (DiffMorph from: aString to: otherString)
			showOptions: false;
			width: 400;
			height: 200;
			yourself
"
	^ (TextDiffBuilder 
		buildDisplayPatchFrom: aString
		to: otherString) asMorph
		lock: true;
		yourself

]

{ #category : #private }
FiEffectInspector2 >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiEffectInspector2 >> initialize [

	super initialize.
	self initializeIconByClassName.	

]

{ #category : #initialization }
FiEffectInspector2 >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			at: #FiSummaryAdd put: #changeAddIcon;
			at: #FiSummaryRemove put: #changeRemoveIcon;
			at: #FiSummaryUpdate put: #changeUpdateIcon;
			yourself.
	
]

{ #category : #initialization }
FiEffectInspector2 >> initializePresenter [
	
	super initializePresenter.
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Effects Inspector'.
 
	treeModel
		evenRowColor: Color white;
		displayBlock: [ :summary | summary step ];
		childrenBlock: [ :summary | summary subSummary ];
		iconBlock: [ :summary | self iconFor: summary ];
		whenSelectedItemChanged: [ :summary | 
			self showDiffFor: summary value ].

	diffModel
		displayBlock: [ :morph | morph ]
]

{ #category : #initialization }
FiEffectInspector2 >> initializeWidgets [ 

	self instantiateModels: #(
		treeModel TreeModel
		diffModel TreeModel )
]

{ #category : #opening }
FiEffectInspector2 >> open [

	self
		extent: 800@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #private }
FiEffectInspector2 >> pathMorphWith: aPath [

	^ ('/' join: (aPath steps collect: #asString)) asMorph
"		emphasis: 1;"
		color: Color darkGray;
		yourself
]

{ #category : #opening }
FiEffectInspector2 >> rootEffect: anEffect [

	treeModel roots: (self treeRootsFor: anEffect).

	treeModel expandAll

]

{ #category : #private }
FiEffectInspector2 >> showDiffFor: anEffect [ 

	anEffect ifNil: [ ^ diffModel roots: #() ].
	
	diffModel roots: (Array 
		streamContents: [ :stream |
			anEffect
				leavesDo: [ :aLeafSummary :aPath | 
					stream nextPut: (self diffChunkMorphFor: aLeafSummary at: aPath) ]
				basePath: FiPath root ] 
		limitedTo: 15).
]

{ #category : #accessing }
FiEffectInspector2 >> treeModel [

	^ treeModel
]

{ #category : #private }
FiEffectInspector2 >> treeRootsFor: anEffect [

	| summary |
	summary := anEffect hierarchicalSummary.

	^ summary size = 1
		ifTrue: [ summary anyOne subSummary ] "TODO: avoiding #contents in a hacky way"
		ifFalse: [ summary ]
]
