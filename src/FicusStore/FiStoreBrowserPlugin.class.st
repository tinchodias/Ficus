"
I am an abstract plugin for a FiStoreBrowser.
"
Class {
	#name : #FiStoreBrowserPlugin,
	#superclass : #Object,
	#instVars : [
		'announcer'
	],
	#category : #'FicusStore-UI-Others'
}

{ #category : #private }
FiStoreBrowserPlugin >> announceRefreshed [

	self announcer announce: FiStoreBrowserPluginRefreshed new
]

{ #category : #accessing }
FiStoreBrowserPlugin >> announcer [ 

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
FiStoreBrowserPlugin >> prepareDescriptionMorphs: morphs for: aHistoryNode [

]

{ #category : #accessing }
FiStoreBrowserPlugin >> prepareEffectInspectorTreeMorphs: morphs for: aSimpleEffect [

]

{ #category : #accessing }
FiStoreBrowserPlugin >> selectedHistoryNode: aHistoryNode [
]
