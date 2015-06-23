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
FiStoreBrowserPlugin >> prepareChangeDescriptionMorphs: morphs for: aSimpleChange [
]

{ #category : #accessing }
FiStoreBrowserPlugin >> prepareChangeMenu: aMenuModel [

]

{ #category : #accessing }
FiStoreBrowserPlugin >> prepareHistoryNodeDescriptionMorphs: morphs for: aHistoryNode [

]

{ #category : #accessing }
FiStoreBrowserPlugin >> prepareHistoryNodeMenu: aMenuModel [

]

{ #category : #accessing }
FiStoreBrowserPlugin >> selectedChange: aSimpleChangeOrNil [
]

{ #category : #accessing }
FiStoreBrowserPlugin >> selectedHistoryNodes: aHistoryNode [
]
