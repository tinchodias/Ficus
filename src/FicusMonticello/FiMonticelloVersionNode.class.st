Class {
	#name : #FiMonticelloVersionNode,
	#superclass : #Object,
	#instVars : [
		'versionName',
		'versionInfo',
		'ancestors',
		'children'
	],
	#category : #'FicusMonticello-Graph'
}

{ #category : #'instance creation' }
FiMonticelloVersionNode class >> for: aMCVersionInfo [ 
	^ self new
		versionInfo: aMCVersionInfo;
		yourself
]

{ #category : #'instance creation' }
FiMonticelloVersionNode class >> named: aString [ 
	^ self new
		versionName: aString;
		yourself
]

{ #category : #accessing }
FiMonticelloVersionNode >> addChild: aHiVersionInfoNode [ 
	
	children add: aHiVersionInfoNode
]

{ #category : #accessing }
FiMonticelloVersionNode >> ancestors [
	^ ancestors
]

{ #category : #accessing }
FiMonticelloVersionNode >> ancestors: aCollection [

	ancestors do: [ :each | each removeChild: self ].

	ancestors := aCollection.

	ancestors do: [ :each | each addChild: self ].

	self changed.
]

{ #category : #accessing }
FiMonticelloVersionNode >> author [
	^ (versionName copyAfter: $-) copyUpTo: $.
]

{ #category : #accessing }
FiMonticelloVersionNode >> children [
	^ children
]

{ #category : #accessing }
FiMonticelloVersionNode >> date [
	^ versionInfo 
		ifNil: [ Date today ] 
		ifNotNil: [ versionInfo date ].
]

{ #category : #initialization }
FiMonticelloVersionNode >> initialize [ 	
	super initialize.
	
	ancestors := Set new.
	children := Set new.
]

{ #category : #accessing }
FiMonticelloVersionNode >> message [
	^ versionInfo 
		ifNil: [ 'unknown'] 
		ifNotNil: [ versionInfo message ]
]

{ #category : #accessing }
FiMonticelloVersionNode >> name [
	^ versionName
]

{ #category : #printing }
FiMonticelloVersionNode >> printOn: aStream [ 
	super printOn: aStream. 
	
	aStream 
		nextPut: $(;
		nextPutAll: versionName;
		space;
		nextPutAll: (versionInfo ifNil: ['absent'] ifNotNil: ['present']);
		nextPut: $)
]

{ #category : #accessing }
FiMonticelloVersionNode >> removeChild: aHiVersionInfoNode [ 
	
	children remove: aHiVersionInfoNode
]

{ #category : #accessing }
FiMonticelloVersionNode >> versionInfo [
	^ versionInfo
]

{ #category : #accessing }
FiMonticelloVersionNode >> versionInfo: aMCVersionInfo [ 
	versionInfo := aMCVersionInfo.
	self versionName: aMCVersionInfo name.
	self changed.
]

{ #category : #accessing }
FiMonticelloVersionNode >> versionName: aString [ 
	versionName := aString
]
